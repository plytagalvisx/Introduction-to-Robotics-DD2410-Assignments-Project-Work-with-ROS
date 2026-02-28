#!/usr/bin/env python3
import rospy
import actionlib
import irob_assignment_1.msg
from irob_assignment_1.srv import GetSetpoint, GetSetpointRequest, GetSetpointResponse
from geometry_msgs.msg import Twist
from nav_msgs.msg import Path
import tf2_ros
import tf2_geometry_msgs
from math import atan2, hypot
from actionlib_msgs.msg import GoalStatus

# Use to transform between frames
tf_buffer = None
listener = None

# The exploration simple action client
goal_client = None
# The collision avoidance service client
control_client = None
# The velocity command publisher
pub = None

# The robots frame
robot_frame_id = "base_link"

# Min allowed gain to move along path (in feedback)
min_allowed_gain = 3

# P gains
k_lin = 0.8
k_ang = 1.5

# Limits
# Max linear velocity (m/s)
max_linear_velocity = 0.5
# Max angular velocity (rad/s)
max_angular_velocity = 1.0

goal_tolerance_m = 0.05  # 5 cm
turn_gate_w = 0.6        # if |w| >= this, set v = 0 (Burger turning-in-place)

# Execution state
EXECUTING = False
current_path = Path()
accepted_from_feedback = False

# Store latest feedback (so we can log / use it)
latest_fb_gain = None
latest_fb_path = None

control_timer = None

def clamp(val, lo, hi):
    return max(lo, min(hi, val))

def path_is_empty(path):
    return (path is None) or (len(path.poses) == 0)

def stop_robot():
    pub.publish(Twist())

def point_to_cmd(x, y):
    """x,y are setpoint coordinates in base_link."""
    dist = hypot(x, y)
    ang = atan2(y, x)

    cmd = Twist()
    
    if dist < goal_tolerance_m:
        return cmd  # stop

    w = k_ang * ang
    v = k_lin * dist

    # Burger: avoid reverse
    v = max(0.0, v)

    # Clamp to limits
    cmd.linear.x = clamp(v, -max_linear_velocity, max_linear_velocity)
    cmd.angular.z = clamp(w, -max_angular_velocity, max_angular_velocity)

    # Turning hard -> stop forward motion (prevents wall sticking)
    if abs(cmd.angular.z) >= turn_gate_w: 
    	cmd.linear.x = 0.0
    
    return cmd


def goal_active():
    # rospy.loginfo("I got activated")
    rospy.loginfo("get_next_goal: active")

# Accept (i.e., results) early if gain high enough:
def goal_feedback(feedback):
    global EXECUTING, current_path, accepted_from_feedback
    global latest_fb_gain, latest_fb_path
        
    # rospy.loginfo("I got feedback")
    
    if EXECUTING:
    	# Already executing a path, ignore planner feedback
    	return
    
    if feedback is None:
    	return
    	
    gain = feedback.gain
    path = feedback.path
    
    if path is None or len(path.poses) == 0:
    	return

    rospy.loginfo("get_next_goal: feedback gain=%.3f poses=%d", gain, len(path.poses))

    # Check if this path has higher gain than min_allowed_gain
    if gain >= min_allowed_gain:
        rospy.loginfo("Accepting feedback path (gain %.3f >= %.3f). Canceling goal and executing.", gain, min_allowed_gain)

        accepted_from_feedback = True
        current_path = path
        EXECUTING = True
        # If it has cancel goal and move along the path
        goal_client.cancel_goal()

# If we didn't accept feedback early, use final result:
def goal_result(state, result):
    global EXECUTING, current_path, accepted_from_feedback
    
    # rospy.loginfo("I got a result")
    
    if state == GoalStatus.SUCCEEDED:
        rospy.loginfo("get_next_goal: SUCCEEDED (result gain=%.3f poses=%d)", result.gain, len(result.path.poses))
    
        # If we already accepted a feedback path, ignore final result
        if accepted_from_feedback:
    	    return

        # If the state is succeeded then
        if result is None or result.path is None or len(result.path.poses) == 0:
            rospy.loginfo("Action result path empty -> shutting down exploration.")
            stop_robot()
            rospy.signal_shutdown("No more paths")
            return

        # Accept result path and move along the path if path is not empty
        current_path = result.path
        EXECUTING = True

    elif state == GoalStatus.RECALLED:
        rospy.loginfo("get_next_goal: RECALLED")
    elif state == GoalStatus.REJECTED:
        rospy.loginfo("get_next_goal: REJECTED")
    elif state == GoalStatus.PREEMPTED:
        rospy.loginfo("get_next_goal: PREEMPTED")
    elif state == GoalStatus.ABORTED:
        rospy.loginfo("get_next_goal: ABORTED")
    elif state == GoalStatus.LOST:
        rospy.loginfo("get_next_goal: LOST")
    else:
        rospy.loginfo("get_next_goal: done with state=%s", str(state))

# “move()” executed as timer tick
def move_tick(event):
    """
    Runs at 10Hz. If EXECUTING:
      - call get_setpoint(path)
      - transform setpoint to base_link
      - compute Twist and publish
      - update path
    When path empty -> stop and request next goal.
    """
    global EXECUTING, accepted_from_feedback, current_path

    if not EXECUTING:
        return

    # Done executing this path
    if path_is_empty(current_path):
        rospy.loginfo("Execution finished -> stop and request new path.")
        stop_robot()
        EXECUTING = False
        accepted_from_feedback = False
        get_path()
        return

    # Call service to get setpoint + updated path
    req = GetSetpointRequest()
    req.path = current_path
    try:
        resp = control_client(req)
    except rospy.ServiceException as e:
        rospy.logwarn("get_setpoint call failed: %s", str(e))
        stop_robot()
        return

    # Update path from response (service may shorten/modify it)
    current_path = resp.new_path

    # Validate setpoint frame
    src_frame = resp.setpoint.header.frame_id
    if not src_frame:
        rospy.logwarn("Setpoint frame_id is empty -> stop tick.")
        stop_robot()
        return

    # transform to base_link
    try:
        transform = tf_buffer.lookup_transform(
            robot_frame_id, src_frame, rospy.Time(0), rospy.Duration(0.5)
        )
        sp_bl = tf2_geometry_msgs.do_transform_point(resp.setpoint, transform)
    except (tf2_ros.LookupException,
            tf2_ros.ConnectivityException,
            tf2_ros.ExtrapolationException) as e:
        rospy.logwarn("TF failed (%s->%s): %s", src_frame, robot_frame_id, str(e))
        stop_robot()
        return

    # point -> twist and publish
    cmd = point_to_cmd(sp_bl.point.x, sp_bl.point.y)
    pub.publish(cmd)

# Send empty goal; callbacks handle the rest
def get_path():
    global goal_client

    # Get path from action server
    goal = irob_assignment_1.msg.GetNextGoalGoal()
    goal_client.send_goal(goal, active_cb=goal_active, feedback_cb=goal_feedback, done_cb=goal_result)

    # Call move with path from action server


# Callback-based controller (ROS1, actionlib done/feedback/active callbacks):
if __name__ == "__main__":
    # Init node
    rospy.init_node("controller")

    # TF
    tf_buffer = tf2_ros.Buffer()
    listener = tf2_ros.TransformListener(tf_buffer)

    # Init publisher
    pub = rospy.Publisher("/cmd_vel", Twist, queue_size=10)

    # Init simple action client
    goal_client = actionlib.SimpleActionClient("get_next_goal", irob_assignment_1.msg.GetNextGoalAction)
    rospy.loginfo("Waiting for action server get_next_goal...")
    goal_client.wait_for_server()

    # Init service client
    rospy.loginfo("Waiting for service get_setpoint...")
    rospy.wait_for_service("get_setpoint")
    control_client = rospy.ServiceProxy("get_setpoint", GetSetpoint)

    # Start control loop at 10Hz
    rospy.Timer(rospy.Duration(0.1), move_tick)

    # Kick off first planning request
    get_path()

    # Spin
    rospy.spin()
    stop_robot()
