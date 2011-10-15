-module(rectangle).
-export([new/2]).
-export([area/1, circumference/1]).
-include("shape/rectangle.hrl").

new(Length, Width) -> #rectangle{length=Length, width=Width}.

area(Shape) when is_record(Shape, rectangle) ->
  Shape#rectangle.length * Shape#rectangle.width;
area(_) -> ng.

circumference(Shape) when is_record(Shape, rectangle) ->
  2 * Shape#rectangle.length + 2 * Shape#rectangle.width;
circumference(_) -> ng.
