-module(mutex).
-export([start/0, stop/0, show/0]).
-export([wait/0, signal/0]).
-export([init/0]).
-export([user_start/1, user_send/2]).
-export([user_loop/1]).

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


user_start(Name) ->
  register(Name, spawn(?MODULE, user_loop, [Name])).

user_send(Name, Msg) -> Name ! Msg.

user_loop(Name) ->
  receive
    work -> 
      mutex:wait(),
      user_loop(Name);
    stop -> 
      ok;
    error ->
      add_one(one)
  end.

add_one(Int) -> Int + 1.


% mutex:start()..
% mutex:user_start(user1).
% mutex:user_start(user2).
% mutex:show().
% mutex:user_send(user1, work).
% mutex:show().
% mutex:user_send(user2, work).
% mutex:show().
% mutex:user_send(user1, error).
% mutex:show().
% mutex:user_send(user2, stop).
% mutex:show().
