
"use strict";

let FaceDetections = require('./FaceDetections.js');
let FaceDetection = require('./FaceDetection.js');
let LegDetections = require('./LegDetections.js');
let DetectedPerson = require('./DetectedPerson.js');
let HeadPanTilt = require('./HeadPanTilt.js');
let HogDetections = require('./HogDetections.js');
let HogDetection = require('./HogDetection.js');
let Rectangle = require('./Rectangle.js');
let FollowMeResponse = require('./FollowMeResponse.js');
let Gesture = require('./Gesture.js');
let DetectedObject = require('./DetectedObject.js');
let FaceRecognitionFeedback = require('./FaceRecognitionFeedback.js');
let FaceRecognitionActionFeedback = require('./FaceRecognitionActionFeedback.js');
let FaceRecognitionGoal = require('./FaceRecognitionGoal.js');
let FaceRecognitionActionGoal = require('./FaceRecognitionActionGoal.js');
let FaceRecognitionAction = require('./FaceRecognitionAction.js');
let FaceRecognitionResult = require('./FaceRecognitionResult.js');
let FaceRecognitionActionResult = require('./FaceRecognitionActionResult.js');

module.exports = {
  FaceDetections: FaceDetections,
  FaceDetection: FaceDetection,
  LegDetections: LegDetections,
  DetectedPerson: DetectedPerson,
  HeadPanTilt: HeadPanTilt,
  HogDetections: HogDetections,
  HogDetection: HogDetection,
  Rectangle: Rectangle,
  FollowMeResponse: FollowMeResponse,
  Gesture: Gesture,
  DetectedObject: DetectedObject,
  FaceRecognitionFeedback: FaceRecognitionFeedback,
  FaceRecognitionActionFeedback: FaceRecognitionActionFeedback,
  FaceRecognitionGoal: FaceRecognitionGoal,
  FaceRecognitionActionGoal: FaceRecognitionActionGoal,
  FaceRecognitionAction: FaceRecognitionAction,
  FaceRecognitionResult: FaceRecognitionResult,
  FaceRecognitionActionResult: FaceRecognitionActionResult,
};
