
-module(mainp).

-export( [abc/0,abc2/1,loop/6,iloop/5] ).
-define(SIZE, 1000).

abc()->

 	{Size,NA}=fhandle:loadArray(<<"map1.txt">>),
 	consumer:start(),

 	loop(0,0,500,500,Size,NA),
	{ML,MP}=gen_server:call(whereis(consumer),get),
	io:format("\n ML: ~p MP: ~p",[ML,MP]),

 	Size=Size.


abc2(List)->

 	{Size,NA}=fhandle:loadArray(<<"map1.txt">>),
 	consumer:start(),

 	[H|T]=List,
 	I=list_to_integer(H),



 	[H1|T1]=T,
 	J=list_to_integer(H1),



 	[H2|T2]=T1,
 	ISize=list_to_integer(H2),


 	[H3|_]=T2,
 	JSize=list_to_integer(H3),


 	loop(I,J,ISize,JSize,Size,NA),
	{ML,MP}=gen_server:call(whereis(consumer),get),
	io:format("\n ML: ~p MP: ~p",[ML,MP]),

 	Size=Size.

loop(I,J,ISize,JSize,Size,Array)->


	case I < ISize of
		true ->
			iloop(I,J,JSize,Size,Array),
			io:format("\nI: ~p",[I]),

			loop(I+1,J,ISize,JSize,Size,Array);
		false -> ok
	end.

iloop(I,J,JSize,Size,Array)->

	case J < JSize of
		true ->

			Pid = spawn(iterator, itr, [I,J,1,[two_dim:get(I,J,Array)],Array,Size]),
			%Pid ! {I,J,1,[two_dim:get(I,J,Array)]},
			Pid=Pid,
			iloop(I,J+1,JSize,Size,Array);
		false ->ok
	end.		



