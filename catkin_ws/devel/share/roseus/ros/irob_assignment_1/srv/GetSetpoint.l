;; Auto-generated. Do not edit!


(when (boundp 'irob_assignment_1::GetSetpoint)
  (if (not (find-package "IROB_ASSIGNMENT_1"))
    (make-package "IROB_ASSIGNMENT_1"))
  (shadow 'GetSetpoint (find-package "IROB_ASSIGNMENT_1")))
(unless (find-package "IROB_ASSIGNMENT_1::GETSETPOINT")
  (make-package "IROB_ASSIGNMENT_1::GETSETPOINT"))
(unless (find-package "IROB_ASSIGNMENT_1::GETSETPOINTREQUEST")
  (make-package "IROB_ASSIGNMENT_1::GETSETPOINTREQUEST"))
(unless (find-package "IROB_ASSIGNMENT_1::GETSETPOINTRESPONSE")
  (make-package "IROB_ASSIGNMENT_1::GETSETPOINTRESPONSE"))

(in-package "ROS")

(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))


(defclass irob_assignment_1::GetSetpointRequest
  :super ros::object
  :slots (_path ))

(defmethod irob_assignment_1::GetSetpointRequest
  (:init
   (&key
    ((:path __path) (instance nav_msgs::Path :init))
    )
   (send-super :init)
   (setq _path __path)
   self)
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:serialization-length
   ()
   (+
    ;; nav_msgs/Path _path
    (send _path :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; nav_msgs/Path _path
       (send _path :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; nav_msgs/Path _path
     (send _path :deserialize buf ptr-) (incf ptr- (send _path :serialization-length))
   ;;
   self)
  )

(defclass irob_assignment_1::GetSetpointResponse
  :super ros::object
  :slots (_setpoint _new_path ))

(defmethod irob_assignment_1::GetSetpointResponse
  (:init
   (&key
    ((:setpoint __setpoint) (instance geometry_msgs::PointStamped :init))
    ((:new_path __new_path) (instance nav_msgs::Path :init))
    )
   (send-super :init)
   (setq _setpoint __setpoint)
   (setq _new_path __new_path)
   self)
  (:setpoint
   (&rest __setpoint)
   (if (keywordp (car __setpoint))
       (send* _setpoint __setpoint)
     (progn
       (if __setpoint (setq _setpoint (car __setpoint)))
       _setpoint)))
  (:new_path
   (&rest __new_path)
   (if (keywordp (car __new_path))
       (send* _new_path __new_path)
     (progn
       (if __new_path (setq _new_path (car __new_path)))
       _new_path)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/PointStamped _setpoint
    (send _setpoint :serialization-length)
    ;; nav_msgs/Path _new_path
    (send _new_path :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/PointStamped _setpoint
       (send _setpoint :serialize s)
     ;; nav_msgs/Path _new_path
       (send _new_path :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/PointStamped _setpoint
     (send _setpoint :deserialize buf ptr-) (incf ptr- (send _setpoint :serialization-length))
   ;; nav_msgs/Path _new_path
     (send _new_path :deserialize buf ptr-) (incf ptr- (send _new_path :serialization-length))
   ;;
   self)
  )

(defclass irob_assignment_1::GetSetpoint
  :super ros::object
  :slots ())

(setf (get irob_assignment_1::GetSetpoint :md5sum-) "3629cc8e587b54ab374dc14c83d7aa3e")
(setf (get irob_assignment_1::GetSetpoint :datatype-) "irob_assignment_1/GetSetpoint")
(setf (get irob_assignment_1::GetSetpoint :request) irob_assignment_1::GetSetpointRequest)
(setf (get irob_assignment_1::GetSetpoint :response) irob_assignment_1::GetSetpointResponse)

(defmethod irob_assignment_1::GetSetpointRequest
  (:response () (instance irob_assignment_1::GetSetpointResponse :init)))

(setf (get irob_assignment_1::GetSetpointRequest :md5sum-) "3629cc8e587b54ab374dc14c83d7aa3e")
(setf (get irob_assignment_1::GetSetpointRequest :datatype-) "irob_assignment_1/GetSetpointRequest")
(setf (get irob_assignment_1::GetSetpointRequest :definition-)
      "# Define the request
nav_msgs/Path path

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---
# Define the response
geometry_msgs/PointStamped setpoint
nav_msgs/Path new_path

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")

(setf (get irob_assignment_1::GetSetpointResponse :md5sum-) "3629cc8e587b54ab374dc14c83d7aa3e")
(setf (get irob_assignment_1::GetSetpointResponse :datatype-) "irob_assignment_1/GetSetpointResponse")
(setf (get irob_assignment_1::GetSetpointResponse :definition-)
      "# Define the request
nav_msgs/Path path

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---
# Define the response
geometry_msgs/PointStamped setpoint
nav_msgs/Path new_path

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")



(provide :irob_assignment_1/GetSetpoint "3629cc8e587b54ab374dc14c83d7aa3e")


