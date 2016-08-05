PROJECT = sparkerl_server
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.0.1

SHELL_OPTS = -eval "application:ensure_all_started(sparkerl_server)" -config sparkerl_server

DEPS = lager ebus sparkerl

dep_lager = git https://github.com/basho/lager.git 3.0.2
dep_ebus = git https://github.com/cabol/erlbus.git 0.2.0
dep_sparkerl = git https://github.com/philipcristiano/sparkerl.git master

include erlang.mk
