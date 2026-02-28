#!/usr/bin/env python3

"""
    @author: Daniel Duberg (dduberg@kth.se)
"""

# Python standard library
import copy

# ROS
import rospy
import message_filters # message_filters is a ROS package that provides tools for synchronizing incoming messages 
                       # based on their timestamps. It allows you to subscribe to multiple topics and receive messages 
                       # from those topics in a synchronized manner, which is especially useful when you want to process 
                       # data from multiple sensors together (e.g., odometry and laser scan data).
                       
                       # Odometry is a ROS message type that contains information about the robot's position and orientation (pose) as well as its velocity.
                       # LaserScan is a ROS message type that contains information about the laser scan data, including the angles and distances measured by the laser scanner.

# ROS messages
from geometry_msgs.msg import PoseStamped as PoseStampedROS
from sensor_msgs.msg import LaserScan as LaserScanROS
from nav_msgs.msg import OccupancyGrid as OccupancyGridROS
from nav_msgs.msg import Odometry as OdometryROS
from map_msgs.msg import OccupancyGridUpdate as OccupancyGridUpdateROS

# "Local version" of ROS messages
from local.geometry_msgs import PoseStamped
from local.sensor_msgs import LaserScan
from local.nav_msgs import OccupancyGrid
from local.map_msgs import OccupancyGridUpdate

from grid_map import GridMap
from mapping import Mapping


class EngineROS:
    def __init__(self, map_frame_id, map_resolution, map_width, map_height,
                 map_origin_x, map_origin_y, map_origin_yaw, inflate_radius,
                 unknown_space, free_space, c_space, occupied_space, optional=None):
        rospy.init_node('Mapper')
        self.__pose = None
        self.__map = GridMap(map_frame_id, map_resolution, map_width, map_height,
                         map_origin_x, map_origin_y, map_origin_yaw)

        self.__inflated_map = self.__map

        self.__mapping = Mapping(unknown_space, free_space, c_space,
                                 occupied_space, inflate_radius, optional)

        self.__odom_sub = message_filters.Subscriber('odom', OdometryROS)
        self.__scan_sub = message_filters.Subscriber('scan', LaserScanROS)

        self.__ts = message_filters.ApproximateTimeSynchronizer([self.__odom_sub, self.__scan_sub], 10, 0.01)
        self.__ts.registerCallback(self.callback)

        self.__map_pub = rospy.Publisher('map', OccupancyGridROS, queue_size=1, latch=True)
        self.__map_updates_pub = rospy.Publisher("map_updates", 
                                                 OccupancyGridUpdateROS,
                                                 queue_size=10)

        self.__map_inflated_pub = rospy.Publisher('inflated_map', OccupancyGridROS, queue_size=1, latch=True)

        self.publish_map()

        rospy.spin()

    def callback(self, odom_ros, scan_ros):
        scan = self.from_ros_scan(scan_ros)
        pose = self.from_ros_odom(odom_ros)

        self.__map, update = self.__mapping.update_map(self.__map, pose, scan) # returns the updated grid map and the update (the part of the map that changed) after processing the new scan and pose information

        if isinstance(update, OccupancyGridUpdate) and len(update.data) != 0:
            self.publish_map_update(update)
            map = copy.deepcopy(self.__map)
            self.__inflated_map = self.__mapping.inflate_map(map)
            self.publish_inflated_map()
        else:
            self.publish_map()

    def publish_map(self):
        # Get ROS occupancy map
        map = self.map_to_message(self.__map)
        self.__map_pub.publish(map)

    def publish_map_update(self, update):
        # Get ROS occupancy map update
        update_ros = self.map_update_to_message(update)
        # Only send out the update
        self.__map_updates_pub.publish(update_ros)

    def publish_inflated_map(self):
        # Get ROS occupancy map
        map = self.map_to_message(self.__inflated_map)
        self.__map_inflated_pub.publish(map)

    def from_ros_scan(self, scan_ros): # here we convert the ROS LaserScan message to our local LaserScan message
        scan = LaserScan()
        scan.header.seq = scan_ros.header.seq
        scan.header.stamp = scan_ros.header.stamp
        scan.header.frame_id = scan_ros.header.frame_id

        scan.angle_min = scan_ros.angle_min # The start angle of the laser scan [radians]. For example, if the laser scanner emits beams 
                                            # in a full circle (360 degrees) around the robot, then the angle_min would typically 
                                            # be -pi radians (i.e., -180 degrees), indicating that the first beam starts pointing 
                                            # directly to the left of the robot.
        scan.angle_max = scan_ros.angle_max # The end angle of the laser scan [radians]. For example, if the laser scanner emits beams 
                                            # in a full circle (360 degrees) around the robot, then the angle_max would typically be 
                                            # pi radians (i.e., 180 degrees), indicating that the last beam ends pointing directly 
                                            # to the right of the robot.
        scan.angle_increment = scan_ros.angle_increment # Angular distance between measurements [rad] 
                                                        # The angle between consecutive laser beams in radians. For example, 
                                                        # if the laser scanner emits 360 beams in a full circle (360 degrees) around the robot,, 
                                                        # then the angle_increment would be 2*pi/360 radians.
        scan.time_increment = scan_ros.time_increment
        scan.range_min = scan_ros.range_min # The minimum range value that the laser scanner can measure (in length) [meters]. 
                                            # If an obstacle is closer than this distance, the measurement may be unreliable or invalid.
                                            # It might not be able to detect obstacles closer than this distance, and the value may be set to 0.0 or NaN (Not a Number).
        scan.range_max = scan_ros.range_max # The maximum range value that the laser scanner can measure (in length) [meters]. 
                                            # If an obstacle is farther than this distance, the measurement may be unreliable or invalid.
                                            # It might not be able to detect obstacles beyond this distance, and the value may be set to infinity (float('inf')) or a large number.
        scan.ranges = scan_ros.ranges # Array of distance readings [meters]. It's an array because the laser scanner emits multiple beams in different directions, 
                                      # and each beam gives us a distance measurement to the nearest obstacle in that direction.
                                    
                                      # scan.ranges is a list of distance measurements (floats) from the laser scanner, 
                                      # where each measurement corresponds to a specific angle based on the angle_min, angle_max, and angle_increment. 
                                      # The ranges tell us how far away obstacles are in different directions around the robot.
                                    
                                      # The length of scan.ranges is equal to the number of laser beams in the scan.
                                      # Each element in scan.ranges is a float representing the distance to an obstacle in meters.
                                      # If an obstacle is not detected within the range, the value is typically set to infinity (float('inf')) or a large number.
                                      # If there is an obstacle, the value is a positive float representing the distance in meters.
                                      # If there is an error in measurement, the value (invalid readings) may be 0.0 or NaN (Not a Number).        
        scan.intensities = scan_ros.intensities # Intensity (reflectivity) of each beam - Array of intensity readings (floats). The intensity values represent the strength of the reflected laser beam, which can give us information about the surface properties of the obstacles (e.g., how reflective they are).

        return scan

    def from_ros_odom(self, odom_ros): # here we convert the ROS Odometry message to our local PoseStamped message
        pose_ros = PoseStampedROS()
        pose_ros.header = odom_ros.header
        pose_ros.pose = odom_ros.pose.pose

        pose = PoseStamped()
        pose.header.seq = pose_ros.header.seq
        pose.header.stamp = pose_ros.header.stamp
        pose.header.frame_id = pose_ros.header.frame_id

        pose.pose.position.x = pose_ros.pose.position.x
        pose.pose.position.y = pose_ros.pose.position.y
        pose.pose.position.z = pose_ros.pose.position.z

        pose.pose.orientation.x = pose_ros.pose.orientation.x
        pose.pose.orientation.y = pose_ros.pose.orientation.y
        pose.pose.orientation.z = pose_ros.pose.orientation.z
        pose.pose.orientation.w = pose_ros.pose.orientation.w

        return pose

    def map_to_message(self, map):
        '''
        :type map: Map
        '''
        map = map.to_message()  # OccupancyGrid
        map_ros = OccupancyGridROS()

        # Fill in the header
        map_ros.header.stamp = rospy.Time.now()
        map_ros.header.frame_id = map.header.frame_id

        # Fill in the info
        map_ros.info.resolution = map.info.resolution
        map_ros.info.width = map.info.width
        map_ros.info.height = map.info.height
        map_ros.info.origin = map.info.origin

        # Fill in the map data
        map_ros.data = map.data

        return map_ros

    def map_update_to_message(self, update):
        '''
        :type update: OccupancyGridUpdate
        '''
        update_ros = OccupancyGridUpdateROS()

        # Fill in the header
        update_ros.header.stamp = rospy.Time.now()
        update_ros.header.frame_id = update.header.frame_id

        update_ros.x = update.x
        update_ros.y = update.y
        update_ros.width = update.width
        update_ros.height = update.height
        update_ros.data = update.data

        return update_ros
