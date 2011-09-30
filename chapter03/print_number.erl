-module(print_number).
-export([all/1, even/1]).

all(N) -> all_acc(1, N).
all_acc(N, N) ->
  io:format("Number:~p~n", [N]);
all_acc(Index, N) -> 
  io:format("Number:~p~n", [Index]),
  all_acc(Index + 1, N).

even(N) -> even_acc(1, N).
even_acc(N, N) when N rem 2 == 0 -> io:format("Number:~p~n", [N]);
even_acc(N, N) when N rem 2 == 1 -> true;
even_acc(Index, N) when Index rem 2 == 0 -> 
  io:format("Number:~p~n", [Index]),
  even_acc(Index + 1, N);
even_acc(Index, N) when Index rem 2 == 1 -> 
  even_acc(Index + 1, N).
