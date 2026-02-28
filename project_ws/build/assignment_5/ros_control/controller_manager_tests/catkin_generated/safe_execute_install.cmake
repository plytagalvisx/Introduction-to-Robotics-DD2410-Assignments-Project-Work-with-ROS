execute_process(COMMAND "/home/milenavi/project_ws/build/assignment_5/ros_control/controller_manager_tests/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/milenavi/project_ws/build/assignment_5/ros_control/controller_manager_tests/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
