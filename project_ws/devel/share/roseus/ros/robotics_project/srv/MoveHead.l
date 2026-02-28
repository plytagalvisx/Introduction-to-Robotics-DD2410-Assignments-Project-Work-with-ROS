;; Auto-generated. Do not edit!


(when (boundp 'robotics_project::MoveHead)
  (if (not (find-package "ROBOTICS_PROJECT"))
    (make-package "ROBOTICS_PROJECT"))
  (shadow 'MoveHead (find-package "ROBOTICS_PROJECT")))
(unless (find-package "ROBOTICS_PROJECT::MOVEHEAD")
  (make-package "ROBOTICS_PROJECT::MOVEHEAD"))
(unless (find-package "ROBOTICS_PROJECT::MOVEHEADREQUEST")
  (make-package "ROBOTICS_PROJECT::MOVEHEADREQUEST"))
(unless (find-package "ROBOTICS_PROJECT::MOVEHEADRESPONSE")
  (make-package "ROBOTICS_PROJECT::MOVEHEADRESPONSE"))

(in-package "ROS")





(defclass robotics_project::MoveHeadRequest
  :super ros::object
  :slots (_motion ))

(defmethod robotics_project::MoveHeadRequest
  (:init
   (&key
    ((:motion __motion) "")
    )
   (send-super :init)
   (setq _motion (string __motion))
   self)
  (:motion
   (&optional __motion)
   (if __motion (setq _motion __motion)) _motion)
  (:serialization-length
   ()
   (+
    ;; string _motion
    4 (length _motion)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _motion
       (write-long (length _motion) s) (princ _motion s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _motion
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _motion (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass robotics_project::MoveHeadResponse
  :super ros::object
  :slots (_success ))

(defmethod robotics_project::MoveHeadResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass robotics_project::MoveHead
  :super ros::object
  :slots ())

(setf (get robotics_project::MoveHead :md5sum-) "3ceff7a00b3f71368b0b0f59df1b9c42")
(setf (get robotics_project::MoveHead :datatype-) "robotics_project/MoveHead")
(setf (get robotics_project::MoveHead :request) robotics_project::MoveHeadRequest)
(setf (get robotics_project::MoveHead :response) robotics_project::MoveHeadResponse)

(defmethod robotics_project::MoveHeadRequest
  (:response () (instance robotics_project::MoveHeadResponse :init)))

(setf (get robotics_project::MoveHeadRequest :md5sum-) "3ceff7a00b3f71368b0b0f59df1b9c42")
(setf (get robotics_project::MoveHeadRequest :datatype-) "robotics_project/MoveHeadRequest")
(setf (get robotics_project::MoveHeadRequest :definition-)
      "string motion
---
bool success
")

(setf (get robotics_project::MoveHeadResponse :md5sum-) "3ceff7a00b3f71368b0b0f59df1b9c42")
(setf (get robotics_project::MoveHeadResponse :datatype-) "robotics_project/MoveHeadResponse")
(setf (get robotics_project::MoveHeadResponse :definition-)
      "string motion
---
bool success
")



(provide :robotics_project/MoveHead "3ceff7a00b3f71368b0b0f59df1b9c42")


