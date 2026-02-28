#!/usr/bin/env python3

import numpy as np
from numpy import linalg as LA

import rospy
from geometry_msgs.msg import Twist
from std_srvs.srv import Empty, SetBool, SetBoolRequest  
from geometry_msgs.msg import PoseStamped, PoseWithCovarianceStamped
from robotics_project.srv import MoveHead, MoveHeadRequest, MoveHeadResponse
from play_motion_msgs.msg import PlayMotionAction, PlayMotionGoal
from sensor_msgs.msg import JointState

from actionlib import SimpleActionClient
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from nav_msgs.msg import Odometry

from moveit_msgs.msg import MoveItErrorCodes
moveit_error_dict = {}
for name in MoveItErrorCodes.__dict__.keys():
    if not name[:1] == '_':
        code = MoveItErrorCodes.__dict__[name]
        moveit_error_dict[code] = name
        
from gazebo_msgs.srv import GetModelState, GetModelStateRequest
# Alternative: subscribe to /gazebo/model_states
from gazebo_msgs.msg import ModelStates
from actionlib_msgs.msg import GoalStatus
import tf2_ros
from tf2_geometry_msgs import do_transform_pose
import math

class StateMachine(object):
    def __init__(self):
        
        self.node_name = "Student SM"
        
        self.tfBuffer = tf2_ros.Buffer()
        self.tfListener = tf2_ros.TransformListener(self.tfBuffer)

        # Access rosparams
        self.cmd_vel_top = rospy.get_param(rospy.get_name() + '/cmd_vel_topic')
        self.mv_head_srv_nm = rospy.get_param(rospy.get_name() + '/move_head_srv')
        self.pick_pose_topic = rospy.get_param(rospy.get_name() + '/pick_pose_topic')
        self.place_pose_topic = rospy.get_param(rospy.get_name() + '/place_pose_topic')
        self.pick_srv_nm = rospy.get_param(rospy.get_name() + "/pick_srv")
        self.place_srv_nm = rospy.get_param(rospy.get_name() + "/place_srv")
        self.aruco_pose_top = rospy.get_param(rospy.get_name() + '/marker_pose_topic')
        
        self.pick_pose = None
        self.place_pose = None
        self.current_odom = None
        self.current_amcl_pose = None

        # Subscribe to topics (such as pick and place poses, odometry and amcl pose estimation)
        self.pick_pose_sub = rospy.Subscriber(self.pick_pose_topic, PoseStamped, self.pick_pose_callback)
        self.place_pose_sub = rospy.Subscriber(self.place_pose_topic, PoseStamped, self.place_pose_callback)
        self.odom_sub = rospy.Subscriber("/odom", Odometry, self.odom_callback)
        self.pose_sub = rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, self.pose_callback)
        
        # Alternative: subscribe to /gazebo/model_states
        self.cube_pose = None
        self.model_states_sub = rospy.Subscriber("/gazebo/model_states", ModelStates, self.model_states_cb)

        # self.aruco_cube_srv_nm = rospy.get_param(rospy.get_name() + '/marker_pose_topic')

        # Wait for service providers
        rospy.wait_for_service(self.mv_head_srv_nm, timeout=30)
        rospy.wait_for_service("/gazebo/get_model_state", timeout=30)
        # We can initialize ServiceProxy for aruco cube pose inside __init__():
        self.get_model_state = rospy.ServiceProxy("/gazebo/get_model_state", GetModelState)
        rospy.wait_for_service(self.pick_srv_nm, timeout=30)
        rospy.wait_for_service(self.place_srv_nm, timeout=30)

        # Instantiate publishers
        self.cmd_vel_pub = rospy.Publisher(self.cmd_vel_top, Twist, queue_size=10)
        self.cube_pose_pub = rospy.Publisher(self.aruco_pose_top, PoseStamped, queue_size=10)

        # Set up action clients
        rospy.loginfo("%s: Waiting for play_motion action server...", self.node_name)
        self.play_motion_ac = SimpleActionClient("/play_motion", PlayMotionAction)
        if not self.play_motion_ac.wait_for_server(rospy.Duration(1000)):
            rospy.logerr("%s: Could not connect to /play_motion action server", self.node_name)
            exit()
        rospy.loginfo("%s: Connected to play_motion action server", self.node_name)

        rospy.loginfo("%s: Waiting for move_base action server...", self.node_name)
        self.move_base_ac = SimpleActionClient("/move_base", MoveBaseAction)
        if not self.move_base_ac.wait_for_server(rospy.Duration(1000)):
            rospy.logerr("%s: Could not connect to /move_base action server", self.node_name)
            exit()
        rospy.loginfo("%s: Connected to move_base action server", self.node_name)

        # Init state machine
        self.state = 0
        rospy.sleep(3)
        self.check_states()

    def pick_pose_callback(self, msg):
        self.pick_pose = msg

    def place_pose_callback(self, msg):
        self.place_pose = msg

    def odom_callback(self, msg):
        self.current_odom = msg

    def pose_callback(self, msg):
        self.current_amcl_pose = msg
        
    def get_cube_pose(self, reference_frame="map"):
        req = GetModelStateRequest()
        req.model_name = "aruco_cube"
        req.relative_entity_name = reference_frame  # "map", "world", etc.

        res = self.get_model_state(req)
        if not res.success:
            rospy.logerr("GetModelState failed: %s", res.status_message)
            return None
    
        # res.pose is geometry_msgs/Pose
        return res.pose

    # Alternative: subscribe to /gazebo/model_states
    def model_states_cb(self, msg):
        if "aruco_cube" in msg.name:
            i = msg.name.index("aruco_cube")
            self.cube_pose = msg.pose[i]   # geometry_msgs/Pose

    def creep_to_pick_pose(self,
                        goal_xy_tol=0.10,   # 10 cm
                        goal_yaw_tol=0.25,  # ~14 degrees
                        v_max=0.15,         # m/s
                        w_max=0.6,          # rad/s
                        timeout_s=15.0):
        """
        Drive the base slowly to self.pick_pose using /cmd_vel (no move_base).
        Assumes self.pick_pose is in the 'map' frame (or at least TF-reachable).
        """
        if self.pick_pose is None:
            rospy.logerr("%s: No pick_pose received.", self.node_name)
            return False

        rate = rospy.Rate(20)
        t0 = rospy.Time.now()

        while not rospy.is_shutdown():
            # timeout
            if (rospy.Time.now() - t0).to_sec() > timeout_s:
                self.cmd_vel_pub.publish(Twist())
                rospy.logerr("%s: creep_to_pick_pose timed out.", self.node_name)
                return False

            # Transform goal into robot frame so x=forward, y=left
            try:
                transform = self.tfBuffer.lookup_transform(
                    "base_footprint",                  # target frame
                    self.pick_pose.header.frame_id,    # source frame (usually 'map')
                    rospy.Time(0),
                    rospy.Duration(0.2)
                )
                goal_in_base = do_transform_pose(self.pick_pose, transform)
            except (tf2_ros.LookupException, tf2_ros.ExtrapolationException, tf2_ros.ConnectivityException):
                rate.sleep()
                continue

            dx = goal_in_base.pose.position.x
            dy = goal_in_base.pose.position.y
            dist = math.hypot(dx, dy)

            # yaw error: where the goal is relative to robot forward axis
            yaw_err = math.atan2(dy, dx)

            # check convergence
            if dist < goal_xy_tol and abs(yaw_err) < goal_yaw_tol:
                self.cmd_vel_pub.publish(Twist())
                rospy.loginfo("%s: Reached pick pose (manual).", self.node_name)
                return True

            # simple proportional control (clamped)
            cmd = Twist()

            # rotate more when heading is off
            cmd.angular.z = max(-w_max, min(w_max, 1.2 * yaw_err))

            # only drive forward/back when roughly facing the goal
            if abs(yaw_err) < 0.6:  # ~35 deg
                cmd.linear.x = max(-v_max, min(v_max, 0.6 * dist))
            else:
                cmd.linear.x = 0.0

            self.cmd_vel_pub.publish(cmd)
            rate.sleep()


    def publish_cube_pose_for_pick(self, cube_pose_in_map):

        tfm = self.tfBuffer.lookup_transform(
            "base_footprint",
            cube_pose_in_map.header.frame_id,
            rospy.Time(0),
            rospy.Duration(0.5)
        )

        cube_in_base = do_transform_pose(cube_pose_in_map, tfm)

        cube_in_base.header.frame_id = "base_footprint"
        cube_in_base.header.stamp = rospy.Time.now()

        rospy.loginfo("Cube in base frame: x=%.3f y=%.3f z=%.3f",
                    cube_in_base.pose.position.x,
                    cube_in_base.pose.position.y,
                    cube_in_base.pose.position.z)

        self.cube_pose_pub.publish(cube_in_base)
        rospy.sleep(1.0)  # small delay to ensure it is received
        
    def check_states(self):
        
        while not rospy.is_shutdown() and self.state != 4:
            
            # State 0: Move the robot "manually" to door
            # if self.state == 0:
            #     move_msg = Twist()
            #     move_msg.linear.x = -1.0 # negative linear velocity to move backwards
            #     move_msg.angular.z = 0.0

            #     rate = rospy.Rate(10)
            #     converged = False
            #     cnt = 0
            #     rospy.loginfo("%s: Moving backwards", self.node_name)
            #     while not rospy.is_shutdown() and cnt < 5:
            #         self.cmd_vel_pub.publish(move_msg)
            #         rate.sleep()
            #         cnt = cnt + 1

            #     # Stop the robot after moving
            #     self.cmd_vel_pub.publish(Twist())

            #     self.state = 1
            #     rospy.sleep(1)
            
            # if self.state == 1:
            #     rospy.loginfo("%s: Creeping/Moving to pick pose using /cmd_vel", self.node_name)
            #     ok = self.creep_to_pick_pose(timeout_s=20.0)
            #     self.state = 2 if ok else 5
    
            # move the robot to the pick pose:
            # To move TIAGo to pick pose, we should send that pose as a MoveBaseGoal to the move_base action server (and not publish /cmd_vel).
            # if self.state == 1:
            #     rospy.loginfo("%s: Moving to pick pose", self.node_name)
            #     goal = MoveBaseGoal()
            #     goal.target_pose = self.pick_pose
            #     self.move_base_ac.send_goal(goal)
            #     # success = self.move_base_ac.wait_for_result(rospy.Duration(100.0))
                
            #     # if success:
            #     #     rospy.loginfo("%s: Move to pick pose succeeded!", self.node_name)
            #     #     self.state = 2
            #     # else:
            #     #     self.move_base_ac.cancel_goal()
            #     #     rospy.logerr("%s: Move to pick pose failed!", self.node_name)
            #     #     self.state = 5
            #     finished = self.move_base_ac.wait_for_result(rospy.Duration(100.0))
            #     if not finished:
            #         self.move_base_ac.cancel_goal()
            #         rospy.logerr("%s: Move to pick pose TIMED OUT", self.node_name)
            #         self.state = 5
            #     else:
            #         state = self.move_base_ac.get_state()
            #         if state == GoalStatus.SUCCEEDED:
            #             rospy.loginfo("%s: Move to pick pose succeeded!", self.node_name)
            #             self.state = 1
            #         else:
            #             rospy.logerr("%s: Move_base failed (state=%d). Not at pick pose.", self.node_name, state)
            #             self.state = 5

            # # State 1:  Tuck arm 
            if self.state == 0:
                rospy.loginfo("%s: Tucking the arm...", self.node_name)
                rospy.loginfo("%s: Pick pose...", self.pick_pose)
                cube_pose = self.get_cube_pose("map")
                if cube_pose:
                    rospy.loginfo("Cube position: x=%f y=%f z=%f", cube_pose.position.x, cube_pose.position.y, cube_pose.position.z)                
                rospy.loginfo("Pick pose position: x=%f y=%f z=%f", self.pick_pose.pose.position.x, self.pick_pose.pose.position.y, self.pick_pose.pose.position.z)                
                
                goal = PlayMotionGoal()
                goal.motion_name = 'home' # "home" is a predefined motion that TIAGo can execute to tuck its arm. You can check the available motions in the file /play_motion/config/predefined_motions.yaml
                goal.skip_planning = True # this will make the robot move its arm in a predefined way, without checking for collisions. Use with caution!
                self.play_motion_ac.send_goal(goal)
                success_tucking = self.play_motion_ac.wait_for_result(rospy.Duration(100.0))

                if success_tucking:
                    rospy.loginfo("%s: Arm tuck succeeded!", self.play_motion_ac.get_result())
                    self.state = 1
                else:
                    self.play_motion_ac.cancel_goal()
                    rospy.logerr("%s: play_motion failed to tuck arm, reset simulation", self.node_name)
                    self.state = 5

                rospy.sleep(1)

            # OBS! If we are not using camera detection, we must publish the cube pose ourselves before calling the pick service.
            # Convert it to PoseStamped
            #   - Obtain the cube pose from Gazebo using: /gazebo/get_model_state
            #   - Set header.frame_id = "map" (or correct frame)
            #   - Publish it on the topic that ManipulateAruco is listening to - Find which topic it listens to by looking at the code of ManipulateAruco (in manipulation_client.py). This is the topic that the pick service will read to get the cube pose.
            #   - Then call the pick service
            # Call the pick service to pick up the cube:
            if self.state == 1:
                try:
                    rospy.loginfo("%s: Pick up", self.node_name)
                    
                    cube_pose = self.get_cube_pose("map")
                    if cube_pose:
                        cube_msg = PoseStamped()
                        cube_msg.header.stamp = rospy.Time.now()
                        cube_msg.header.frame_id = "map"
                        cube_msg.pose = cube_pose
                        
                        self.publish_cube_pose_for_pick(cube_msg)
                        
                        # self.cube_pose_pub.publish(cube_msg)
                        rospy.sleep(1.0)  # small delay to ensure it is received

                    pick_srv = rospy.ServiceProxy(self.pick_srv_nm, SetBool)
                    pick_req = pick_srv(True)
                    
                    if pick_req.success == True:
                        rospy.loginfo("%s: Pick up succeeded!", self.node_name)
                        self.state = 2
                    else:
                        rospy.logerr("%s: Pick up failed", self.node_name)
                        self.state = 5
                        
                    rospy.sleep(3)
                    
                except rospy.ServiceException as e:
                    print("Service call to pick server failed: %s"%e)



                
            # # State 2:  Move the robot "manually" to chair
            # if self.state == 2:
            #     move_msg = Twist()
            #     move_msg.angular.z = -1

            #     rate = rospy.Rate(10)
            #     converged = False
            #     cnt = 0
            #     rospy.loginfo("%s: Moving towards table", self.node_name)
            #     while not rospy.is_shutdown() and cnt < 5:
            #         self.cmd_vel_pub.publish(move_msg)
            #         rate.sleep()
            #         cnt = cnt + 1

            #     move_msg.linear.x = 1
            #     move_msg.angular.z = 0
            #     cnt = 0
            #     while not rospy.is_shutdown() and cnt < 15:
            #         self.cmd_vel_pub.publish(move_msg)
            #         rate.sleep()
            #         cnt = cnt + 1

            #     self.state = 3
            #     rospy.sleep(1)

            # State 3:  Lower robot head service
            if self.state == 2:
                try:
                    rospy.loginfo("%s: Lowering robot head", self.node_name)
                    move_head_srv = rospy.ServiceProxy(self.mv_head_srv_nm, MoveHead)
                    move_head_req = move_head_srv("down") # or "up"
                    
                    if move_head_req.success == True:
                        self.state = 5
                        rospy.loginfo("%s: Move head down succeded!", self.node_name)
                    else:
                        rospy.loginfo("%s: Move head down failed!", self.node_name)
                        self.state = 5

                    rospy.sleep(3)

                except rospy.ServiceException as e:
                    print("Service call to move_head server failed: %s"%e)

            # Error handling
            if self.state == 5:
                rospy.logerr("%s: State machine failed. Check your code and try again!", self.node_name)
                return

        rospy.loginfo("%s: State machine finished!", self.node_name)
        return


# import py_trees as pt, py_trees_ros as ptr

# class BehaviourTree(ptr.trees.BehaviourTree):

# 	def __init__(self):

# 		rospy.loginfo("Initialising behaviour tree")

# 		# go to door until at door
# 		b0 = pt.composites.Selector(
# 			name="Go to door fallback", 
# 			children=[Counter(30, "At door?"), Go("Go to door!", 1, 0)]
# 		)

# 		# tuck the arm
# 		b1 = TuckArm()

# 		# go to table
# 		b2 = pt.composites.Selector(
# 			name="Go to table fallback",
# 			children=[Counter(5, "At table?"), Go("Go to table!", 0, -1)]
# 		)

# 		# move to chair
# 		b3 = pt.composites.Selector(
# 			name="Go to chair fallback",
# 			children=[Counter(13, "At chair?"), Go("Go to chair!", 1, 0)]
# 		)

# 		# lower head
# 		b4 = LowerHead()

# 		# become the tree
# 		tree = pt.composites.Sequence(name="Main sequence", children=[b0, b1, b2, b3, b4])
# 		super(BehaviourTree, self).__init__(tree)

# 		# execute the behaviour tree
# 		self.setup(timeout=10000)
# 		while not rospy.is_shutdown(): self.tick_tock(1)


# class Counter(pt.behaviour.Behaviour):

# 	def __init__(self, n, name):

# 		# counter
# 		self.i = 0
# 		self.n = n

# 		# become a behaviour
# 		super(Counter, self).__init__(name)

# 	def update(self):

# 		# count until n
# 		while self.i <= self.n:

# 			# increment count
# 			self.i += 1

# 			# return failure :(
# 			return pt.common.Status.FAILURE

# 		# succeed after counter done :)
# 		return pt.common.Status.SUCCESS


# class Go(pt.behaviour.Behaviour):

# 	def __init__(self, name, linear, angular):

# 		# action space
# 		self.cmd_vel_top = rospy.get_param(rospy.get_name() + '/cmd_vel_topic')
# 		self.cmd_vel_pub = rospy.Publisher(self.cmd_vel_top, Twist, queue_size=10)

# 		# command
# 		self.move_msg = Twist()
# 		self.move_msg.linear.x = linear
# 		self.move_msg.angular.z = angular

# 		# become a behaviour
# 		super(Go, self).__init__(name)

# 	def update(self):

# 		# send the message
# 		rate = rospy.Rate(10)
# 		self.cmd_vel_pub.publish(self.move_msg)
# 		rate.sleep()

# 		# tell the tree that you're running
# 		return pt.common.Status.RUNNING


# class TuckArm(pt.behaviour.Behaviour):

# 	def __init__(self):

# 		# Set up action client
# 		self.play_motion_ac = SimpleActionClient("/play_motion", PlayMotionAction)

# 		# personal goal setting
# 		self.goal = PlayMotionGoal()
# 		self.goal.motion_name = 'home'
# 		self.goal.skip_planning = True

# 		# execution checker
# 		self.sent_goal = False
# 		self.finished = False

# 		# become a behaviour
# 		super(TuckArm, self).__init__("Tuck arm!")

# 	def update(self):

# 		# already tucked the arm
# 		if self.finished: 
# 			return pt.common.Status.SUCCESS
		
# 		# command to tuck arm if haven't already
# 		elif not self.sent_goal:

# 			# send the goal
# 			self.play_motion_ac.send_goal(self.goal)
# 			self.sent_goal = True

# 			# tell the tree you're running
# 			return pt.common.Status.RUNNING

# 		# if I was succesful! :)))))))))
# 		elif self.play_motion_ac.get_result():

# 			# than I'm finished!
# 			self.finished = True
# 			return pt.common.Status.SUCCESS

# 		# if I'm still trying :|
# 		else:
# 			return pt.common.Status.RUNNING
		


# class LowerHead(pt.behaviour.Behaviour):

# 	def __init__(self):

# 		# server
# 		mv_head_srv_nm = rospy.get_param(rospy.get_name() + '/move_head_srv')
# 		self.move_head_srv = rospy.ServiceProxy(mv_head_srv_nm, MoveHead)
# 		rospy.wait_for_service(mv_head_srv_nm, timeout=30)

# 		# execution checker
# 		self.tried = False
# 		self.tucked = False

# 		# become a behaviour
# 		super(LowerHead, self).__init__("Lower head!")

# 	def update(self):

# 		# try to tuck head if haven't already
# 		if not self.tried:

# 			# command
# 			self.move_head_req = self.move_head_srv("down")
# 			self.tried = True

# 			# tell the tree you're running
# 			return pt.common.Status.RUNNING

# 		# react to outcome
# 		else: return pt.common.Status.SUCCESS if self.move_head_req.success else pt.common.Status.FAILURE


	

if __name__ == "__main__":

	rospy.init_node('main_state_machine')
	try:
		#StateMachine()
		StateMachine()
	except rospy.ROSInterruptException:
		pass

	rospy.spin()

