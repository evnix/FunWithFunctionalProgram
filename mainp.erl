
-module(mainp).

-export( [abc/0,loop/4,iloop/4] ).
-define(SIZE, 1000).

abc()->

 	{Size,NA}=fhandle:loadArray(<<"map1.txt">>),
 	consumer:start(),

 	loop(0,0,100,NA),
	{ML,MP}=gen_server:call(whereis(consumer),get),
	io:format("\n ML: ~p MP: ~p",[ML,MP]),

 	Size=Size.


loop(I,J,Size,Array)->


	case I < Size of
		true ->
			iloop(I,J,Size,Array),
			timer:sleep(10),

			io:format("\nI: ~p",[I]),

			loop(I+1,J,Size,Array);
		false -> ok
	end.

iloop(I,J,Size,Array)->

	case J < Size of
		true ->
			Pid = spawn(iterator, itr, [Array,Size]),
			Pid ! {I,J,1,[two_dim:get(I,J,Array)]},
			timer:sleep(10),
			iloop(I,J+1,Size,Array);
		false ->ok
	end.		



