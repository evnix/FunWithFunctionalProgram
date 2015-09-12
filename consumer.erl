-module(consumer).
-compile(export_all).

-behaviour(gen_server).
%% Public API

start() ->
  gen_server:start({local, ?MODULE}, ?MODULE, [], []).

stop(Module) ->
  gen_server:call(Module, stop).

stop() ->
  stop(?MODULE).

state(Module) ->
  gen_server:call(Module, state).

state() ->
  state(?MODULE).

%% Server implementation, a.k.a.: callbacks

getHead(List)->
	
	case length(List)>0 of

		true -> [R|_]=List,
				R=R;
		false -> 0
	end.			

getTail(List)->
	
	case length(List)>0 of

		true -> lists:last(List);
				
		false -> 0
	end.	


init([]) ->

	MaxLen = 0,
	MaxPath = [],
  {ok, {MaxLen,MaxPath}}.


  handle_call(get, _From, {MaxLen,MaxPath}) ->

    {reply, {MaxLen,MaxPath},  {MaxLen,MaxPath}};


  handle_call({push,Len,Path}, _From, {MaxLen,MaxPath}) ->


  		{NewMaxLen,NewMaxPath} = case Len > MaxLen of
  			true->
  				{Len,Path};
  			false->	

  				case Len == MaxLen of 

  					true->
	  					OPH=getHead(MaxPath),
	  					OPT=getTail(MaxPath),
	  					ODepth = OPH - OPT,

	  					NPH=getHead(Path),
	  					NPT=getTail(Path),
	  					NDepth = NPH - NPT,

	  					case NDepth > ODepth of

	  						true-> {Len,Path};
	  						false-> {MaxLen,MaxPath}
	  					end;	

	  				false->

  					{MaxLen,MaxPath}
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


handle_cast({push,Len,Path}, {MaxLen,MaxPath}) ->

 
      {NewMaxLen,NewMaxPath} = case Len > MaxLen of
        true->
          {Len,Path};
        false-> 

          case Len == MaxLen of 

            true->
              OPH=getHead(MaxPath),
              OPT=getTail(MaxPath),
              ODepth = OPH - OPT,

              NPH=getHead(Path),
              NPT=getTail(Path),
              NDepth = NPH - NPT,

              case NDepth > ODepth of

                true-> {Len,Path};
                false-> {MaxLen,MaxPath}
              end;  

            false->

            {MaxLen,MaxPath}
          end



          
      end,  
  {noreply,  {NewMaxLen,NewMaxPath}};

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

