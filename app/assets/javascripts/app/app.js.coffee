window.Todoko = {}
@startTodoko = ->
  console.log "start() ..."
  todos = ko.utils.parseJson(localStorage.getItem("todos-knockout"))
  window.Todoko.vm = new Todoko.ViewModel(todos || [])
  ko.applyBindings window.Todoko.vm


class Todoko.Todo
  constructor: (title, completed) ->
    @title     = ko.observable title
    @completed = ko.observable completed
    @editing   = ko.observable false


class Todoko.ViewModel
  constructor: (todos) ->
    @initObservables(todos)

  initObservables: (todos) ->
    @el = ko.observable() # will contain a jquery object

    @todos = ko.observableArray ko.utils.arrayMap(todos, (todo) ->
      new Todoko.Todo(todo.title, todo.completed)
    )

    @current = ko.observable()

    @completedCount = ko.computed =>
      ko.utils.arrayFilter(@todos(), (todo) ->
        todo.completed()
      ).length

    @remainingCount = ko.computed =>
      @todos().length - @completedCount()

    @allCompleted = ko.computed
      read: =>
        not @remainingCount()
      write: (newValue) =>
        ko.utils.arrayForEach @todos(), (todo) ->
          todo.completed newValue

    ko.computed( =>
      localStorage.setItem "todos-knockout", ko.toJSON(@todos)
    ).extend throttle: 500


  changeTaskPosition: (self, event) =>
    console.log "changeTaskPosition() ..."
    @didChangePosition = true

  add: =>
    current = @current()?.trim()
    if current
      @todos.push new Todoko.Todo(current)
      @current ""

  remove: (todo) =>
    @todos.remove todo

  removeCompleted: =>
    @todos.remove (todo) =>
      todo.completed()

  editItem: (item) =>
    item.editing true

  stopEditing: (item) =>
    item.editing false
    @remove item  unless item.title().trim()

  getLabel: (count) ->
    if ko.utils.unwrapObservable(count) is 1 then "item" else "items"
