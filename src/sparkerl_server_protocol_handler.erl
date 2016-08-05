%%%-------------------------------------------------------------------
%%% @author $AUTHOR
%%% @copyright 2016 $OWNER
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------

-module(sparkerl_server_protocol_handler).

-compile([{parse_transform, lager_transform}]).


-export([init/0,
         handle_msg/1,
         handle_public_event/4]).

-record(state, {topics}).

init() ->
    ebus:sub(self(),  {internal, registration}),
    {ok, #state{topics=sets:new()}}.

handle_public_event(Core, Name, Data, State=#state{topics=Topics}) ->
    lager:debug("Recieved handler public event! ~p", [{Core, Name, Data}]),
    Topic = {public, Core, Name},
    NewTopics = sets:add_element(Topic, Topics),
    lager:debug("Publishing message to topic: ~p", [Topic]),
    ebus:pub(Topic, Data),

    {ok, State#state{topics=NewTopics}}.

handle_msg(Msg) ->
    lager:info("Unhandled message: ~p", [Msg]).
