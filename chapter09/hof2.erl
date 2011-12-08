-module(hof2).
-export([seq/1, filter_lte/1, pickup_even/1, sum/1, concat/1]).
-export([zip/2, zipWith/3]).

seq(N) ->
  fun() -> lists:seq(1,N) end.

filter_lte(N) ->
  Predicate = fun(X) -> X =< N end,
  fun(List) -> lists:filter(Predicate, List) end.

pickup_even(N) ->
  Predicate = fun(X) -> X rem 2 == 0 end,
  List = (seq(N))(),
  fun() -> lists:filter(Predicate, List) end.

sum(Numbers) ->
  lists:foldl(fun(H, Acc) -> H + Acc end,0, Numbers).

concat(Lists) ->
  lists:foldl(fun(H, Acc) -> Acc ++ H end,[], Lists).


% [X || X <- lists:seq(1,10), X rem 3 == 0].
% [X * X || X <- [1, hello, 100, boo,"boo", 9], is_integer(X)].

% [X || X <- [1,2,3,4,5], Y <- [4,5,6,7,8], X == Y].


zip_acc(_ , [], Acc, _) -> Acc;
zip_acc([], _ , Acc, _) -> Acc;
zip_acc([XH|XT], [YH|YT], Acc, F) -> 
  zip_acc(XT, YT, [F(XH,YH)| Acc], F).

zipWith(Xs, Ys, F) -> lists:reverse(zip_acc(Xs, Ys, [], F)).
zip(Xs, Ys) -> zipWith(Xs, Ys, fun(X,Y) -> {X,Y} end).
