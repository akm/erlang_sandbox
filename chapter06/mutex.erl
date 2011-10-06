-module(mutex).
-export([start/0, stop/0, show/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() -> register(mutex, spawn(?MODULE, init, [])).
stop()  -> mutex ! stop.
show()  -> mutex ! show.

wait() ->
  mutex ! {wait, self()},
  receive ok -> ok end.

signal() ->
  mutex ! {signal, self()}, ok.

init() -> free().

free() ->
  receive
    show -> io:format("mutex belongs to no one", []), free();
    {wait, Pid} -> Pid ! ok, busy(Pid);
    stop -> terminate()
  end.

busy(Pid) ->
  receive
    show -> io:format("mutex belongs to ~w", [Pid]), busy(Pid);
    {signal, Pid} -> free()
  end.

terminate() ->
  receive
    show -> io:format("mutex belongs to no one and now terminating", []), terminate();
    {wait, Pid} -> exit(Pid, kill), terminate()
    after 0 -> ok
  end.


