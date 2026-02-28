#! /usr/bin/env python3

"""
    This node publishes the joint states to make a given trajectory with the KUKA's end-effector

    @author: Silvia Cruciani (cruciani@kth.se)
"""

import rospy
import math
import json
import random
import importlib
import numpy as np

from square_trajectory import SquareTrajectory
import IK_functions
from sensor_msgs.msg import JointState
from std_srvs.srv import EmptyResponse, EmptyRequest, Empty

from visualization_msgs.msg import Marker, MarkerArray
from geometry_msgs.msg import Point


def text_to_vertices(word,
                     ndjson_path,
                     plane="yz",           # "yz" (x fixed) or "xz" (y fixed) or "xy" (z fixed)
                     center=(-0.2085, 0.0, 0.745),  # (xc,yc,zc) center of drawing in robot frame
                     size=0.18,            # overall drawing size in meters
                     z_draw=0.745,         # used if plane == "xy"
                     lift=0.03,            # pen-up lift (meters) along the plane normal
                     sample_every=2):      # downsample strokes (bigger -> fewer points)
    """
    word: label like "dog" (you map this to a .ndjson file)
    ndjson_path: path to the QuickDraw category file for that word
    Returns: vertices = [[x,y,z], ...] (includes pen-up/pen-down moves between strokes)
    """

    # --- load one random drawing from file ---
    with open(ndjson_path, "r") as f:
        lines = f.readlines()
    d = json.loads(random.choice(lines))
    strokes = d["drawing"]  # list of strokes; each stroke = [xs, ys]

    # --- collect all points to compute bounding box in pixel space ---
    pts = []
    for xs, ys in strokes:
        for i in range(0, len(xs), sample_every):
            pts.append((xs[i], ys[i]))
    if not pts:
        return []

    minx = min(p[0] for p in pts); maxx = max(p[0] for p in pts)
    miny = min(p[1] for p in pts); maxy = max(p[1] for p in pts)

    # avoid divide-by-zero
    w = max(1e-9, (maxx - minx))
    h = max(1e-9, (maxy - miny))

    # scale pixels -> meters, preserve aspect ratio
    s = size / max(w, h)

    def map_point(px, py):
        # center in pixel space, flip y (QuickDraw y grows downward)
        x2 = (px - (minx + maxx) * 0.5) * s
        y2 = - (py - (miny + maxy) * 0.5) * s
        return x2, y2

    xc, yc, zc = center

    # plane normal lift direction:
    # - yz plane: normal is +x
    # - xz plane: normal is +y
    # - xy plane: normal is +z
    vertices = []

    def add_point(u, v, pen_up=False):
        if plane == "yz":
            x = xc + (lift if pen_up else 0.0)
            y = yc + u
            z = zc + v
        elif plane == "xz":
            x = xc + u
            y = yc + (lift if pen_up else 0.0)
            z = zc + v
        else:  # "xy"
            x = xc + u
            y = yc + v
            z = z_draw + (lift if pen_up else 0.0)
        vertices.append([x, y, z])

    # --- build 3D vertices with pen up/down between strokes ---
    for stroke in strokes:
        xs, ys = stroke
        # downsample
        stroke_uv = [map_point(xs[i], ys[i]) for i in range(0, len(xs), sample_every)]
        if len(stroke_uv) < 2:
            continue

        u0, v0 = stroke_uv[0]

        # move above start (pen up), then down
        add_point(u0, v0, pen_up=True)
        add_point(u0, v0, pen_up=False)

        # draw stroke
        for (u, v) in stroke_uv[1:]:
            add_point(u, v, pen_up=False)

        # lift at end
        uE, vE = stroke_uv[-1]
        add_point(uE, vE, pen_up=True)

    return vertices

def main():
    rospy.init_node('kuka_node')
    rate = rospy.Rate(10)
    
    #the vertices of the square trajectory (in this case it will be a line)
    # vertices = [[-0.217, 0, 0.84], [-0.2, 0, 0.65], [-0.2, 0, 0.65], [-0.217, 0, 0.84]]
    
    # the vertices of the square shape in the y–z plane (x fixed):
    #vertices = [
    #    [-0.2085, -0.1, 0.84],   # top-left
    #    [-0.2085,  0.1, 0.84],   # top-right
    #    [-0.2085,  0.1, 0.65],   # bottom-right
    #    [-0.2085, -0.1, 0.65]    # bottom-left
    #]
    
    # My own extension:
    # circle in y–z plane (vertical), x fixed
    xc, yc, zc = -0.2085, 0.0, 0.745
    r = 0.095
    N = 20  # more points = smoother

    # Circle shape via parametric vertices:
    vertices = [
        [xc, yc + r * math.cos(2*math.pi*i/N), zc + r * math.sin(2*math.pi*i/N)]
        for i in range(N)
    ]

    # "globe" centered around this point (pick something reachable!)
    #xc, yc, zc = -0.2085, 0.0, 0.745
    #r = 0.08          # radius (keep small; sphere needs lots of workspace)
    #N = 250           # more points = smoother
    #turns = 6         # how many wraps around

    # Sphere/Globe surface shape (single continuous path)
    #vertices = []
    #for i in range(N):
    #    t = i / (N - 1)
    #    phi = -0.5*math.pi + math.pi * t
    #    theta = 2.0*math.pi * turns * t
    #    x = xc + r * math.cos(phi) * math.cos(theta)
    #    y = yc + r * math.cos(phi) * math.sin(theta)
    #    z = zc + r * math.sin(phi)
    #    vertices.append([x, y, z])
    
    #vertices = text_to_vertices(
    #    "dog",
    #    ndjson_path="/home/milenavi/Desktop/dog.ndjson",
    #    plane="yz",                 # vertical drawing plane
    #    center=(-0.2085, 0.0, 0.745),
    #    size=0.18,
    #    lift=0.03,
    #    sample_every=2
    #)
    
    
    #the name of the robot's base frame
    base_frame = 'lwr_base_link'

    trajectory_publisher = SquareTrajectory(vertices, base_frame)
    desired_orientation = [[0, 0, -1], [0, 1, 0], [1, 0, 0]]
    
    
    # My own extension:
    # ---- DRAWING MARKER (RViz "ink") ----
    marker_pub = rospy.Publisher("kuka_drawing", Marker, queue_size=1)

    marker = Marker()
    marker.header.frame_id = base_frame
    marker.ns = "kuka_ink"
    marker.id = 0
    marker.type = Marker.LINE_STRIP
    marker.action = Marker.ADD

    marker.scale.x = 0.005  # line thickness (meters)

    # color (RGBA) - change to whatever you want
    marker.color.r = 1.0
    marker.color.g = 0.0
    marker.color.b = 0.0
    marker.color.a = 1.0

    marker.pose.orientation.w = 1.0  # identity
    marker.points = []
    


    current_q = [0, 1.12, 0, 1.71, 0, 1.84, 0]

    #the joint names of kuka:
    joint_names = ['lwr_a1_joint', 'lwr_a1_joint_stiffness', 'lwr_a2_joint', 'lwr_a2_joint_stiffness', 'lwr_e1_joint', 
    'lwr_e1_joint_stiffness', 'lwr_a3_joint', 'lwr_a3_joint_stiffness', 'lwr_a4_joint', 'lwr_a4_joint_stiffness',
    'lwr_a5_joint', 'lwr_a5_joint_stiffness', 'lwr_a6_joint', 'lwr_a6_joint_stiffness']
    #define the ros message for publishing the joint positions
    joint_msg = JointState()
    joint_msg.name = joint_names

    #define the ros topic where to publish the joints values
    topic_name = rospy.get_param('~topic_name', 'controller/joint_states')
    publisher = rospy.Publisher(topic_name, JointState, queue_size=10)

    # A service is used to restart the trajectory execution and reload a new solution to test
    def restart(req):
        importlib.reload(IK_functions)
        current_q[0:7] = [0, 1.12, 0, 1.71, 0, 1.84, 0]
        q_msg = [current_q[0], 0, current_q[1], 0, current_q[2], 0, current_q[3], 0, current_q[4], 0, current_q[5], 0, current_q[6], 0]
        joint_msg.position = q_msg
        publisher.publish(joint_msg)
        trajectory_publisher.restart()
        trajectory_publisher.publish_path()
        
        # My own extension:
        # reset the drawing
        marker.points = []
        marker.header.stamp = rospy.Time.now()
        marker_pub.publish(marker)
        
        rate.sleep()

        return EmptyResponse()

    s = rospy.Service('restart', Empty, restart)

    restart(EmptyRequest())

    rate.sleep()

    while not rospy.is_shutdown():
        #get the current point in the trajectory
        point = trajectory_publisher.get_point()
        if point is not None:
            #get the IK solution for this point
            q = IK_functions.kuka_IK(point, desired_orientation, current_q)
            current_q = q
            q_msg = [q[0], 0, q[1], 0, q[2], 0, q[3], 0, q[4], 0, q[5], 0, q[6], 0]
            #publish this solution
            joint_msg.position = q_msg
            publisher.publish(joint_msg)
            
            # My own extension:
            # ---- add point to "ink" and publish marker ----
            p = Point()
            p.x = float(point[0])
            p.y = float(point[1])
            p.z = float(point[2])
            marker.points.append(p)

            marker.header.stamp = rospy.Time.now()
            marker_pub.publish(marker)

        #publish the path to be visualized in rviz
        trajectory_publisher.publish_path()
        rate.sleep()

if __name__ == '__main__':
    main()
