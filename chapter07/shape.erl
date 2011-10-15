-module(shape).
-export([area/1, circumference/1]).
-export([circle/1, rectangle/2]).
-include("shape.hrl").


circle(Radius) -> #circle{radius=Radius}.
rectangle(Length, Width) -> #rectangle{length=Length, width=Width}.

area(Shape) when is_record(Shape, circle) ->
  math:pi() * Shape#circle.radius * Shape#circle.radius;

area(Shape) when is_record(Shape, rectangle) ->
  Shape#rectangle.length * Shape#rectangle.width;
area(_) -> ng.

circumference(Shape) when is_record(Shape, circle) ->
  2 * math:pi() * Shape#circle.radius;
circumference(Shape) when is_record(Shape, rectangle) ->
  2 * Shape#rectangle.length + 2 * Shape#rectangle.width;
circumference(_) -> ng.
