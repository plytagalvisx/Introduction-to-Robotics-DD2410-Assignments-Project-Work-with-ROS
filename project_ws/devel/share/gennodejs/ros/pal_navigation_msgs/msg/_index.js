
"use strict";

let GoToActionResult = require('./GoToActionResult.js');
let VisualTrainingActionResult = require('./VisualTrainingActionResult.js');
let JoyTurboResult = require('./JoyTurboResult.js');
let ExecuteParkingActionResult = require('./ExecuteParkingActionResult.js');
let JoyTurboActionResult = require('./JoyTurboActionResult.js');
let ExecuteParkingActionFeedback = require('./ExecuteParkingActionFeedback.js');
let VisualTrainingActionFeedback = require('./VisualTrainingActionFeedback.js');
let GoToPOIAction = require('./GoToPOIAction.js');
let JoyPriorityGoal = require('./JoyPriorityGoal.js');
let ExecuteParkingActionGoal = require('./ExecuteParkingActionGoal.js');
let GoToResult = require('./GoToResult.js');
let GoToActionGoal = require('./GoToActionGoal.js');
let GoToActionFeedback = require('./GoToActionFeedback.js');
let VisualTrainingResult = require('./VisualTrainingResult.js');
let VisualTrainingActionGoal = require('./VisualTrainingActionGoal.js');
let JoyPriorityAction = require('./JoyPriorityAction.js');
let JoyTurboGoal = require('./JoyTurboGoal.js');
let JoyTurboActionGoal = require('./JoyTurboActionGoal.js');
let GoToGoal = require('./GoToGoal.js');
let GoToPOIGoal = require('./GoToPOIGoal.js');
let GoToPOIActionGoal = require('./GoToPOIActionGoal.js');
let GoToFeedback = require('./GoToFeedback.js');
let GoToPOIActionResult = require('./GoToPOIActionResult.js');
let JoyTurboAction = require('./JoyTurboAction.js');
let VisualTrainingFeedback = require('./VisualTrainingFeedback.js');
let GoToPOIResult = require('./GoToPOIResult.js');
let GoToAction = require('./GoToAction.js');
let GoToPOIActionFeedback = require('./GoToPOIActionFeedback.js');
let JoyTurboActionFeedback = require('./JoyTurboActionFeedback.js');
let JoyPriorityActionFeedback = require('./JoyPriorityActionFeedback.js');
let GoToPOIFeedback = require('./GoToPOIFeedback.js');
let ExecuteParkingFeedback = require('./ExecuteParkingFeedback.js');
let ExecuteParkingResult = require('./ExecuteParkingResult.js');
let JoyTurboFeedback = require('./JoyTurboFeedback.js');
let JoyPriorityActionGoal = require('./JoyPriorityActionGoal.js');
let JoyPriorityResult = require('./JoyPriorityResult.js');
let JoyPriorityFeedback = require('./JoyPriorityFeedback.js');
let JoyPriorityActionResult = require('./JoyPriorityActionResult.js');
let ExecuteParkingAction = require('./ExecuteParkingAction.js');
let VisualTrainingAction = require('./VisualTrainingAction.js');
let VisualTrainingGoal = require('./VisualTrainingGoal.js');
let ExecuteParkingGoal = require('./ExecuteParkingGoal.js');
let PolarReading = require('./PolarReading.js');
let AvailableMaps = require('./AvailableMaps.js');
let NavigationStatus = require('./NavigationStatus.js');
let POI = require('./POI.js');
let ServiceStatus = require('./ServiceStatus.js');
let NiceMapTransformation = require('./NiceMapTransformation.js');
let PolarReadingScan = require('./PolarReadingScan.js');
let POIGroup = require('./POIGroup.js');
let MapConfiguration = require('./MapConfiguration.js');
let EulerAngles = require('./EulerAngles.js');
let LaserImage = require('./LaserImage.js');
let TabletPOI = require('./TabletPOI.js');
let VisualLocDB = require('./VisualLocDB.js');
let Emergency = require('./Emergency.js');
let Highways = require('./Highways.js');
let EulerAnglesStamped = require('./EulerAnglesStamped.js');

module.exports = {
  GoToActionResult: GoToActionResult,
  VisualTrainingActionResult: VisualTrainingActionResult,
  JoyTurboResult: JoyTurboResult,
  ExecuteParkingActionResult: ExecuteParkingActionResult,
  JoyTurboActionResult: JoyTurboActionResult,
  ExecuteParkingActionFeedback: ExecuteParkingActionFeedback,
  VisualTrainingActionFeedback: VisualTrainingActionFeedback,
  GoToPOIAction: GoToPOIAction,
  JoyPriorityGoal: JoyPriorityGoal,
  ExecuteParkingActionGoal: ExecuteParkingActionGoal,
  GoToResult: GoToResult,
  GoToActionGoal: GoToActionGoal,
  GoToActionFeedback: GoToActionFeedback,
  VisualTrainingResult: VisualTrainingResult,
  VisualTrainingActionGoal: VisualTrainingActionGoal,
  JoyPriorityAction: JoyPriorityAction,
  JoyTurboGoal: JoyTurboGoal,
  JoyTurboActionGoal: JoyTurboActionGoal,
  GoToGoal: GoToGoal,
  GoToPOIGoal: GoToPOIGoal,
  GoToPOIActionGoal: GoToPOIActionGoal,
  GoToFeedback: GoToFeedback,
  GoToPOIActionResult: GoToPOIActionResult,
  JoyTurboAction: JoyTurboAction,
  VisualTrainingFeedback: VisualTrainingFeedback,
  GoToPOIResult: GoToPOIResult,
  GoToAction: GoToAction,
  GoToPOIActionFeedback: GoToPOIActionFeedback,
  JoyTurboActionFeedback: JoyTurboActionFeedback,
  JoyPriorityActionFeedback: JoyPriorityActionFeedback,
  GoToPOIFeedback: GoToPOIFeedback,
  ExecuteParkingFeedback: ExecuteParkingFeedback,
  ExecuteParkingResult: ExecuteParkingResult,
  JoyTurboFeedback: JoyTurboFeedback,
  JoyPriorityActionGoal: JoyPriorityActionGoal,
  JoyPriorityResult: JoyPriorityResult,
  JoyPriorityFeedback: JoyPriorityFeedback,
  JoyPriorityActionResult: JoyPriorityActionResult,
  ExecuteParkingAction: ExecuteParkingAction,
  VisualTrainingAction: VisualTrainingAction,
  VisualTrainingGoal: VisualTrainingGoal,
  ExecuteParkingGoal: ExecuteParkingGoal,
  PolarReading: PolarReading,
  AvailableMaps: AvailableMaps,
  NavigationStatus: NavigationStatus,
  POI: POI,
  ServiceStatus: ServiceStatus,
  NiceMapTransformation: NiceMapTransformation,
  PolarReadingScan: PolarReadingScan,
  POIGroup: POIGroup,
  MapConfiguration: MapConfiguration,
  EulerAngles: EulerAngles,
  LaserImage: LaserImage,
  TabletPOI: TabletPOI,
  VisualLocDB: VisualLocDB,
  Emergency: Emergency,
  Highways: Highways,
  EulerAnglesStamped: EulerAnglesStamped,
};
