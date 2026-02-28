
(cl:in-package :asdf)

(defsystem "robotics_project-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "MoveHead" :depends-on ("_package_MoveHead"))
    (:file "_package_MoveHead" :depends-on ("_package"))
  ))