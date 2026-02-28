# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "robotics_project: 7 messages, 1 services")

set(MSG_I_FLAGS "-Irobotics_project:/home/milenavi/project_ws/devel/share/robotics_project/msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(robotics_project_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" "robotics_project/PickUpPoseActionGoal:std_msgs/Header:robotics_project/PickUpPoseResult:robotics_project/PickUpPoseActionResult:robotics_project/PickUpPoseActionFeedback:geometry_msgs/PoseStamped:actionlib_msgs/GoalID:actionlib_msgs/GoalStatus:geometry_msgs/Quaternion:robotics_project/PickUpPoseGoal:geometry_msgs/Pose:geometry_msgs/Point:robotics_project/PickUpPoseFeedback"
)

get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" "std_msgs/Header:geometry_msgs/PoseStamped:actionlib_msgs/GoalID:geometry_msgs/Quaternion:robotics_project/PickUpPoseGoal:geometry_msgs/Pose:geometry_msgs/Point"
)

get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" "robotics_project/PickUpPoseResult:actionlib_msgs/GoalStatus:std_msgs/Header:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" "actionlib_msgs/GoalStatus:robotics_project/PickUpPoseFeedback:std_msgs/Header:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" "std_msgs/Header:geometry_msgs/PoseStamped:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point"
)

get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" ""
)

get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" ""
)

get_filename_component(_filename "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" NAME_WE)
add_custom_target(_robotics_project_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "robotics_project" "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)
_generate_msg_cpp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)

### Generating Services
_generate_srv_cpp(robotics_project
  "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
)

### Generating Module File
_generate_module_cpp(robotics_project
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(robotics_project_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(robotics_project_generate_messages robotics_project_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" NAME_WE)
add_dependencies(robotics_project_generate_messages_cpp _robotics_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(robotics_project_gencpp)
add_dependencies(robotics_project_gencpp robotics_project_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS robotics_project_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)
_generate_msg_eus(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)

### Generating Services
_generate_srv_eus(robotics_project
  "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
)

### Generating Module File
_generate_module_eus(robotics_project
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(robotics_project_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(robotics_project_generate_messages robotics_project_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" NAME_WE)
add_dependencies(robotics_project_generate_messages_eus _robotics_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(robotics_project_geneus)
add_dependencies(robotics_project_geneus robotics_project_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS robotics_project_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)
_generate_msg_lisp(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)

### Generating Services
_generate_srv_lisp(robotics_project
  "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
)

### Generating Module File
_generate_module_lisp(robotics_project
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(robotics_project_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(robotics_project_generate_messages robotics_project_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" NAME_WE)
add_dependencies(robotics_project_generate_messages_lisp _robotics_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(robotics_project_genlisp)
add_dependencies(robotics_project_genlisp robotics_project_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS robotics_project_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)
_generate_msg_nodejs(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)

### Generating Services
_generate_srv_nodejs(robotics_project
  "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
)

### Generating Module File
_generate_module_nodejs(robotics_project
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(robotics_project_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(robotics_project_generate_messages robotics_project_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" NAME_WE)
add_dependencies(robotics_project_generate_messages_nodejs _robotics_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(robotics_project_gennodejs)
add_dependencies(robotics_project_gennodejs robotics_project_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS robotics_project_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)
_generate_msg_py(robotics_project
  "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)

### Generating Services
_generate_srv_py(robotics_project
  "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
)

### Generating Module File
_generate_module_py(robotics_project
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(robotics_project_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(robotics_project_generate_messages robotics_project_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv" NAME_WE)
add_dependencies(robotics_project_generate_messages_py _robotics_project_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(robotics_project_genpy)
add_dependencies(robotics_project_genpy robotics_project_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS robotics_project_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/robotics_project
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(robotics_project_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(robotics_project_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(robotics_project_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/robotics_project
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(robotics_project_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(robotics_project_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(robotics_project_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/robotics_project
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(robotics_project_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(robotics_project_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(robotics_project_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/robotics_project
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(robotics_project_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(robotics_project_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(robotics_project_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/robotics_project
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(robotics_project_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(robotics_project_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(robotics_project_generate_messages_py std_msgs_generate_messages_py)
endif()
