-module(sum).
-export([sum/1, sum2/1, sum/2]).


sum(0) -> 0;
sum(N) -> N + sum(N-1).


sum2(N) -> sum2_acc(0, N).
sum2_acc(D, 0) -> D;
sum2_acc(D, N) -> sum2_acc(D + N, N - 1).

sum(N,N) -> N;
sum(N,M) -> sum3_acc(0, N, M).
sum3_acc(D, N, N) -> D + N;
sum3_acc(D, N, M) -> sum3_acc(D + M, N, M - 1).

