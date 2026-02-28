
(cl:in-package :asdf)

(defsystem "irob_assignment_1-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :nav_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "GetNextGoalAction" :depends-on ("_package_GetNextGoalAction"))
    (:file "_package_GetNextGoalAction" :depends-on ("_package"))
    (:file "GetNextGoalActionFeedback" :depends-on ("_package_GetNextGoalActionFeedback"))
    (:file "_package_GetNextGoalActionFeedback" :depends-on ("_package"))
    (:file "GetNextGoalActionGoal" :depends-on ("_package_GetNextGoalActionGoal"))
    (:file "_package_GetNextGoalActionGoal" :depends-on ("_package"))
    (:file "GetNextGoalActionResult" :depends-on ("_package_GetNextGoalActionResult"))
    (:file "_package_GetNextGoalActionResult" :depends-on ("_package"))
    (:file "GetNextGoalFeedback" :depends-on ("_package_GetNextGoalFeedback"))
    (:file "_package_GetNextGoalFeedback" :depends-on ("_package"))
    (:file "GetNextGoalGoal" :depends-on ("_package_GetNextGoalGoal"))
    (:file "_package_GetNextGoalGoal" :depends-on ("_package"))
    (:file "GetNextGoalResult" :depends-on ("_package_GetNextGoalResult"))
    (:file "_package_GetNextGoalResult" :depends-on ("_package"))
  ))