# Inverse Kinematics -- DD2410 HT23 Introduction to Robotics (Irob23)

This repository contains the implementation of the **Inverse Kinematics
(IK)** assignment for the course **DD2410 -- Introduction to Robotics**
at KTH.

The assignment is submitted via **Kattis**:
https://kth.kattis.com/courses/DD2410/irob23

------------------------------------------------------------------------

## Overview

In this assignment, you implement inverse kinematics algorithms for two
different robotic manipulators:

1.  **3-DOF SCARA Robot** (Analytical IK)
2.  **7-DOF KUKA Robot** (Numerical / Iterative IK)

------------------------------------------------------------------------

# Repository Structure

You must modify and submit:

    kinematics_assignment_metapackage/
    └── kinematics_assignment/
        └── scripts/
            └── IK_functions.py

This file contains:

-   `scara_IK(...)`
-   `kuka_IK(...)`

------------------------------------------------------------------------

# Part 1 -- SCARA Robot (Analytical IK)

### Goal

Implement an **analytical inverse kinematics solution** for a 3-DOF
SCARA robot.

### Robot Structure

-   q1 → Revolute
-   q2 → Revolute
-   q3 → Prismatic
-   End-effector z-coordinate equals q3

### Input

    point = (x, y, z)

### Output

    q = (q1, q2, q3)

### Run SCARA Visualization

``` bash
roslaunch kinematics_assignment scara_launch.launch
```

If already running:

``` bash
rosservice call /restart
```

### Grading

-   Required to pass (E grade)
-   Kattis score ≥ 20

------------------------------------------------------------------------

# Part 2 -- KUKA Robot (Numerical IK)

### Goal

Implement an **iterative inverse kinematics solver** (Jacobian-based
method recommended).

### Why Numerical?

The 7-DOF KUKA manipulator is too complex for a closed-form analytical
solution.

### Input

    point = (x, y, z)              # Desired position
    R = 3x3 rotation matrix        # Desired orientation
    joint_positions = (q1..q7)     # Current joint values

### Output

    q = (q1..q7)

### Run KUKA Visualization

``` bash
roslaunch kinematics_assignment kuka_launch.launch
```

Restart path:

``` bash
rosservice call /restart
```

------------------------------------------------------------------------

# KUKA DH Parameters

The Denavit-Hartenberg convention used:

-   a_i → distance between z\_{i-1} and z_i along x_i
-   α_i → angle between z\_{i-1} and z_i about x_i
-   d_i → distance between x\_{i-1} and x_i along z\_{i-1}
-   θ_i → angle between x\_{i-1} and x_i about z\_{i-1}

Frame transformation:

T\_{i-1}\^{i} = Trans(z\_{i-1}, d_i) · Rot(z\_{i-1}, θ_i) · Trans(x_i,
a_i) · Rot(x_i, α_i)

------------------------------------------------------------------------

# Numerical IK Notes

-   Use Jacobian-based update
-   Carefully choose convergence threshold
-   Too small → timeout
-   Too large → inaccurate result
-   If it does not converge → check Jacobian and error formulation

Recommended reference: "Jacobian computation", page 111 in standard
robotics textbooks.

------------------------------------------------------------------------

# Common Issues (FAQ)

### 1. Timeout or Bad Score

Usually caused by incorrect convergence implementation --- not threshold
size.

### 2. Robot Not Appearing in RViz

Add to `.bashrc`:

``` bash
echo 'export LC_NUMERIC="en_US.UTF-8"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Robot Flailing

Debug position control first, then orientation.

### 4. Kattis Accepted but Score \< 20

"Accepted" only means no crash. - 20+ → E grade passed - 22 → C grade

------------------------------------------------------------------------

# Grading Summary

  Score    Result
  -------- ------------
  \< 20    Not Passed
  20--21   E grade
  22       C grade

------------------------------------------------------------------------

# Requirements

-   ROS (Noetic recommended)
-   Python 3
-   NumPy

------------------------------------------------------------------------

# Final Notes

-   Multiple IK solutions may exist (especially SCARA)
-   Only requirement: end-effector follows desired path
-   Stability and convergence matter more than specific implementation
    details

------------------------------------------------------------------------

**Course:** DD2410 -- Introduction to Robotics\
**Assignment:** Inverse Kinematics\
**Term:** HT23
