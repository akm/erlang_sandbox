-module(triangle).
-export([new/3]).
-export([area/1, circumference/1]).
-include("shape/triangle.hrl").

new(A,B,C) -> #triangle3edges{a=A, b=B, c=C}.

% http://keisan.casio.jp/has10/SpecExec.cgi
area(Shape) when is_record(Shape, triangle3edges) ->
  S = circumference(Shape) / 2,
  math:sqrt(S * (S - Shape#triangle3edges.a) * (S - Shape#triangle3edges.b) * (S - Shape#triangle3edges.c));
area(_) -> ng.

circumference(Shape) when is_record(Shape, triangle3edges) ->
  Shape#triangle3edges.a + Shape#triangle3edges.b + Shape#triangle3edges.c;
circumference(_) -> ng.
