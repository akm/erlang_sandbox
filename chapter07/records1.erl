%% Code from 
%%   Erlang Programming
%%   Francecso Cesarini and Simon Thompson
%%   O'Reilly, 2008
%%   http://oreilly.com/catalog/9780596518189/
%%   http://www.erlangprogramming.org/
%%   (c) Francesco Cesarini and Simon Thompson

-module(records1).
-export([birthday/1, joe/0, showPerson/1]).
-export([foobar/1]).

-record(person, {name,age=0,phone,address}).

birthday(#person{age=Age} = P) ->
  P#person{age=Age+1}.

joe() ->
  #person{name="Joe",
          age=21,
          phone="999-999"}.

showPerson(#person{age=Age,phone=Phone,name=Name}) ->
  io:format("name: ~p  age: ~p  phone: ~p~n", [Name,Age,Phone]).


foobar(P) when is_record(P, person) and (P#person.name == "Joe") -> ok;
foobar(_) -> ng.
