#!/usr/bin/env python3

# Python standard library
from ast import For
from math import cos, sin, atan2, fabs
import math

# Numpy
import numpy as np

# "Local version" of ROS messages
from local.geometry_msgs import PoseStamped, Quaternion # for pose and orientation
from local.sensor_msgs import LaserScan # for laser scan data
from local.map_msgs import OccupancyGridUpdate # for returning the updated part of the map in update_map()

from grid_map import GridMap # for representing the grid map


class Mapping:
    def __init__(self, unknown_space, free_space, c_space, occupied_space,
                 radius, optional=None):
        self.unknown_space = unknown_space
        self.free_space = free_space
        self.c_space = c_space
        self.occupied_space = occupied_space
        self.allowed_values_in_map = {"self.unknown_space": self.unknown_space, # unknown space (e.g., -1).
                                      "self.free_space": self.free_space, # free space (e.g., 0)
                                      "self.c_space": self.c_space, # C space (inflated space) (e.g., 50)
                                      "self.occupied_space": self.occupied_space} # occupied space (e.g., 100)
        self.radius = radius
        self.__optional = optional

    def get_yaw(self, q):
        """Returns the Euler yaw from a quaternion.
        :type q: Quaternion
        """
        return atan2(2 * (q.w * q.z + q.x * q.y),
                     1 - 2 * (q.y * q.y + q.z * q.z))

    def raytrace(self, start, end):
        """Returns all cells in the grid map that has been traversed
        from start to end, including start and excluding end.
        start = (x, y) grid map index
        end = (x, y) grid map index
        """
        (start_x, start_y) = start
        (end_x, end_y) = end
        x = start_x
        y = start_y
        (dx, dy) = (fabs(end_x - start_x), fabs(end_y - start_y))
        n = dx + dy
        x_inc = 1
        if end_x <= start_x:
            x_inc = -1
        y_inc = 1
        if end_y <= start_y:
            y_inc = -1
        error = dx - dy
        dx *= 2
        dy *= 2

        traversed = []
        for i in range(0, int(n)):
            traversed.append((int(x), int(y)))

            if error > 0:
                x += x_inc
                error -= dy
            else:
                if error == 0:
                    traversed.append((int(x + x_inc), int(y)))
                y += y_inc
                error += dx

        return traversed

    def add_to_map(self, grid_map, x, y, value): # here we add the occupied and free space to the map
        """Adds value to index (x, y) in grid_map if index is in bounds.
        Returns whether (x, y) is inside grid_map or not.
        """
        if value not in self.allowed_values_in_map.values():
            raise Exception("{0} is not an allowed value to be added to the map. "
                            .format(value) + "Allowed values are: {0}. "
                            .format(self.allowed_values_in_map.keys()) +
                            "Which can be found in the '__init__' function.")

        if self.is_in_bounds(grid_map, x, y):
            grid_map[x, y] = value # The value of the cell can tell us if the area (i.e., a grid cell (x, y)) is free, occupied, unknown, or something else
            return True # successfully added value (e.g., self.occupied_space or self.free_space) to map (to the cell (x, y) in the map)
        return False # (x, y) is out of bounds, did not add value to map

    def is_in_bounds(self, grid_map, x, y):
        """Returns whether (x, y) is inside grid_map or not."""
        if x >= 0 and x < grid_map.get_width():
            if y >= 0 and y < grid_map.get_height():
                return True
        return False

    # From LaserScan to Cartesian coordinates
    def scan_to_xy(self, scan):
        pts = []
        a = scan.angle_min
        for r in scan.ranges: # for each beam in the scan, we can calculate the (x, y) coordinates of the point that the beam hits (the obstacle) using the range and the angle of the beam. We can then add that point to our list of points.
            pts.append((r * math.cos(a), r * math.sin(a)))
            a += scan.angle_increment
        return pts
    
    # Filter invalid ranges
    def valid_indices_and_ranges(self, scan):
        out = []
        for i, r in enumerate(scan.ranges):
            if math.isfinite(r) and scan.range_min <= r <= scan.range_max:
                out.append((i, r))
        return out

    def update_map(self, grid_map, pose, scan):
        """Updates the grid_map with the data from the laser scan and the pose. 
        
        For E: 
            Update the grid_map with self.occupied_space.

            Return the updated grid_map.

            You should use:
                self.occupied_space  # For occupied space

                You can use the function add_to_map to be sure that you add
                values correctly to the map.

                You can use the function is_in_bounds to check if a coordinate
                is inside the map.

        For C:
            Update the grid_map with self.occupied_space and self.free_space. Use
            the raytracing function found in this file to calculate free space.

            You should also fill in the update (OccupancyGridUpdate()) found at
            the bottom of this function. It should contain only the rectangle area
            of the grid_map which has been updated.

            Return both the updated grid_map and the update.

            You should use:
                self.occupied_space  # For occupied space
                self.free_space      # For free space

                To calculate the free space you should use the raytracing function
                found in this file.

                You can use the function add_to_map to be sure that you add
                values correctly to the map.

                You can use the function is_in_bounds to check if a coordinate
                is inside the map.

        :type grid_map: GridMap     # is for the grid map that we want to update with the new scan and pose information. 
                                    # We will directly modify this grid map based on the laser scan data and the robot's current pose.
        :type pose: PoseStamped     # is for the current pose of the robot, which contains both position and orientation
        :type scan: LaserScan       # contains the data from the laser scan, which we can use to update the map
        """

        # Current yaw of the robot
        robot_yaw = self.get_yaw(pose.pose.orientation) # Even though quaternions are ideal for computation, many robotics problems are planar (2D).
                                                        # For a ground robot:
                                                        #   - Roll ≈ 0
                                                        #   - Pitch ≈ 0
                                                        #   - Only yaw (heading) matters
                                                        # So extracting yaw from a quaternion is useful when we need:
                                                        #   - The robot’s heading angle
                                                        #   - Angle error (i.e., delta) calculations (e.g., turn toward goal)
                                                        #   - A value to use in 2D control laws
                                                        #   - A readable orientation for debugging
                                                        
        # The origin of the map [m, m, rad]. This is the real-world pose of the cell (0,0) in the map.
        origin = grid_map.get_origin()
        # The map resolution [m/cell]
        resolution = grid_map.get_resolution()

        # Update the grid_map with the data from the laser scan and the pose
        print("pose:", pose) # What do we care about in the pose? We care about the position to know where the robot is in the world, and we care about the orientation to know where the robot is facing in the world. 
        print("scan:", scan) # What do we care about in the scan? We care about the ranges and the angle increment, and the angle min and max to know where the obstacles are in the world. ???

        # We can use both of these to update the map with the laser scan data. We can use the position and orientation 
        # to calculate where the laser scan data points are in the world, and then we can update the map with that information. 
        # We can also use the position and orientation to calculate where the free space is in the world, and then we 
        # can update the map with that information as well.
        
        angle_min_deg = scan.angle_min * 180 / math.pi
        angle_max_deg = scan.angle_max * 180 / math.pi
        angle_increment_deg = scan.angle_increment * 180 / math.pi
        print("Min angle (degrees):", angle_min_deg)
        print("Max angle (degrees):", angle_max_deg)
        print("Angle increment (degrees):", angle_increment_deg)
        
        range_0_deg = scan.ranges[0] * 180 / math.pi
        print("Min angle:", scan.angle_min)
        print("Max angle:", scan.angle_max)
        print("Angle increment:", scan.angle_increment)
        print("Number of points (beams):", len(scan.ranges))
        print("First beam range reading:", scan.ranges[0])
        print("First beam range reading (degrees)", range_0_deg)

        
        # Number of beams:
        num_beams = len(scan.ranges)
        
        # Angle of beam i, e.g. i = 8:
        i = 8
        angle = scan.angle_min + i * scan.angle_increment

        # scan.angle_min is the start angle of the scan, i.e. equivalent to scan.ranges[0]
        # scan.angle_increment is the angle between each beam, so to get the angle of beam i, we can use scan.angle_min + i * scan.angle_increment

        # Cartesian coordinates:
        x = scan.ranges[i] * cos(angle) # the range is the distance from the robot to the obstacle in the direction of the beam, and the angle is the direction of the beam relative to the robot's heading. So we can calculate the (x, y) coordinates of the point that the beam hits (the obstacle) using the range and the angle of the beam.
        y = scan.ranges[i] * sin(angle)
        
        print("Beam", i, "angle in [radians]:", angle, "range in [meters]:", scan.ranges[i], "x:", x, "y:", y)
        
        
        
        # Good to know?:
        # John Doe's LaserScan readings claim that angle_min: -3.12413907051, angle_increment: 0.0174532923847, 
        # but he did not take into account the static transform between base_link and laser, 
        # he assumed publishing that to the nodes would set the frame of LaserScan.angle_min in global coordinates.
        # So he guesses instead of using scan.angle_min, he should use something like scan.angle_min + static_yaw_of_laser_wrt_baselink.
        # But this is not correct, because the static transform between base_link and laser is already taken into account in the LaserScan message, so scan.angle_min is already in the correct frame of reference.
        # How do we know that?
        # We can check the frame_id of the LaserScan message, and see if it is in the correct frame of reference. If it is in the correct frame of reference, then we can use scan.angle_min directly. If it is not in the correct frame of reference, then we need to add the static transform between base_link and laser to scan.angle_min to get the correct angle.
        # How will we know if the frame_id is in the correct frame of reference? We can check if the frame_id is "base_link" or "laser". If it is "base_link", then we can use scan.angle_min directly. If it is "laser", then we need to add the static transform between base_link and laser to scan.angle_min to get the correct angle.
        # But in general, we should not assume that the frame_id is always "base_link" or "laser", we should check the frame_id and see if it is in the correct frame of reference. If it is not in the correct frame of reference, then we need to add the static transform between base_link and laser to scan.angle_min to get the correct angle.


        # It is of great benefit if the robot can construct a map by itself from scratch, which is exactly what we will do in this assignment.
        # Occupancy grid mapping is one of many mapping algorithms.
        # In this assignment we will use the pose to know where in the world the robot is located.
        # In this assignment we will not be working directly with nav_msgs/OccupancyGrid message, instead we have created a class called GridMap.


        """
        Fill in your solution here
        """
        
        # Track updated cells to fill in the OccupancyGridUpdate at the end of this function (for C only)
        min_x = float('inf')
        max_x = float('-inf')
        min_y = float('inf')
        max_y = float('-inf')

        robot_x = pose.pose.position.x
        robot_y = pose.pose.position.y
        
        # Precompute sin/cos of the robot's yaw for the reason that we will need to transform the laserscan points from the robot's local frame to the world frame.
        cos_yaw = cos(robot_yaw)
        sin_yaw = sin(robot_yaw) 
                
        def world_to_map(world_x, world_y):
            # Convert world coordinates to map coordinates
            map_x = int((world_x - origin.position.x) / resolution)
            map_y = int((world_y - origin.position.y) / resolution)
            return map_x, map_y
        
        # For each valid range (beam) in the scan, compute endpoint in world coordinates, convert to map coordinates, and update/mark as occupied space. (For C: use raytracing to update the free space along the beam.)
        for i, r in self.valid_indices_and_ranges(scan): # r is the range reading for beam i
            angle = scan.angle_min + i * scan.angle_increment
            # Calculate the (x, y) coordinates of the point that the beam hits (the obstacle) in the robot's local frame
            # I.e., endpoint in laser scanner frame:
            local_x = r * cos(angle)
            local_y = r * sin(angle)
            # Transform the local coordinates to world coordinates using the robot's pose
            # Rotate + Translate into world (using robot pose):
            world_x = robot_x + cos_yaw * local_x - sin_yaw * local_y
            world_y = robot_y + sin_yaw * local_x + cos_yaw * local_y
            # Convert world coordinates to grid map coordinates
            map_x, map_y = world_to_map(world_x, world_y)
            # Update the grid map with occupied space at the map coordinates of the obstacle
            updatedOccupiedCell = self.add_to_map(grid_map, map_x, map_y, self.occupied_space) # returns True if successfully added occupied space to the map at (map_x, map_y), False if (map_x, map_y) is out of bounds
            # We can keep track of the minimum and maximum x and y indices that we update in the map, and then we can use those to fill in the OccupancyGridUpdate at the end of this function (for C only). We only want to fill in the part of the map that has been updated, so we can use the minimum and maximum x and y indices to determine the rectangle area of the map that has been updated. We can then fill in the OccupancyGridUpdate with that information, so that we only send the updated part of the map to the ROS topic, which can be more efficient than sending the entire map every time.
            if updatedOccupiedCell:
            # if self.add_to_map(grid_map, map_x, map_y, self.occupied_space):
                min_x = min(min_x, map_x)
                max_x = max(max_x, map_x)
                min_y = min(min_y, map_y)
                max_y = max(max_y, map_y)
            
        
            # For C: use raytracing to update the free space along the beam from the robot's position to the obstacle position
            robot_map_x, robot_map_y = world_to_map(robot_x, robot_y)
            for free_x, free_y in self.raytrace((robot_map_x, robot_map_y), (map_x, map_y)): # from robot position to obstacl (endpoint) position
                updatedFreeCell = self.add_to_map(grid_map, free_x, free_y, self.free_space)
                if updatedFreeCell: # select the min and max x and y indices of the free cells that we updated as well, to include in the OccupancyGridUpdate
                # if self.add_to_map(grid_map, free_x, free_y, self.free_space):
                    min_x = min(min_x, free_x)
                    max_x = max(max_x, free_x)
                    min_y = min(min_y, free_y)
                    max_y = max(max_y, free_y)

        # If "Nothing updated" case
        if min_x == float("inf"):
            return grid_map, None
        
        """
        For C only!
        Fill in the update correctly below.
        """ 
        
        # Only get the part that has been updated
        update = OccupancyGridUpdate()
        # The minimum x index in 'grid_map' that has been updated
        update.x = int(min_x)
        # The minimum y index in 'grid_map' that has been updated
        update.y = int(min_y)
        # Maximum x index - minimum x index + 1
        update.width = int(max_x - min_x + 1)
        # Maximum y index - minimum y index + 1
        update.height = int(max_y - min_y + 1)
        # The map data inside the rectangle, in row-major order.
        update.data = []
        for y in range(update.y, update.y + update.height):
            for x in range(update.x, update.x + update.width):
                update.data.append(grid_map[x, y]) 
        
        # Return the updated map together with only the
        # part of the map that has been updated
        return grid_map, update

    def inflate_map(self, grid_map):
        """For C only!
        Inflate the map with self.c_space assuming the robot
        has a radius of self.radius.
        
        Returns the inflated grid_map.

        Inflating the grid_map means that for each self.occupied_space
        you calculate and fill in self.c_space. Make sure to not overwrite
        something that you do not want to.


        You should use:
            self.c_space  # For C space (inflated space).
            self.radius   # To know how much to inflate.

            You can use the function add_to_map to be sure that you add
            values correctly to the map.

            You can use the function is_in_bounds to check if a coordinate
            is inside the map.

        :type grid_map: GridMap
        """

        """
        Fill in your solution here
        """
        
        # We will need to take the cell positions (x, y) in the self.occupied_space and inflate each one of them
        # using self.radius of the robot and then assign/add the inflated obstacle endpoints/new positions to the self.c_space, 
        for x in range(grid_map.get_width()):
            for y in range(grid_map.get_height()):
                if grid_map[x, y] == self.occupied_space:
                    # Inflate the occupied space by self.c_space in all directions
                    for dx in range(-self.radius, self.radius + 1):
                        for dy in range(-self.radius, self.radius + 1):
                            new_x = x + dx
                            new_y = y + dy
                            if self.is_in_bounds(grid_map, new_x, new_y) and grid_map[new_x, new_y] != self.occupied_space:
                                self.add_to_map(grid_map, new_x, new_y, self.c_space)

        # Return the inflated map
        return grid_map
