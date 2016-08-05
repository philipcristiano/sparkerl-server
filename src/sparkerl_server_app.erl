-module(sparkerl_server_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	sparkerl_server_sup:start_link().

stop(_State) ->
	ok.
