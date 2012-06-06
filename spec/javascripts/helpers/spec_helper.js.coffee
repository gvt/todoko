beforeEach ->
  # move the content below the test results
  jasmine.content().remove().appendTo $('body')


##
# performs a drag like a human would. no return value.
@dragTask = (dragHandle, dx, dy) =>
  $(dragHandle).simulate('drag', dx: dx, dy: dy)

##
# returns a 1-based value to tell where $dragHandle is positioned within $draggableScope
# depends on the markup being structure in a particular way... UL and LI's
@getTaskPosition = ($dragHandle, $draggableScope) =>
  $sorted    = $dragHandle # the element that was dragged
  $sortables = $($dragHandle, $draggableScope).parents('ul').children().find('label') # all the sortable elements
  $sortables.index $sorted
