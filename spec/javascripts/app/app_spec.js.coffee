describe "Todoko", ->

  describe "start()", ->

    beforeEach ->
      jasmine.htmlFixture('index.html')
      window.Todoko.start()

    it "exists as a module", ->
      expect(window.Todoko).toBeDefined()

    it "populates vm", ->
      expect(window.Todoko.vm).toBeDefined()
      expect(window.Todoko.vm).toEqual jasmine.any Todoko.ViewModel
