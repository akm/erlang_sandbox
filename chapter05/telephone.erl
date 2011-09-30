-module(telephone).
-export([start/0, stop/0]).
-export([idle/0, off_hook/0, on_hook/0, incoming/1, push/1, other_on_hook/0, other_off_hook/0]).

start() ->
  event_manager:start(telephone_log, [{log_handler, "telephone.log"}]),
  register(telephone, spawn(telephone, idle, [])).

stop()  -> call(stop).

off_hook()       -> call(off_hook).
 on_hook()       -> call( on_hook).
incoming(Number) -> call({Number, incoming}).
push(Number)     -> call({Number, push}).

other_on_hook()  -> call(other_on_hook).
other_off_hook() -> call(other_off_hook).


call(Message) ->
  telephone ! Message.


%  receive
%    {reply, Reply} -> Reply
%  end.


idle() ->
  event_manager:send_event(telephone_log, {connection, [], idle}),
  receive
    {Number, incomming} ->
      start_ringing(),
      ringing(Number);
    off_hook ->
      start_tone(),
      dial()
  end.

ringing(Number) ->
  event_manager:send_event(telephone_log, {connection, Number, ringing}),
  receive
    {Number, other_on_hook} ->
      stop_ringing(),
      idle();
    {Number, off_hook} ->
      stop_ringing(),
      connected(Number)
  end.

start_ringing() -> start_ringing.
stop_ringing() -> stop_ringing.
    
start_tone() -> 
  nnnnnn.

connected(Number) ->
  event_manager:send_event(telephone_log, {connection, Number, connected}),
  receive
    on_hook ->
      event_manager:send_event(telephone_log, {connection, Number, disconnected}),
      idle();
    other_on_hook ->
      event_manager:send_event(telephone_log, {connection, Number, disconnected}),
      idle()
  end.

dial() ->
  event_manager:send_event(telephone_log, {connection, [], dial}),
  receive
    {Number, push} -> calling(Number);
    on_hook -> idle()
  end.

calling(Number) ->
  event_manager:send_event(telephone_log, {connection, Number, calling}),
  receive
    other_off_hook -> connected(Number);
    on_hook -> idle()
  end.


% reply(To, Msg) ->
%   To ! {reply, Msg}.
