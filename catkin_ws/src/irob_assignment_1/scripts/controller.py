#!/usr/bin/env python3
import rospy
import actionlib
import tf2_ros
import tf2_geometry_msgs

from math import atan2, hypot
from geometry_msgs.msg import Twist
from nav_msgs.msg import Path

import irob_assignment_1.msg
from irob_assignment_1.srv import GetSetpoint, GetSetpointRequest

# Globals
tf_buffer = None
listener = None
goal_client = None
control_client = None
pub = None

robot_frame_id = "base_link"

max_linear_velocity = 0.5
max_angular_velocity = 1.0

# gains for pure proportional controller (P-controller)
k_lin = 0.8 # 0.5
k_ang = 1.5 # 4.0

goal_tolerance_m = 0.05  # 5cm

GAIN_THRESHOLD = 2.0

def clamp(val, lo, hi):
    return max(lo, min(hi, val))


def path_is_empty(path):
    return (path is None) or (len(path.poses) == 0)


def point_to_twist_in_base_link(x, y):
    dist = hypot(x, y)
    ang = atan2(y, x)

    cmd = Twist()

    if dist < goal_tolerance_m:
        return cmd  # stop

    w = k_ang * ang
    v = k_lin * dist

    # Burger: do not reverse
    v = max(0.0, v)

    # Clamp to limits
    cmd.linear.x = clamp(v, -max_linear_velocity, max_linear_velocity)
    cmd.angular.z = clamp(w, -max_angular_velocity, max_angular_velocity)
    
    # cmd.linear.x = max(0.0, cmd.linear.x)
    
    # "Turning hard --> stop Burger's forward motion" turning logic:
    # The absolute value abs() function makes sure that this works for both left and right turn directions
    # and not just for positive angular velocity (say left turns).
    # abs() makes this turning logic become symmetric.
    # If turning hard, stop forward motion (both directions).
    if abs(cmd.angular.z) >= 0.6: 
    	cmd.linear.x = 0.0
    
    # This velocity scaling can exceed max unless we specify this afterwards; if cmd.angular.z > max_angular_velocity: cmd.angular.z = max_angular_velocity. Same for linear (forward) velocity.
    # cmd.linear.x = max_linear_velocity * dist
    # cmd.angular.z = max_angular_velocity * ang
    
    # If turning hard, stop Burger's forward motion
    # if abs(cmd.angular.z) >= 0.6:
    # 	cmd.linear.x = 0.0
    
    return cmd


def get_path():
    """
    Ask the action server for the next path.
    Returns: (path, gain)
    """
    global goal_client

    goal = irob_assignment_1.msg.GetNextGoalGoal()  # empty goal
    goal_client.send_goal(goal)
    goal_client.wait_for_result()
    result = goal_client.get_result()

    if result is None:
        rospy.logwarn("Action returned no result.")
        return Path(), 0.0

    return result.path, result.gain


def move(path):
    """
    Loop until service returns empty new_path (or ROS shutdown).
    Each cycle:
      - call service with current path -> (setpoint, new_path)
      - transform setpoint to base_link
      - convert to Twist and publish
    """
    global control_client, tf_buffer, pub, robot_frame_id

    rate = rospy.Rate(10)

    while not rospy.is_shutdown() and not path_is_empty(path):
        # 1) call service
        req = GetSetpointRequest()
        req.path = path
        try:
            resp = control_client(req)
        except rospy.ServiceException as e:
            rospy.logwarn("get_setpoint call failed: %s", str(e))
            pub.publish(Twist()) # stop robot
            rate.sleep()
            continue

        # Update path from response (service may shorten/modify it)
        path = resp.new_path

        # 2) validate setpoint frame
        src_frame = resp.setpoint.header.frame_id
        if not src_frame:
            rospy.logwarn("Setpoint frame_id is empty. Stopping this cycle.")
            pub.publish(Twist())
            rate.sleep()
            continue

        # 3) transform to base_link
        try:
            transform = tf_buffer.lookup_transform(
                robot_frame_id,
                src_frame,
                rospy.Time(0),
                rospy.Duration(0.5)
            )
            sp_bl = tf2_geometry_msgs.do_transform_point(resp.setpoint, transform)
        except (tf2_ros.LookupException,
                tf2_ros.ConnectivityException,
                tf2_ros.ExtrapolationException) as e:
            rospy.logwarn("TF failed (%s->%s): %s", src_frame, robot_frame_id, str(e))
            pub.publish(Twist())
            rate.sleep()
            continue

        # 4) point -> twist and publish
        cmd = point_to_twist_in_base_link(sp_bl.point.x, sp_bl.point.y)
        pub.publish(cmd)

        rate.sleep()

    # Stop when path finished (or on shutdown)
    pub.publish(Twist())


if __name__ == "__main__":
    rospy.init_node("controller")

    # TF
    tf_buffer = tf2_ros.Buffer()
    listener = tf2_ros.TransformListener(tf_buffer)

    # Pub
    pub = rospy.Publisher("/cmd_vel", Twist, queue_size=10)

    # Action client
    goal_client = actionlib.SimpleActionClient(
        "get_next_goal",
        irob_assignment_1.msg.GetNextGoalAction
    )
    rospy.loginfo("Waiting for action server get_next_goal...")
    goal_client.wait_for_server()

    # Service client
    rospy.loginfo("Waiting for service get_setpoint...")
    rospy.wait_for_service("get_setpoint")
    control_client = rospy.ServiceProxy("get_setpoint", GetSetpoint)


    while not rospy.is_shutdown():
    
       # Keep exploring until gain is high enough
       while not rospy.is_shutdown():
           path, gain = get_path()
           rospy.loginfo("Got path (poses=%d) gain=%.3f", len(path.poses), gain)
        
           if path_is_empty(path):
              rospy.loginfo("Empty path -> done.")
              pub.publish(Twist())
              rospy.signal_shutdown("No more paths")
              break
        
           if gain >= GAIN_THRESHOLD:
              rospy.loginfo("Gain %.3f >= %.3f -> accept and move", gain, GAIN_THRESHOLD)
              break # stop exploring
              
       if rospy.is_shutdown():
          break
          
       move(path)

    pub.publish(Twist())

    # Spin
    rospy.spin()
