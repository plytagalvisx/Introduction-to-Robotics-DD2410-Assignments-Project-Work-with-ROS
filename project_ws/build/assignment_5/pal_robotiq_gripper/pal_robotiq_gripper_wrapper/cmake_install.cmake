# Install script for directory: /home/milenavi/project_ws/src/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/milenavi/project_ws/build/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/catkin_generated/installspace/pal_robotiq_gripper_wrapper.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pal_robotiq_gripper_wrapper/cmake" TYPE FILE FILES
    "/home/milenavi/project_ws/build/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/catkin_generated/installspace/pal_robotiq_gripper_wrapperConfig.cmake"
    "/home/milenavi/project_ws/build/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/catkin_generated/installspace/pal_robotiq_gripper_wrapperConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pal_robotiq_gripper_wrapper" TYPE FILE FILES "/home/milenavi/project_ws/src/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pal_robotiq_gripper_wrapper" TYPE PROGRAM FILES
    "/home/milenavi/project_ws/src/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/scripts/gripper_grasping.py"
    "/home/milenavi/project_ws/src/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/scripts/gripper_epick_grasping.py"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pal_robotiq_gripper_wrapper/launch" TYPE DIRECTORY FILES "/home/milenavi/project_ws/src/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/launch/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pal_robotiq_gripper_wrapper/config" TYPE DIRECTORY FILES "/home/milenavi/project_ws/src/assignment_5/pal_robotiq_gripper/pal_robotiq_gripper_wrapper/config/")
endif()

