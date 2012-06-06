(function() {
  $.extend(this, {
    content: function() {
      return $("#jasmine_content");
    },
    htmlFixture: function(pathToHtmlFile) {
      jasmine.content().empty().append(jasmine.fixture(pathToHtmlFile));
    }
  });
}).apply(jasmine);

beforeEach(function() {
  jasmine.content().empty();
});

afterEach(function() {
//  jasmine.content().empty();
});
