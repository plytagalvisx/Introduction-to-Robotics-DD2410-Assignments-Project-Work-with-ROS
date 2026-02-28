; Auto-generated. Do not edit!


(cl:in-package robotics_project-srv)


;//! \htmlinclude MoveHead-request.msg.html

(cl:defclass <MoveHead-request> (roslisp-msg-protocol:ros-message)
  ((motion
    :reader motion
    :initarg :motion
    :type cl:string
    :initform ""))
)

(cl:defclass MoveHead-request (<MoveHead-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveHead-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveHead-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robotics_project-srv:<MoveHead-request> is deprecated: use robotics_project-srv:MoveHead-request instead.")))

(cl:ensure-generic-function 'motion-val :lambda-list '(m))
(cl:defmethod motion-val ((m <MoveHead-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotics_project-srv:motion-val is deprecated.  Use robotics_project-srv:motion instead.")
  (motion m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveHead-request>) ostream)
  "Serializes a message object of type '<MoveHead-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'motion))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'motion))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveHead-request>) istream)
  "Deserializes a message object of type '<MoveHead-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'motion) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'motion) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveHead-request>)))
  "Returns string type for a service object of type '<MoveHead-request>"
  "robotics_project/MoveHeadRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveHead-request)))
  "Returns string type for a service object of type 'MoveHead-request"
  "robotics_project/MoveHeadRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveHead-request>)))
  "Returns md5sum for a message object of type '<MoveHead-request>"
  "3ceff7a00b3f71368b0b0f59df1b9c42")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveHead-request)))
  "Returns md5sum for a message object of type 'MoveHead-request"
  "3ceff7a00b3f71368b0b0f59df1b9c42")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveHead-request>)))
  "Returns full string definition for message of type '<MoveHead-request>"
  (cl:format cl:nil "string motion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveHead-request)))
  "Returns full string definition for message of type 'MoveHead-request"
  (cl:format cl:nil "string motion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveHead-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'motion))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveHead-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveHead-request
    (cl:cons ':motion (motion msg))
))
;//! \htmlinclude MoveHead-response.msg.html

(cl:defclass <MoveHead-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass MoveHead-response (<MoveHead-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveHead-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveHead-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robotics_project-srv:<MoveHead-response> is deprecated: use robotics_project-srv:MoveHead-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <MoveHead-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotics_project-srv:success-val is deprecated.  Use robotics_project-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveHead-response>) ostream)
  "Serializes a message object of type '<MoveHead-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveHead-response>) istream)
  "Deserializes a message object of type '<MoveHead-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveHead-response>)))
  "Returns string type for a service object of type '<MoveHead-response>"
  "robotics_project/MoveHeadResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveHead-response)))
  "Returns string type for a service object of type 'MoveHead-response"
  "robotics_project/MoveHeadResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveHead-response>)))
  "Returns md5sum for a message object of type '<MoveHead-response>"
  "3ceff7a00b3f71368b0b0f59df1b9c42")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveHead-response)))
  "Returns md5sum for a message object of type 'MoveHead-response"
  "3ceff7a00b3f71368b0b0f59df1b9c42")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveHead-response>)))
  "Returns full string definition for message of type '<MoveHead-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveHead-response)))
  "Returns full string definition for message of type 'MoveHead-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveHead-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveHead-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveHead-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MoveHead)))
  'MoveHead-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MoveHead)))
  'MoveHead-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveHead)))
  "Returns string type for a service object of type '<MoveHead>"
  "robotics_project/MoveHead")