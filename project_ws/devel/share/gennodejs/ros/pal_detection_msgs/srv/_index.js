
"use strict";

let StopEnrollment = require('./StopEnrollment.js')
let StartEnrollment = require('./StartEnrollment.js')
let Recognizer = require('./Recognizer.js')
let SelectTexturedObject = require('./SelectTexturedObject.js')
let ChangeObjectRecognizerModel = require('./ChangeObjectRecognizerModel.js')
let AddTexturedObject = require('./AddTexturedObject.js')
let SetDatabase = require('./SetDatabase.js')

module.exports = {
  StopEnrollment: StopEnrollment,
  StartEnrollment: StartEnrollment,
  Recognizer: Recognizer,
  SelectTexturedObject: SelectTexturedObject,
  ChangeObjectRecognizerModel: ChangeObjectRecognizerModel,
  AddTexturedObject: AddTexturedObject,
  SetDatabase: SetDatabase,
};
