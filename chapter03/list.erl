-module(list).
-export([filter/2, reverse/1, concatenate/1, flatten/1]).

filter(List, N) -> filter_acc(List, N, []).
filter_acc([], _, Acc) -> Acc;
filter_acc([H|T], N, Acc) when H =< N -> filter_acc(T, N, [H|Acc]);
filter_acc([_|T], N, Acc) -> filter_acc(T, N, Acc).

reverse(List) -> lists:reverse(List).

concatenate(List) -> concatenate_acc(List, []).
concatenate_acc([], Acc) -> Acc;
concatenate_acc([H|T], Acc) when is_list(H) -> 
  concatenate_acc(H, concatenate_acc(T, Acc));
concatenate_acc([H|T], Acc) -> 
  [H | concatenate_acc(T, Acc)].

flatten(List) -> concatenate(List).
