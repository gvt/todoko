describe "App", ->

  beforeEach ->
    jasmine.htmlFixture('index.html')

  it "works", ->
    expect(window.Todoko).toBeDefined()
    expect(window.Todoko.vm).toBeDefined()
