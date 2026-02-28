#! /usr/bin/env python3

import math
import numpy as np

# run: roslaunch kinematics_assignment scara_launch.launch
# or: roslaunch kinematics_assignment kuka_launch.launch


# For SCARA (3 DOF):
    # You can solve geometry directly with triangles.

# For KUKA (7 DOF):
    # Geometry becomes too complex.
    # Infinite solutions exist.
    # So we solve numerically.
    
# So the planar 2R geometry does not start at (0,0). It starts at (0.07,0) in the base frame. 
# That means our target (x,y) must be converted to the joint-1 frame: 
# x = x - 0.07
# y = y
# Then we do the normal planar 2R IK with: 
# l1 = 0.30 (joint1 → joint2, from 'rotational2 origin xyz="0.3 0 0"' in SCARA.urdf)
# l2 = 0.35 (joint2 → end_effector, from 'link3_to_end_effector origin xyz="0.35 0 0"' in SCARA.urdf)
# And our prismatic is exactly what our comment says for these targets:
# q3 = z
# (because targets are in base and prismatic axis is +Z, limits 0..0.1 match our path)

# This function receives as input the desired point = (x, y, z), and outputs the corresponding joint values q = (q1, q2, q3). 
def scara_IK(point):
    x = point[0]
    y = point[1]
    z = point[2]
    q = [0.0, 0.0, 0.0]
    
    # print("point:", point)
    
    # The distances between the joints and the end-effector frame, in the robot's zero configuration.
    # Two joints (q1 and q2) are revolute, and one (q3) is prismatic.
    # The end-effector frame and the base frame are at the same height, which means that 
    # the end-effector z coordinate coincides with the value of the last prismatic joint (q3).
    l0 = 0.07
    l1 = 0.3
    l2 = 0.35

    """
    Fill in your IK solution here and return the three joint values in q
    """
    x = x - l0
    q2 = math.acos((x**2 + y**2 - l1**2 - l2**2) / (2 * l1 * l2))
    q1 = math.atan2(y, x) - math.atan2(l2*math.sin(q2), l1+l2*math.cos(q2)) 
    q3 = z # prismatic joint

    q = [q1, q2, q3]

    return q
 
# - Iterative (because 7-DOF is redundant → no single closed-form)
# - Damped least-squares Jacobian IK
# - Uses our DH table (all alpha_i = 0, alpha_i as given, d3 = L, d5 = M)
# - Keeps constant orientation by using the given R matrix

# The code repeatedly uses the Jacobian to compute how joint angles must change to reduce the difference between the current pose and the desired pose.
# Uses the Jacobian to compute how joint angles must change to reduce the difference between the current pose and the desired pose.
def kuka_IK(point, R, joint_positions):
    x = point[0]
    y = point[1]
    z = point[2]
    # q = joint_positions #it must contain 7 elements
    q = np.array(joint_positions, dtype=float) # Convert the input joint positions to a NumPy array for easier manipulation and calculations. This allows us to perform vectorized operations on the joint angles, which can be more efficient than using lists. The dtype=float ensures that the joint angles are treated as floating-point numbers, which is important for accurate calculations in the inverse kinematics algorithm.

    """
    Fill in your IK solution here and return the seven joint values in q
    """
    
    # Big Picture:
        # Each loop iteration:
            # - Compute where the robot currently is (forward kinematics)
            # - Compute how far it is from the desired pose (error)
            # - Use the Jacobian to figure out how joints should move to reduce that error
            # - Update the joints slightly
            # - Repeat until the error is small

    p_dest = np.array([x, y, z], dtype=float) # target position of the end-effector in the base frame
    R_dest = np.array(R, dtype=float) # target orientation of the end-effector in the base frame (rotation matrix)
    tol = 1e-3 # convergence tolerance for the iterative process. This is the threshold for determining when the error in position and orientation is small enough to consider that we have reached the target/desired position and orientation. If the error is less than this value, we can stop the iterations.
    lam = 1e-2 # lambda is a small positive constant that is added to the diagonal of the Jacobian matrix when calculating its pseudo-inverse. This is done to improve numerical stability and prevent issues that can arise when the Jacobian matrix is close to singular (i.e., when it has very small singular values). By adding lambda to the diagonal, we ensure that the pseudo-inverse calculation remains stable even in cases where the Jacobian matrix is not full rank or has near-singular configurations. The choice of lambda can affect the convergence behavior of the IK algorithm, and it may need to be tuned based on the specific robot and task at hand.
    
    # --- constants from the assignment figure/table ---
    L = 0.4   # link offset
    M = 0.39  # link offset
    BASE_Z = 0.311   # set to 0.0 if your base frame is already at joint1
    TOOL_Z = 0.078   # set to 0.0 if your EE frame is at joint7
    
    # --- FK + Jacobian in one go ---
    # stops after convergence condition is met (when the error in joint angles is less than or equal to the specified tolerance)
    while True:
        # DH parameters: [theta, d, a, alpha]
        # (built from the current q at each iteration)
        dh_parameters = [
            [q[0], BASE_Z, 0.0,  np.pi/2],
            [q[1], 0.0,    0.0, -np.pi/2],
            [q[2], L,      0.0, -np.pi/2],
            [q[3], 0.0,    0.0,  np.pi/2],
            [q[4], M,      0.0,  np.pi/2],
            [q[5], 0.0,    0.0, -np.pi/2],
            [q[6], TOOL_Z, 0.0,  0.0]
        ]
        
        # STEP 1 — Forward Kinematics: 
        # Find out where the robot currently is (the current pose of the end-effector in the base frame) by multiplying the transformation matrices derived from the DH parameters for each joint. This will give us the current position and orientation of the end-effector, which we can then compare to the desired position and orientation to compute the error.
        T = np.eye(4) # Initialize the transformation matrix as the identity matrix (4x4) to represent the initial pose of the end-effector in the base frame. This will be updated iteratively by multiplying it with the transformation matrices derived from the DH parameters for each joint.
        p_list, z_list = [], [] # Initialize empty lists to store the positions (p) and Z-axis vectors (z) for each joint frame. These will be used to compute the Jacobian matrix later on. The positions represent the location of each joint in the base frame, while the Z-axis vectors represent the direction of rotation for each joint.

        for i in range(q.size):
            p_list.append(T[:3, 3].copy()) # Extract the translational part of the transformation matrix (the position of the end-effector in the base frame) and append it to the p_list. This represents the position of each joint in the base frame.
            z_list.append(T[:3, 2].copy()) # Extract the Z-axis vector (the third column of the rotation part of the transformation matrix) and append it to the z_list. This represents the direction of rotation for each joint in the base frame.

            theta_i, d_i, a_i, alpha_i = dh_parameters[i]

            # {i-1}^T_i = Trans(z_{i-1}, d_i) * Rot(z_{i-1}, theta_i) * Trans(x_i, a_i) * Rot(x_i, alpha_i)
            A = np.array([ # this is the transformation matrix from frame {i-1} to frame {i} using the DH parameters
                [np.cos(theta_i), -np.sin(theta_i) * np.cos(alpha_i), np.sin(theta_i) * np.sin(alpha_i), a_i * np.cos(theta_i)],
                [np.sin(theta_i), np.cos(theta_i) * np.cos(alpha_i), -np.cos(theta_i) * np.sin(alpha_i), a_i * np.sin(theta_i)],
                [0.0, np.sin(alpha_i), np.cos(alpha_i), d_i],
                [0.0,    0.0,     0.0,      1.0]
            ], dtype=float)

            T = np.dot(T, A)

        # For these methods, the error in position and orientation between the current pose and the destination/desired pose is needed.
        p_cur = T[:3, 3] # Extract the current end-effector position
        R_cur = T[:3, :3] # Extract the current end-effector rotation
        
        # STEP 2 — Compute Pose [position, orientation] Error:
        # We compute end-effector's position error (translational error)
        error_p = p_dest - p_cur
        
        # We compute a small rotation that would align the current end-effector's orientation with the desired one (rotational error)
        error_R = np.dot(R_dest, R_cur.T)
        # Then extract a small-angle vector
        error_o = 0.5 * np.array([ # orientation error vector (small angle approximation)
            error_R[2, 1] - error_R[1, 2],
            error_R[0, 2] - error_R[2, 0],
            error_R[1, 0] - error_R[0, 1],
        ])
        # This is a compact way of saying: “How much should I rotate around x, y, z to match the desired orientation?”
    
        # stopping condition
        if np.linalg.norm(error_p) < tol and np.linalg.norm(error_o) < tol:
            break

        error = np.hstack((error_p, error_o))     
        
        # STEP 3 — Use the Jacobian:   
        # The Jacobian relates joint velocities to end-effector velocity.
        # We want to invert that relationship to obtain joint updates that will reduce the error in position and orientation.
        # But because the robot is redundant (7 DOF), we use a damped pseudo-inverse to avoid instability near singularities.
        # So then we obtain the joint update that tells us “Which direction in joint space reduces the pose error?”.
        
        J = np.zeros((6, 7))  # Initialize the Jacobian matrix
        for i in range(q.size):
            zi = z_list[i]
            pi = p_list[i]

            # Compute the Jacobian column for joint i
            J[:3, i] = np.cross(zi, (p_cur - pi))  # Linear velocity contribution
            J[3:, i] = zi  # Angular velocity contribution

        # J → 6×7 Jacobian matrix
        # dq → 7×1 joint update
        # error → 6×1 pose error

        # damped least squares update
        JJt = np.dot(J, J.T) # J*J^T becomes 6×6. This makes inversion cheaper and more stable.
        dq = np.dot(np.dot(J.T, np.linalg.inv(JJt + (lam * lam) * np.eye(6))), error) # (J*J^T+λ^2*I)^{-1} = np.linalg.inv(JJt + (lam * lam) * np.eye(6)) is the damping term. Why? Because near singularities: J*J^T can become nearly non-invertible. So adding: λ^2*I stabilizes it. This is called Tikhonov regularization (also known as Ridge regression)
        
        # STEP 4 — Update the joints: like so q_new = q_old + dq (small correction, then repeat):
        q = q + dq # Update the joint angles. Repeat until error is small. dq = J^T(J*J^T+λ^2*I)^{−1}*error. This is the Damped Least Squares (DLS) pseudo-inverse (aka Levenberg-Marquardt stabilization): J^# = J^T(J*J^T+λ^2*I)^{-1}. So: dq = J^# * error
        # DLS pseudo-inverse is a robust numerical method used in robot inverse kinematics to solve J*error_R = error_p when the Jacobian is singular or ill-conditioned. It prevents infinite joint velocities near singularities by adding a damping factor (λ^2) to the inversion.

    return q.tolist()