-module(consumer).
-compile(export_all).

-behaviour(gen_server).
%% Public API

start_link() ->
 gen_server:start_link(?MODULE, [], []).

stop(Module) ->
  gen_server:call(Module, stop).

stop() ->
  stop(?MODULE).

state(Module) ->
  gen_server:call(Module, state).

state() ->
  state(?MODULE).

%% Server implementation, a.k.a.: callbacks

init([]) ->

	MaxLen = 0,
	MaxPath = [],
  {ok, {MaxLen,MaxPath}}.

  handle_call({push,Len,Path}, _From, {MaxLen,MaxPath}) ->

  		{NewMaxLen,NewMaxPath} = case Len > MaxLen of
  			true->
  				{Len,Path};
  			false->	

  				case Len == MaxLen of 

  					true->
	  					[OPH|_]=MaxPath,
	  					OPT=lists:last(MaxPath),
	  					ODepth = OPH - OPT,

	  					[NPH|_]=Path,
	  					NPT=lists:last(Path),
	  					NDepth = NPH - NPT,

	  					case NDepth > ODepth of

	  						true-> {Len,Path};
	  						false-> {MaxLen,MaxPath}
	  					end;	

	  				false->

  					{Len,Path}
  				end



  				
  		end,		

    {reply, ok,  {NewMaxLen,NewMaxPath}};


handle_call(stop, _From, State) ->
  say("stopping by ~p, state was ~p.", [_From, State]),
  {stop, normal, stopped, State};

handle_call(state, _From, State) ->
  say("~p is asking for the state.", [_From]),
  {reply, State, State};

handle_call(_Request, _From, State) ->
  say("call ~p, ~p, ~p.", [_Request, _From, State]),
  {reply, ok, State}.


handle_cast(_Msg, State) ->
  say("cast ~p, ~p.", [_Msg, State]),
  {noreply, State}.


handle_info(_Info, State) ->
  say("info ~p, ~p.", [_Info, State]),
  {noreply, State}.


terminate(_Reason, _State) ->
  say("terminate ~p, ~p", [_Reason, _State]),
  ok.


code_change(_OldVsn, State, _Extra) ->
  say("code_change ~p, ~p, ~p", [_OldVsn, State, _Extra]),
  {ok, State}.

%% Some helper methods.

say(Format) ->
  say(Format, []).
say(Format, Data) ->
  io:format("~p:~p: ~s~n", [?MODULE, self(), io_lib:format(Format, Data)]).

