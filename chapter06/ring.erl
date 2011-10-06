-module(ring).
-export([start/3, setup/3]).

start(M, N, Msg) ->
  io:format("~w Origin start~n", [self()]),
  Next = spawn_link(ring, setup, [self(), M, N-2]),
  receive
    {setup_complete, Last} -> 
      io:format("~w setup_complete by ~w ~n", [self(), Last]),
      Next ! Msg,
      loop(Next, M)
  end.

setup(Origin, M, 0) ->
  io:format("~w Last process setup start~n", [self()]),
  Origin ! {setup_complete, self()},
  loop(Origin, M);
setup(Origin, M, N) ->
  io:format("~w process setup start~n", [self()]),
  Pid = spawn_link(ring, setup, [Origin, M, N-1]),
  loop(Pid, M).

add_one(Int) -> Int + 1.

loop(_Next, 0) ->
  io:format("~w raise error ~n", [self()]),
  add_one(one);
loop(Next, M) ->
  io:format("~w loop for ~w ~n", [self(), M]),
  receive
    {'EXIT', Pid, Msg} ->
      io:format("~w EXIT ~w~n", [Pid, Msg]);
    Msg ->
      io:format("~w sending ~w~n", [self(), Msg]),
      Next ! Msg,
      loop(Next, M-1)
  end.
