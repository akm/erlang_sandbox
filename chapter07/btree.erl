-module(btree).
-export([new/3]).
-export([sum/1, max/1]).
-include("btree.hrl").

new(Left, Data, Right) ->
  #btree{left=Left, data=Data, right=Right}.

sum(undefined) -> 0;
sum(#btree{left=Left, data=Data, right=Right}) -> sum(Left) + Data + sum(Right).

max(undefined) -> undefined;
max(#btree{left=Left, data=Data, right=Right}) ->
  max_acc(max(Left), Data, max(Right)).

max_acc(undefined,B,undefined) -> B;
max_acc(undefined,B,C) when B >= C -> B;
max_acc(undefined,B,C) when B =< C -> C;
max_acc(A,B,undefined) when A >= B -> A;
max_acc(A,B,undefined) when A =< B -> B;
max_acc(A,B,C) when A >= B, A >= C -> A;
max_acc(A,B,C) when A >= B, B >= C -> A;
max_acc(A,B,C) when A >= C, C >= B -> A;
max_acc(A,B,C) when B >= C, B >= A -> B;
max_acc(A,B,C) when B >= C, C >= A -> B;
max_acc(A,B,C) when B >= A, A >= C -> B;
max_acc(A,B,C) when C >= A, C >= B -> C;
max_acc(A,B,C) when C >= A, A >= B -> C;
max_acc(A,B,C) when C >= B, B >= A -> C.

% NODE1 = btree:new(undefined, 1, undefined).
% NODE2 = btree:new(undefined, 2, undefined).
% NODE3 = btree:new(NODE1, 4, NODE2).
% NODE4 = btree:new(undefined, 3, undefined).
% NODE5 = btree:new(NODE3, 3, NODE4).
% btree:sum(NODE5).
% btree:max(NODE5).

% ORDERED_NODE1 = btree:new(undefined, 3, undefined).
% ORDERED_NODE2 = btree:new(undefined, 5, undefined).
% ORDERED_NODE3 = btree:new(ORDERED_NODE1, 4, ORDERED_NODE2).
% ORDERED_NODE4 = btree:new(undefined, 2, undefined).
% ORDERED_NODE5 = btree:new(ORDERED_NODE4, 3, ORDERED_NODE3).
% btree:sum(ORDERED_NODE5).
% btree:max(ORDERED_NODE5).
