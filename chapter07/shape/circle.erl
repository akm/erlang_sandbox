-module(circle).
-export([new/1]).
-export([area/1, circumference/1]).
-include("shape/circle.hrl").

new(Radius) -> #circle{radius=Radius}.

area(Shape) when is_record(Shape, circle) ->
  math:pi() * Shape#circle.radius * Shape#circle.radius;
area(_) -> ng.

circumference(Shape) when is_record(Shape, circle) ->
  2 * math:pi() * Shape#circle.radius;
circumference(_) -> ng.
