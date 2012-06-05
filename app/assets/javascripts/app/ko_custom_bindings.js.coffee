##
# sets the "el" of a view to the jQuery object of the top-level DOM node for said view.
ko.bindingHandlers.element =
  init: (element, valueAccessor, allBindingsAccessor, viewModel) ->
    viewModel.el $(element)


##
# handles the enter key press on a task
ko.bindingHandlers.enterKey =
  init: (element, valueAccessor, allBindingsAccessor, data) ->
    wrappedHandler = (data, event) ->
      valueAccessor().call this, data, event  if event.keyCode is $.ui.keyCode.ENTER
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
