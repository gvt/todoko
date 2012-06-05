describe "Todoko", ->

  describe "start()", ->

    beforeEach ->
#      spyOn(ko, 'applyBindings').andCallThrough()
#      console.log "ko.applyBindings", ko.applyBindings
      jasmine.htmlFixture('index.html')
      window.Todoko.start()

    it "exists as a module", ->
      expect(window.Todoko).toBeDefined()

    it "populates vm", ->
      expect(window.Todoko.vm).toBeDefined()

#    it "calls applyBindings", ->
#      console.log "ko.applyBindings 2", ko.applyBindings
#      expect(ko.applyBindings).toHaveBeenCalled()
