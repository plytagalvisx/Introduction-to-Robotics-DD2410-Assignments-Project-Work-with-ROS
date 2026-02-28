# Install script for directory: /home/milenavi/project_ws/src/assignment_5/robotics_project

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/milenavi/project_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  include("/home/milenavi/project_ws/build/assignment_5/robotics_project/catkin_generated/safe_execute_install.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project/srv" TYPE FILE FILES "/home/milenavi/project_ws/src/assignment_5/robotics_project/srv/MoveHead.srv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project/action" TYPE FILE FILES "/home/milenavi/project_ws/src/assignment_5/robotics_project/action/PickUpPose.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project/msg" TYPE FILE FILES
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseAction.msg"
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionGoal.msg"
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionResult.msg"
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseActionFeedback.msg"
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseGoal.msg"
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseResult.msg"
    "/home/milenavi/project_ws/devel/share/robotics_project/msg/PickUpPoseFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project/cmake" TYPE FILE FILES "/home/milenavi/project_ws/build/assignment_5/robotics_project/catkin_generated/installspace/robotics_project-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/include/robotics_project")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/share/roseus/ros/robotics_project")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/share/common-lisp/ros/robotics_project")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/share/gennodejs/ros/robotics_project")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/milenavi/project_ws/devel/lib/python3/dist-packages/robotics_project")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/lib/python3/dist-packages/robotics_project" REGEX "/\\_\\_init\\_\\_\\.py$" EXCLUDE REGEX "/\\_\\_init\\_\\_\\.pyc$" EXCLUDE)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/lib/python3/dist-packages/robotics_project" FILES_MATCHING REGEX "/home/milenavi/project_ws/devel/lib/python3/dist-packages/robotics_project/.+/__init__.pyc?$")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/robotics_project" TYPE FILE FILES "/home/milenavi/project_ws/devel/include/robotics_project/SphericalGraspConfig.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/milenavi/project_ws/devel/lib/python3/dist-packages/robotics_project/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/robotics_project" TYPE DIRECTORY FILES "/home/milenavi/project_ws/devel/lib/python3/dist-packages/robotics_project/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/milenavi/project_ws/build/assignment_5/robotics_project/catkin_generated/installspace/robotics_project.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project/cmake" TYPE FILE FILES "/home/milenavi/project_ws/build/assignment_5/robotics_project/catkin_generated/installspace/robotics_project-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project/cmake" TYPE FILE FILES
    "/home/milenavi/project_ws/build/assignment_5/robotics_project/catkin_generated/installspace/robotics_projectConfig.cmake"
    "/home/milenavi/project_ws/build/assignment_5/robotics_project/catkin_generated/installspace/robotics_projectConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project" TYPE FILE FILES "/home/milenavi/project_ws/src/assignment_5/robotics_project/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/robotics_project" TYPE DIRECTORY FILES
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/launch"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/config"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/robotics_project" TYPE PROGRAM FILES
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/state_machines/sm_students.py"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/behaviour_trees/bt_students.py"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/utils/poses_pub.py"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/utils/gazebo_models_hdl.py"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/utils/grasps_server.py"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/utils/manipulation_client.py"
    "/home/milenavi/project_ws/src/assignment_5/robotics_project/scripts/utils/manipulation_server.py"
    )
endif()

