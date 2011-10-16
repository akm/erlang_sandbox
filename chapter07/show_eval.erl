-module(show_eval).
-export([test/0]).
-include("show_eval.hrl").

test() ->
  ?SHOW_EVAL( length( [1,2,3] ) ).
