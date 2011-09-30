-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

% echo:start() => ok
% echo:print(Term) => ok
% echo:stop() => ok

start() ->
  register(echo, spawn(echo, loop, [])).

stop() ->
  echo ! stop.

print(Term) ->
  echo ! {print, Term}.

loop() ->
  receive
    stop -> ok;
    {print, Msg} ->
      io:format("~w~n", [Msg]),
      loop()
  end.
