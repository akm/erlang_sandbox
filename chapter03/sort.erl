-module(sort).
-export([quick/1]).

quick([Pivot|Tail]) -> quick_acc(Pivot, Tail, [], []).
quick_acc(Pivot, [], Smaller, Larger) ->
  Smaller ++ [Pivot] ++ Larger;
quick_acc(Pivot, [H|T], Smaller, Larger) when H =< Pivot ->
  quick_acc(Pivot, T, [H|Smaller], Larger);
quick_acc(Pivot, [H|T], Smaller, Larger) when H > Pivot ->
  quick_acc(Pivot, T, Smaller, [H|Larger]).
