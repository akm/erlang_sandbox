-module(btree).
-export([new/3]).
-export([sum/1, max/1]).
-include("btree.hrl").

new(Left, Data, Right) ->
  #btree{left=Left, data=Data, right=Right}.

sum(undefined) -> 0;
sum(#btree{left=Left, data=Data, right=Right}) -> sum(Left) + Data + sum(Right).

max(undefined) -> 0;
max(#btree{left=Left, data=Data, right=Right}) ->
  max_acc(max(Left), Data, max(Right)).
    
max_acc(A,B,C) when A >= B, A >= C -> A;
max_acc(A,B,C) when A >= B, B >= C -> A;
max_acc(A,B,C) when A >= C, C >= B -> A;
max_acc(A,B,C) when B >= C, B >= A -> B;
max_acc(A,B,C) when B >= C, C >= A -> B;
max_acc(A,B,C) when B >= A, A >= C -> B;
max_acc(A,B,C) when C >= A, C >= B -> C;
max_acc(A,B,C) when C >= A, A >= B -> C;
max_acc(A,B,C) when C >= B, B >= A -> C.


% T1 = btree:new(undefined, 5, undefined).
% T2 = btree:new(undefined, 15, undefined).
% T3 = btree:new(T1, 10, T2).
% btree:sum(T3).
% btree:max(T3).
