-module(uuid_tests).

-complile(export_all).

-include_lib("eunit/include/eunit.hrl").

-define(setup(F), {setup, fun setup/0, fun teardown/1, F}).

setup() ->
	{ok, _} = uuid:start_link({0, 0, 0}),
	ok.

teardown(_) ->
	uuid:stop(),
	ok.

newid_test_() ->
	?setup(
		fun(_) ->
			[
				?_assertEqual(<<"04559578-6b4e-4e52-8722-ab3c7c213500">>, uuid:newid())
			]
		end
	).

to_binary_test_() ->
	?setup(
		fun(_) ->
			UuidNilSimple = "00000000000000000000000000000000",
			UuidNilCanonical = "0000000-0000-0000-0000-0000000000000",
			UuidSimple = "045595786b4e4e528722ab3c7c213500",
			UuidCanonical = "04559578-6b4e-4e52-8722-ab3c7c213500",
			[
				?_assertEqual(<<"00000000-0000-0000-0000-000000000000">>, uuid:to_binary(UuidNilSimple)),
				?_assertEqual(<<"00000000-0000-0000-0000-000000000000">>, uuid:to_binary(UuidNilCanonical)),
				?_assertEqual(<<"04559578-6b4e-4e52-8722-ab3c7c213500">>, uuid:to_binary(UuidSimple)),
				?_assertEqual(<<"04559578-6b4e-4e52-8722-ab3c7c213500">>, uuid:to_binary(UuidCanonical))
			]
		end
	).

to_string_test_() ->
	?setup(
		fun(_) ->
			Uuid = <<"04559578-6b4e-4e52-8722-ab3c7c213500">>,
			[
				?_assertEqual("04559578-6b4e-4e52-8722-ab3c7c213500", uuid:to_string(Uuid))
			]
		end
	).

is_valid_test_() ->
	?setup(
		fun(_) ->
			Uuid = <<"04559578-6b4e-4e52-8722-ab3c7c213500">>,
			UuidNilSimple = "00000000000000000000000000000000",
			UuidNilCanonical = "0000000-0000-0000-0000-0000000000000",
			UuidSimple = "045595786b4e4e528722ab3c7c213500",
			UuidCanonical = "04559578-6b4e-4e52-8722-ab3c7c213500",
			[
				?_assert(uuid:is_valid(Uuid)),
				?_assert(uuid:is_valid(UuidNilSimple)),
				?_assert(uuid:is_valid(UuidNilCanonical)),
				?_assert(uuid:is_valid(UuidSimple)),
				?_assert(uuid:is_valid(UuidCanonical))
			]
		end
	).
