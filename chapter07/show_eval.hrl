
-ifdef(show).
  -define(SHOW_EVAL(Call), Ret=Call,io:format("~p = ~p~n", [??Call, Ret]),Ret).
-else.
  -define(SHOW_EVAL(Call), Call).
-endif.
