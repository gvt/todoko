unless String::trim
  String::trim = ->
    @replace /^\s+|\s+$/g, ""
