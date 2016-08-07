%%%-------------------------------------------------------------------
%%% @author $AUTHOR
%%% @copyright 2016 $OWNER
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------

-module(sparkerl_server_protocol_handler).

-compile([{parse_transform, lager_transform}]).


-export([init/1,
         handle_info/2,
         handle_msg/1,
         handle_public_event/4]).

-record(state, {id, topics}).

init(Id) ->
    % ebus:sub(self(),  {internal, registration}),
    lager:info("Try to register ~p", [{self(), Id}]),
    ok = ebus:sub(self(), "internal.clients"),
    State = #state{id=Id, topics=sets:new()},
    register(State),
    {ok, State}.

handle_public_event(Core, Name, Data, State=#state{topics=Topics}) ->
    lager:debug("Recieved handler public event! ~p", [{Core, Name, Data}]),
    Topic = {public, Core, Name},
    NewTopics = sets:add_element(Topic, Topics),
    lager:debug("Publishing message to topic: ~p", [Topic]),
    ebus:pub(Topic, Data),

    {ok, State#state{topics=NewTopics}}.

handle_msg(Msg) ->
    lager:info("Unhandled message: ~p", [Msg]).

handle_info({register}, State) ->
    register(State),
    {ok, State};
handle_info(Info, State) ->
    lager:info("Unknown handler info ~p", [Info]),
    {ok, State}.


% Reigster with the process registrar
register(_State=#state{id=Id}) ->
    ok = ebus:pub("internal.registration", {register, self(), Id}),
    ok.
