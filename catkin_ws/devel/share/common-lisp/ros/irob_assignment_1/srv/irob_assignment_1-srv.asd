
(cl:in-package :asdf)

(defsystem "irob_assignment_1-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :nav_msgs-msg
)
  :components ((:file "_package")
    (:file "GetSetpoint" :depends-on ("_package_GetSetpoint"))
    (:file "_package_GetSetpoint" :depends-on ("_package"))
  ))