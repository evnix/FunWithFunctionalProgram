
-module(mainp).

-export( [abc/0] ).
-define(SIZE, 4).

abc()->
	 A= two_dim:create( ?SIZE, ?SIZE),
 	NA=fhandle:loadArray(A,<<"map1.txt">>,?SIZE),
 	consumer:start(),
 	Pid = spawn(iterator, itr, [NA,?SIZE]),
	Pid ! {0,1,0,[]},
	{ML,MP}=gen_server:call(whereis(consumer),get),
	io:format("\n ML: ~p MP: ~p",[ML,MP]),

 	NA=NA.

