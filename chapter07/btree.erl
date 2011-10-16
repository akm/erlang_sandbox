-module(btree).
-export([new/3]).
-export([flatten/1]).
-export([sum/1, max/1, min/1]).
-export([is_ordered/1]).
-export([add/2]).
-include("btree.hrl").

new(Left, Data, Right) ->
  #btree{left=Left, data=Data, right=Right}.

flatten(Node) -> flatten_acc(Node, []).

flatten_acc(#btree{left=nil , data=Data, right=nil  }, Acc) -> [Data|Acc];
flatten_acc(#btree{left=Left, data=Data, right=nil  }, Acc) -> flatten_acc(Left, [Data|Acc]);
flatten_acc(#btree{left=nil , data=Data, right=Right}, Acc) -> [Data| flatten_acc(Right, Acc)];
flatten_acc(#btree{left=Left, data=Data, right=Right}, Acc) -> flatten_acc(Left, [Data| flatten_acc(Right, Acc)]).

sum(Node) -> lists:sum(flatten(Node)).
max(Node) -> lists:max(flatten(Node)).
min(Node) -> lists:min(flatten(Node)).

is_ordered(#btree{left=Left, data=Data, right=Right}) -> 
  is_ordered_left(Left, Data) and is_ordered_right(Right, Data).

is_ordered_left(nil, _Data) -> true;
is_ordered_left(Node, Data) ->
  is_ordered(Node) and (max(Node) =< Data).

is_ordered_right(nil, _Data) -> true;
is_ordered_right(Node, Data) ->
  is_ordered(Node) and (min(Node) >= Data).

% http://ja.wikipedia.org/wiki/2分探索木
add(#btree{left=nil , data=Data, right=Right}, D) when D =< Data -> #btree{left=#btree{data=D}, data=Data, right=Right};
add(#btree{left=Left, data=Data, right=Right}, D) when D =< Data -> #btree{left=add(Left, D)  , data=Data, right=Right};

add(#btree{left=Left, data=Data, right=nil  }, D) when D >  Data -> #btree{left=Left, data=Data, right=#btree{data=D}}; 
add(#btree{left=Left, data=Data, right=Right}, D) when D >  Data -> #btree{left=Left, data=Data, right=add(Right, D) }.

% NODE1 = btree:new(nil, 1, nil).
% NODE2 = btree:new(nil, 2, nil).
% NODE3 = btree:new(NODE1, 4, NODE2).
% NODE4 = btree:new(nil, 3, nil).
% NODE5 = btree:new(NODE3, 3, NODE4).
% btree:sum(NODE5).
% btree:max(NODE5).

% ORDERED_NODE1 = btree:new(nil, 3, nil).
% ORDERED_NODE2 = btree:new(nil, 5, nil).
% ORDERED_NODE3 = btree:new(ORDERED_NODE1, 4, ORDERED_NODE2).
% ORDERED_NODE4 = btree:new(nil, 2, nil).
% ORDERED_NODE5 = btree:new(ORDERED_NODE4, 3, ORDERED_NODE3).
% btree:sum(ORDERED_NODE5).
% btree:max(ORDERED_NODE5).

% R1 = btree:add(ORDERED_NODE5, 10).
% R2 = btree:add(R1, 20).
% R3 = btree:add(R2, 15).
% R4 = btree:add(R3, 12).
% R5 = btree:add(R4, 14).
% R6 = btree:add(R5, 18).
