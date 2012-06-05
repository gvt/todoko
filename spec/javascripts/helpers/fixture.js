(function() {
  var fixtures = {};
  $.extend(this, {
    fixture: function(name) {
      if (! fixtures[name]) {
        var count = 0;
        var request = new XMLHttpRequest();
        while (request.responseText.length == 0 && count < 5) {
          request.open("GET", "/__spec__/fixtures/" + name.replace(/^\//, '') + "?" + new Date().getTime(), false);
          request.send(null);
          count++;
        }
        fixtures[name] = request.responseText;
      }
      return fixtures[name];
    }
  });
}).apply(jasmine);

