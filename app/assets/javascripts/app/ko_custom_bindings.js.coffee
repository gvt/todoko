"use strict"
ENTER_KEY = 13

ko.bindingHandlers.enterKey =
  init: (element, valueAccessor, allBindingsAccessor, data) ->
    wrappedHandler = (data, event) ->
      valueAccessor().call this, data, event  if event.keyCode is ENTER_KEY
    newValueAccessor = ->
      keyup: wrappedHandler
    ko.bindingHandlers.event.init element, newValueAccessor, allBindingsAccessor, data

ko.bindingHandlers.selectAndFocus =
  init: (element, valueAccessor, allBindingsAccessor) ->
    ko.bindingHandlers.hasfocus.init element, valueAccessor, allBindingsAccessor
    ko.utils.registerEventHandler element, "focus", ->
      element.select()
  update: (element, valueAccessor) ->
    ko.utils.unwrapObservable valueAccessor()
    setTimeout ->
      ko.bindingHandlers.hasfocus.update element, valueAccessor
    , 0
