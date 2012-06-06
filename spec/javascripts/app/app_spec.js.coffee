describe "Todoko", ->

  describe "start()", ->

    beforeEach ->
      jasmine.htmlFixture('index.html')
      window.startTodoko()

    it "exists as a module", ->
      expect(window.Todoko).toBeDefined()

    it "populates vm", ->
      expect(window.Todoko.vm).toBeDefined()
      expect(window.Todoko.vm).toEqual jasmine.any Todoko.ViewModel


  describe "dragndrop a task", ->

    beforeEach ->
      # general setup
      jasmine.htmlFixture('index.html')
      window.startTodoko()
      @vm = window.Todoko.vm
      @todo1 = new Todoko.Todo('Task one')
      @todo2 = new Todoko.Todo('Task two')
      @vm.todos [@todo1, @todo2]
      # verify that the state is as expected
      expect(@vm.el().length).toEqual 1
      expect(@vm.todos().length).toEqual 2
      # draggables setup
      @$draggableScope = $('#todo-list', @vm.el())
      @$draggable      = @$draggableScope.find('li:eq(0) label')
      @$dragHandle     = @$draggable
      # verify that the draggables are as expected
      expect(@$draggableScope.find("li:eq(0)").text().trim()).toEqual "Task one"
      expect(@$draggableScope.find("li:eq(1)").text().trim()).toEqual "Task two"

      # for verification later
      @oldIndex = getTaskPosition @$dragHandle, @$draggableScope
      # drag it
      runs =>
        dragTask @$dragHandle, 0, 60
      # let the browser catch up
      waits 305

    it "moves the task from 1st to 2nd", ->
      runs =>
        newIndex = getTaskPosition @$dragHandle, @$draggableScope
        expect(newIndex).toEqual @oldIndex + 1
        expect(@$draggableScope.find("li:eq(0)").text().trim()).toEqual "Task two"
        expect(@$draggableScope.find("li:eq(1)").text().trim()).toEqual "Task one"

    it "has its didChangePosition set to true", ->
      runs =>
        expect(@vm.didChangePosition).toBe true
