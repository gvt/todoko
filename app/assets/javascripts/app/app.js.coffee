$ ->
  "use strict"
  ENTER_KEY = 13

  unless String::trim
    String::trim = ->
      @replace /^\s+|\s+$/g, ""

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

  class Todo
    constructor: (title, completed) ->
      @title     = ko.observable title
      @completed = ko.observable completed
      @editing   = ko.observable false

  class ViewModel
    constructor: (todos) ->
      @todos = ko.observableArray(ko.utils.arrayMap(todos, (todo) ->
        new Todo(todo.title, todo.completed)
      ))
      @current = ko.observable()
      @add = =>
        current = @current().trim()
        if current
          @todos.push new Todo(current)
          @current ""

      @remove = (todo) =>
        @todos.remove todo

      @removeCompleted = =>
        @todos.remove (todo) =>
          todo.completed()

      @editItem = (item) =>
        item.editing true

      @stopEditing = (item) =>
        item.editing false
        @remove item  unless item.title().trim()

      @completedCount = ko.computed(=>
        ko.utils.arrayFilter(@todos(), (todo) ->
          todo.completed()
        ).length
      )
      @remainingCount = ko.computed(=>
        @todos().length - @completedCount()
      )
      @allCompleted = ko.computed(
        read: =>
          not @remainingCount()

        write: (newValue) =>
          ko.utils.arrayForEach @todos(), (todo) ->
            todo.completed newValue
      )
      @getLabel = (count) ->
        if ko.utils.unwrapObservable(count) is 1 then "item" else "items"

      ko.computed( =>
        localStorage.setItem "todos-knockout", ko.toJSON(@todos)
      ).extend throttle: 500

  todos = ko.utils.parseJson localStorage.getItem "todos-knockout"
  ko.applyBindings new ViewModel(todos or [])
