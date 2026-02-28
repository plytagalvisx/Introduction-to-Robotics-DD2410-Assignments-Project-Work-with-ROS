# Assignment 5 -- Mobile Manipulation Project

DD2410 -- Introduction to Robotics (Irob23)

This repository contains the implementation of the **Mobile Manipulation
Project** using the TIAGo robot in Gazebo.

The assignment consists of designing and integrating a **mission
planner** for a simulated mobile manipulator capable of autonomous
navigation and manipulation.

------------------------------------------------------------------------

# Project Overview

The final project simulates a **TIAGo robot** in a Gazebo apartment
environment.

The robot: - Navigates autonomously - Detects objects - Picks and places
an ArUco cube - Uses onboard sensors and motion planning

You are provided with working modules (navigation, manipulation,
sensing). Your task is to implement a **high-level mission planner**
that integrates them.

------------------------------------------------------------------------

# Files to Modify

Inside package `robotics_project`:

1.  `sm_students.py`
    -   Implement a **State Machine (SM)**
2.  `bt_students.py`
    -   Implement a **Behavior Tree (BT)** (required for C and A grades)
3.  `launch_project.launch`
    -   Deploy and connect system components
    -   Launch either SM or BT by changing the node type

Example node:

``` xml
<node pkg="robotics_project" type="sm_students.py"
      name="logic_state_machine" output="screen"/>
```

------------------------------------------------------------------------

# Grading Levels

Completing before deadline gives bonus exam points.

## E Level -- Pick & Carry & Place (No Sensing)

Robot must: 1. Pick cube from known pose (Table 1) 2. Navigate to Table
2 3. Place cube

Restrictions: - No camera - No laser scan

Implemented using a **State Machine**.

Evaluation: - Working simulation - Ability to reason about robustness

------------------------------------------------------------------------

## C Level -- With Visual Sensing

Now robot must:

1.  Detect cube using camera
2.  Compute grasp
3.  Pick cube
4.  Navigate
5.  Place cube
6.  Verify placement

If placement fails → return and retry.

Implemented using a **Behavior Tree**.

------------------------------------------------------------------------

## A Level -- With Navigation & Localization

Robot starts in unknown pose (Kidnapped Robot Problem).

Behavior Tree must:

1.  Localize (AMCL convergence)
2.  Navigate to pick pose
3.  Detect cube
4.  Pick cube
5.  Navigate to place location
6.  Place cube
7.  Verify success
8.  Retry if failed

Additional requirements: - Handle robot kidnapping during navigation -
Detect cube loss during transport - Use particle distribution to detect
AMCL convergence

------------------------------------------------------------------------

# Installation

``` bash
cd ~/catkin_ws/src
unzip assignment_5.zip

echo 'export GAZEBO_MODEL_DATABASE_URI=http://models.gazebosim.org/' >> ~/.bashrc
source ~/.bashrc

cd ~/catkin_ws
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3
source devel/setup.bash
```

------------------------------------------------------------------------

# Launch Simulation

Terminal 1:

``` bash
roslaunch robotics_project gazebo_project.launch
```

Terminal 2:

``` bash
roslaunch robotics_project launch_project.launch
```

Wait for Gazebo and RViz to fully load before launching the second
command.

Tip: You can stop and relaunch only `launch_project.launch` during
development.

------------------------------------------------------------------------

# Development Notes

-   Use ROS tools: rostopic, rosservice, rosmsg, tf
-   Explore available actions/services carefully
-   Logging errors is sufficient for planning/navigation failures
-   You may manually move robot in Gazebo for debugging

------------------------------------------------------------------------

# Common Issues

MoveIt may return:

    PLANNING_FAILED

Navigation may cause spinning behavior due to localization inaccuracies.

These are known simulation issues and not required to be fixed, only
logged and handled gracefully.

------------------------------------------------------------------------

# Submission

Upload BEFORE oral presentation:

-   sm_students.py
-   bt_students.py (if required)
-   launch_project.launch

Work in pairs unless approved otherwise.

------------------------------------------------------------------------

# Key Concepts

-   State Machines vs Behavior Trees
-   High-level task planning
-   ROS services, actions, and topics
-   Autonomous navigation
-   AMCL localization
-   Kidnapped robot problem
-   Manipulation with MoveIt

------------------------------------------------------------------------

Course: DD2410 -- Introduction to Robotics\
Project: Mobile Manipulation\
Robot: TIAGo\
Environment: Gazebo Simulation
