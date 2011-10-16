-module(btree).
-export([new/3]).
-export([flatten/1]).
-export([sum/1, max/1]).
-include("btree.hrl").

new(Left, Data, Right) ->
  #btree{left=Left, data=Data, right=Right}.

flatten(Node) -> flatten_acc(Node, []).

flatten_acc(#btree{left=undefined, data=Data, right=undefined}, Acc) -> [Data|Acc];
flatten_acc(#btree{left=Left     , data=Data, right=undefined}, Acc) -> flatten_acc(Left, [Data|Acc]);
flatten_acc(#btree{left=undefined, data=Data, right=Right    }, Acc) -> [Data| flatten_acc(Right, Acc)];
flatten_acc(#btree{left=Left     , data=Data, right=Right    }, Acc) -> flatten_acc(Left, [Data| flatten_acc(Right, Acc)]).

sum(Node) -> lists:sum(flatten(Node)).
max(Node) -> lists:max(flatten(Node)).

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
