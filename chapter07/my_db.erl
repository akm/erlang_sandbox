-module(my_db).
-export([start/0, stop/0, write/2, delete/1, read/1, match/1, loop/1]).

% my_db:start() => ok.
% my_db:stop() => ok.
% my_db:write(Key, Element) => ok.
% my_db:delete(Key, Element) => ok.
% my_db:read(Key) => {ok, Elemrnt} | {error, instance}.
% my_db:match(Element) => [Key1, ...., KeyN].

start() ->
  register(my_db, spawn(my_db, loop, [db:new()])), ok.

stop() ->
  my_db ! stop, ok.

write(Key, Element) -> my_db ! {write , self(), [Key, Element]}, ok.
delete(Key)         -> my_db ! {delete, self(), [Key]}, ok.
read(Key)           -> my_db ! {read  , self(), [Key]}    , return_response().
match(Element)      -> my_db ! {match , self(), [Element]}, return_response().

return_response() ->
  receive
    Msg -> Msg
  end.

loop(Db) ->
  receive
    stop -> ok;
    {write , _Sender, [Key, Element]} -> loop( db:write(Key, Element, Db) );
    {delete, _Sender, [Key         ]} -> loop( db:delete(Key, Db) );
    {read  , Sender , [Key         ]} -> Sender ! db:read(Key, Db)     , loop(Db);
    {match , Sender , [Element     ]} -> Sender ! db:match(Element, Db), loop(Db)
  end.
