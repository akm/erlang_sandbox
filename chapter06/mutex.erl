-module(mutex).
-export([start/0, stop/0, show/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() -> register(mutex, spawn(?MODULE, init, [])).
stop()  -> mutex ! stop.
show()  -> 
  mutex ! {show, self()},
  receive Msg -> Msg end.

reply(Pid, Msg) -> Pid ! Msg.

wait() ->
  mutex ! {wait, self()},
  receive ok -> ok end.

signal() ->
  mutex ! {signal, self()}, ok.

init() -> 
  io:format("~w init~n", [self()]),
  process_flag(trap_exit, true),
  free().

free() ->
  receive
    {show, Sender} -> reply(Sender, "mutex belongs to no one"), free();
    {wait, Pid} -> Pid ! ok, busy(Pid);
    stop -> terminate()
  end.

busy(Pid) ->
  receive
    {show, Sender} ->
      reply(Sender, "mutex belongs to " ++ pid_to_list(Pid)),
      link(Pid),
      busy(Pid);
    {'EXIT', Pid, Reason} ->
      io:format("~p EXIT because ~p~n", [Pid, Reason]),
      unlink(Pid),
      free();
    {signal, Pid} ->
      unlink(Pid),
      free()
  end.

terminate() ->
  receive
    {show, Sender} ->
      reply(Sender, "mutex belongs to no one and now terminating"),
      terminate();
    {wait, Pid} -> exit(Pid, kill), terminate()
    after 0 -> ok
  end.
