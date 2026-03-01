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
        
from actionlib_msgs.msg import GoalStatus

class StateMachine(object):
    def __init__(self):
        
        self.node_name = "Student SM"
        
        # Access rosparams
        self.cmd_vel_top = rospy.get_param(rospy.get_name() + '/cmd_vel_topic')
        self.mv_head_srv_nm = rospy.get_param(rospy.get_name() + '/move_head_srv')
        self.pick_pose_topic = rospy.get_param(rospy.get_name() + '/pick_pose_topic')
        self.place_pose_topic = rospy.get_param(rospy.get_name() + '/place_pose_topic')
        self.pick_srv_nm = rospy.get_param(rospy.get_name() + "/pick_srv")
        self.place_srv_nm = rospy.get_param(rospy.get_name() + "/place_srv")
        self.aruco_pose_top = rospy.get_param(rospy.get_name() + '/aruco_pose_topic')
        
        self.pick_pose = None
        self.place_pose = None
        self.current_odom = None
        self.current_amcl_pose = None

        # Subscribe to topics (such as pick and place poses, odometry and amcl pose estimation)
        self.pick_pose_sub = rospy.Subscriber(self.pick_pose_topic, PoseStamped, self.pick_pose_callback)
        self.place_pose_sub = rospy.Subscriber(self.place_pose_topic, PoseStamped, self.place_pose_callback)
        self.odom_sub = rospy.Subscriber("/odom", Odometry, self.odom_callback)
        self.pose_sub = rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, self.pose_callback)
        
        # Get Cube - use the cube_pose param directly and publish it to the marker_pose_topic before calling the pick service.
        cube_str = rospy.get_param(rospy.get_name() + '/cube_pose')
        cube_vals = [float(v) for v in cube_str.split(',')]
        self.cube_pose_param = cube_vals # contains [x, y, z, qx, qy, qz, qw]

        # Wait for service providers
        rospy.wait_for_service(self.mv_head_srv_nm, timeout=30)
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
        
    def publish_cube_pose_from_param(self):
        cube = PoseStamped()
        cube.header.stamp = rospy.Time.now()
        cube.header.frame_id = "base_footprint"   # IMPORTANT

        cube.pose.position.x = self.cube_pose_param[0] + 0.03
        cube.pose.position.y = self.cube_pose_param[1]
        cube.pose.position.z = self.cube_pose_param[2]

        cube.pose.orientation.x = self.cube_pose_param[3]
        cube.pose.orientation.y = self.cube_pose_param[4]
        cube.pose.orientation.z = self.cube_pose_param[5]
        cube.pose.orientation.w = self.cube_pose_param[6]

        rospy.loginfo("Publishing cube pose taken directly from launch_project.launch param")

        self.cube_pose_pub.publish(cube)
        rospy.sleep(1)
        
    def check_states(self):
        
        while not rospy.is_shutdown() and self.state != 99:
            
            # State 0:  Tuck arm 
            if self.state == 0:
                rospy.loginfo("%s: Tucking the arm...", self.node_name)
           
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
                    self.state = -1

                rospy.sleep(1)

            # OBS! If we are not using camera detection (visual sensing), we must publish the cube pose directly ourselves before calling the pick service.
            # State 1: Pick up the cube using the pick service.
            # Convert the cube pose to PoseStamped and publish to ManipulateAruco pick topic (marker_pose_topic).
            #   - Obtain the cube pose from Gazebo using: /gazebo/get_model_state or directly from the launch file as a known param (recommended, simpler and more robust)
            #   - Set header.frame_id = "map" (or correct frame "base_footprint")
            #   - Publish it on the topic that ManipulateAruco is listening to - Find which topic it listens to by looking at the code of ManipulateAruco (in manipulation_client.py). This is the topic that the pick service will read to get the cube pose. It's the value of the param /marker_pose_topic in launch_project.launch. 
            #   - Then call the pick service to pick up the cube.
            if self.state == 1:
                try:                    
                    rospy.loginfo("Publishing cube pose (param) before pick")
                    
                    self.publish_cube_pose_from_param()
                    rospy.sleep(1.0)  # small delay to ensure it is received
                    
                    rospy.loginfo("%s: Pick up", self.node_name)

                    pick_srv = rospy.ServiceProxy(self.pick_srv_nm, SetBool)
                    pick_req = pick_srv(True)
                    
                    if pick_req.success == True:
                        rospy.loginfo("%s: Pick up succeeded!", self.node_name)
                        self.state = 2
                    else:
                        rospy.logerr("%s: Pick up failed", self.node_name)
                        self.state = -1
                        
                    rospy.sleep(3)
                    
                except rospy.ServiceException as e:
                    print("Service call to pick server failed: %s"%e)

            # State 2: move the robot to the second table:
            if self.state == 2:
                rospy.loginfo("%s: Turning and driving toward other table", self.node_name)

                # tuple in move_list --> (linear.x, angular.z, max_cnt)
                #       step 1) Twist 180 degrees to avoid table collision
                #       step 2) Take steps forward, to E table 
                
                rate = rospy.Rate(10)
                move_msg = Twist()
                move_list = [(0, -1, 30), (1, 0, 8)] # move_list[0] turn around, move_list[1] move forward to table
                for step in move_list:
                    move_msg.linear.x = step[0]          # move robot backwards or forwards
                    move_msg.angular.z = step[1]         # twist angular pose. counter clockwise (+ = left, - = right)
                    cnt = 0
                    while not rospy.is_shutdown() and cnt < step[2]:
                        self.cmd_vel_pub.publish(move_msg)
                        rate.sleep()
                        cnt = cnt + 1
                
                self.state = 3                
                rospy.sleep(1)                            
                   
            # State 3: Place the cube on the second table using the place service   
            if self.state == 3:
                try:                    
                    rospy.loginfo("%s: Place", self.node_name)

                    place_srv = rospy.ServiceProxy(self.place_srv_nm, SetBool)
                    place_req = place_srv(True)
                    
                    if place_req.success == True:
                        rospy.loginfo("%s: Place succeeded!", self.node_name)
                        self.state = 4
                    else:
                        rospy.logerr("%s: Place failed", self.node_name)
                        self.state = -1
                        
                    rospy.sleep(3)
                    
                except rospy.ServiceException as e:
                    print("Service call to place server failed: %s"%e)

            # State 4: Take some steps backward to tuck arm without colliding with the table and Tuck arm 
            if self.state == 4:
                rospy.loginfo("%s: Moving backwards to avoid table collision while tucking arm", self.node_name)
                
                move_msg = Twist()
                move_list = [(-1, 0, 6)]
            
                for step in move_list:
                    move_msg.linear.x = step[0]          # move robot backwards or forwards
                    move_msg.angular.z = step[1]         # twist angular pose. counter clockwise
                    cnt = 0
                    while not rospy.is_shutdown() and cnt < step[2]:
                        self.cmd_vel_pub.publish(move_msg)
                        rate.sleep()
                        cnt = cnt + 1

                rospy.loginfo("%s: Tucking the arm...", self.node_name)
           
                goal = PlayMotionGoal()
                goal.motion_name = 'home' # "home" is a predefined motion that TIAGo can execute to tuck its arm. You can check the available motions in the file /play_motion/config/predefined_motions.yaml
                goal.skip_planning = True # this will make the robot move its arm in a predefined way, without checking for collisions. Use with caution!
                self.play_motion_ac.send_goal(goal)
                success_tucking = self.play_motion_ac.wait_for_result(rospy.Duration(100.0))

                if success_tucking:
                    rospy.loginfo("%s: Arm tuck succeeded!", self.play_motion_ac.get_result())
                    self.state = 99
                else:
                    self.play_motion_ac.cancel_goal()
                    rospy.logerr("%s: play_motion failed to tuck arm, reset simulation", self.node_name)
                    self.state = -1

                rospy.sleep(1)

            # Error handling
            if self.state == -1:
                rospy.logerr("%s: State machine failed. Check your code and try again!", self.node_name)
                return

        rospy.loginfo("%s: State machine finished!", self.node_name)
        return
    

if __name__ == "__main__":

	rospy.init_node('main_state_machine')
	try:
		StateMachine()
	except rospy.ROSInterruptException:
		pass

	rospy.spin()
