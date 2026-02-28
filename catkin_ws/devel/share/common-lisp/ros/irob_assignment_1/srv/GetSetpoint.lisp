; Auto-generated. Do not edit!


(cl:in-package irob_assignment_1-srv)


;//! \htmlinclude GetSetpoint-request.msg.html

(cl:defclass <GetSetpoint-request> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type nav_msgs-msg:Path
    :initform (cl:make-instance 'nav_msgs-msg:Path)))
)

(cl:defclass GetSetpoint-request (<GetSetpoint-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetSetpoint-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetSetpoint-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name irob_assignment_1-srv:<GetSetpoint-request> is deprecated: use irob_assignment_1-srv:GetSetpoint-request instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <GetSetpoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader irob_assignment_1-srv:path-val is deprecated.  Use irob_assignment_1-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetSetpoint-request>) ostream)
  "Serializes a message object of type '<GetSetpoint-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'path) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetSetpoint-request>) istream)
  "Deserializes a message object of type '<GetSetpoint-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'path) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetSetpoint-request>)))
  "Returns string type for a service object of type '<GetSetpoint-request>"
  "irob_assignment_1/GetSetpointRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetSetpoint-request)))
  "Returns string type for a service object of type 'GetSetpoint-request"
  "irob_assignment_1/GetSetpointRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetSetpoint-request>)))
  "Returns md5sum for a message object of type '<GetSetpoint-request>"
  "3629cc8e587b54ab374dc14c83d7aa3e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetSetpoint-request)))
  "Returns md5sum for a message object of type 'GetSetpoint-request"
  "3629cc8e587b54ab374dc14c83d7aa3e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetSetpoint-request>)))
  "Returns full string definition for message of type '<GetSetpoint-request>"
  (cl:format cl:nil "# Define the request~%nav_msgs/Path path~%~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetSetpoint-request)))
  "Returns full string definition for message of type 'GetSetpoint-request"
  (cl:format cl:nil "# Define the request~%nav_msgs/Path path~%~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetSetpoint-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetSetpoint-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetSetpoint-request
    (cl:cons ':path (path msg))
))
;//! \htmlinclude GetSetpoint-response.msg.html

(cl:defclass <GetSetpoint-response> (roslisp-msg-protocol:ros-message)
  ((setpoint
    :reader setpoint
    :initarg :setpoint
    :type geometry_msgs-msg:PointStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PointStamped))
   (new_path
    :reader new_path
    :initarg :new_path
    :type nav_msgs-msg:Path
    :initform (cl:make-instance 'nav_msgs-msg:Path)))
)

(cl:defclass GetSetpoint-response (<GetSetpoint-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetSetpoint-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetSetpoint-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name irob_assignment_1-srv:<GetSetpoint-response> is deprecated: use irob_assignment_1-srv:GetSetpoint-response instead.")))

(cl:ensure-generic-function 'setpoint-val :lambda-list '(m))
(cl:defmethod setpoint-val ((m <GetSetpoint-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader irob_assignment_1-srv:setpoint-val is deprecated.  Use irob_assignment_1-srv:setpoint instead.")
  (setpoint m))

(cl:ensure-generic-function 'new_path-val :lambda-list '(m))
(cl:defmethod new_path-val ((m <GetSetpoint-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader irob_assignment_1-srv:new_path-val is deprecated.  Use irob_assignment_1-srv:new_path instead.")
  (new_path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetSetpoint-response>) ostream)
  "Serializes a message object of type '<GetSetpoint-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'setpoint) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'new_path) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetSetpoint-response>) istream)
  "Deserializes a message object of type '<GetSetpoint-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'setpoint) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'new_path) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetSetpoint-response>)))
  "Returns string type for a service object of type '<GetSetpoint-response>"
  "irob_assignment_1/GetSetpointResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetSetpoint-response)))
  "Returns string type for a service object of type 'GetSetpoint-response"
  "irob_assignment_1/GetSetpointResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetSetpoint-response>)))
  "Returns md5sum for a message object of type '<GetSetpoint-response>"
  "3629cc8e587b54ab374dc14c83d7aa3e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetSetpoint-response)))
  "Returns md5sum for a message object of type 'GetSetpoint-response"
  "3629cc8e587b54ab374dc14c83d7aa3e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetSetpoint-response>)))
  "Returns full string definition for message of type '<GetSetpoint-response>"
  (cl:format cl:nil "# Define the response~%geometry_msgs/PointStamped setpoint~%nav_msgs/Path new_path~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetSetpoint-response)))
  "Returns full string definition for message of type 'GetSetpoint-response"
  (cl:format cl:nil "# Define the response~%geometry_msgs/PointStamped setpoint~%nav_msgs/Path new_path~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetSetpoint-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'setpoint))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'new_path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetSetpoint-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetSetpoint-response
    (cl:cons ':setpoint (setpoint msg))
    (cl:cons ':new_path (new_path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetSetpoint)))
  'GetSetpoint-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetSetpoint)))
  'GetSetpoint-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetSetpoint)))
  "Returns string type for a service object of type '<GetSetpoint>"
  "irob_assignment_1/GetSetpoint")