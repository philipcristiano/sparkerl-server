-module(sparkerl_server_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	Procs = [{sparkerl_server_client_registrar,
              {sparkerl_server_client_registrar, start_link, []},
              permanent,
              5000,
              worker,
              [sparkerl_server_client_registrar]}],
	{ok, {{one_for_one, 1, 5}, Procs}}.
