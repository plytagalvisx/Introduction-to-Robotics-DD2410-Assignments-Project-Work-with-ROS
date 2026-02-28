
"use strict";

let ChangeBuilding = require('./ChangeBuilding.js')
let RenameMap = require('./RenameMap.js')
let SafetyZone = require('./SafetyZone.js')
let ChangeSyncMap = require('./ChangeSyncMap.js')
let ChangeMap = require('./ChangeMap.js')
let SetMapConfiguration = require('./SetMapConfiguration.js')
let VisualLocRecognize = require('./VisualLocRecognize.js')
let ListMaps = require('./ListMaps.js')
let GetSubMap = require('./GetSubMap.js')
let RegisterSync = require('./RegisterSync.js')
let DisableEmergency = require('./DisableEmergency.js')
let SaveMap = require('./SaveMap.js')
let GetMapConfiguration = require('./GetMapConfiguration.js')
let SetSubMapFloor = require('./SetSubMapFloor.js')
let SetPOI = require('./SetPOI.js')
let Acknowledgment = require('./Acknowledgment.js')
let GetNodes = require('./GetNodes.js')
let GetPOI = require('./GetPOI.js')
let FinalApproachPose = require('./FinalApproachPose.js')

module.exports = {
  ChangeBuilding: ChangeBuilding,
  RenameMap: RenameMap,
  SafetyZone: SafetyZone,
  ChangeSyncMap: ChangeSyncMap,
  ChangeMap: ChangeMap,
  SetMapConfiguration: SetMapConfiguration,
  VisualLocRecognize: VisualLocRecognize,
  ListMaps: ListMaps,
  GetSubMap: GetSubMap,
  RegisterSync: RegisterSync,
  DisableEmergency: DisableEmergency,
  SaveMap: SaveMap,
  GetMapConfiguration: GetMapConfiguration,
  SetSubMapFloor: SetSubMapFloor,
  SetPOI: SetPOI,
  Acknowledgment: Acknowledgment,
  GetNodes: GetNodes,
  GetPOI: GetPOI,
  FinalApproachPose: FinalApproachPose,
};
