# Install script for directory: /home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/milenavi/project_ws/build/assignment_5/tiago_navigation/tiago_2dnav/catkin_generated/installspace/tiago_2dnav.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_2dnav/cmake" TYPE FILE FILES
    "/home/milenavi/project_ws/build/assignment_5/tiago_navigation/tiago_2dnav/catkin_generated/installspace/tiago_2dnavConfig.cmake"
    "/home/milenavi/project_ws/build/assignment_5/tiago_navigation/tiago_2dnav/catkin_generated/installspace/tiago_2dnavConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_2dnav" TYPE FILE FILES "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/tiago_2dnav" TYPE PROGRAM FILES
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/record_mapping.sh"
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/record_move_base.sh"
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/record_2dnav.sh"
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/record_odom.sh"
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/record_patrol.sh"
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/record_rgbd.sh"
    "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/scripts/navigation_camera_mgr.py"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_2dnav/launch" TYPE DIRECTORY FILES "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/launch/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_2dnav/config" TYPE DIRECTORY FILES "/home/milenavi/project_ws/src/assignment_5/tiago_navigation/tiago_2dnav/config/")
endif()

