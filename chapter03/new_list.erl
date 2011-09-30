-module(new_list).
-export([create/1, reverse_create/1]).

create(N) -> create_acc(N, []).
create_acc(0, Acc) -> Acc;
create_acc(N, Acc) -> create_acc(N -1, [N | Acc]).

reverse_create(N) -> reverse_create_acc(N, []).
reverse_create_acc(0, Acc) -> lists:reverse(Acc);
reverse_create_acc(N, Acc) -> reverse_create_acc(N -1, [N | Acc]).
