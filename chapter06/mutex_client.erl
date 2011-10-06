-module(mutex_client).
-export([all/0]).
-export([loop/1]).

start(Name) ->
  register(Name, spawn(?MODULE, loop, [Name])).

send(Name, Msg) -> Name ! Msg.

loop(Name) ->
  io:format("~w ~w loop~n", [Name, self()]),
  receive
    work  -> mutex:wait(), loop(Name);
    break -> mutex:signal();
    stop  -> ok;
    error -> add_one(one)
  end.

add_one(Int) -> Int + 1.


all() ->
  mutex:start(),
  start(user1),
  start(user2),
  mutex:show(),
  send(user1, work),
  io:format("1 ~p~n", [mutex:show()]),
  send(user2, work),
  io:format("2 ~p~n", [mutex:show()]),
  send(user1, error),
  io:format("3 ~p~n", [mutex:show()]),
  send(user2, stop),
  io:format("4 ~p~n", [mutex:show()]).
