
-module(mainp).

-export( [abc/0] ).
-define(SIZE, 4).

abc()->
	 A= two_dim:create( ?SIZE, ?SIZE),
 	NA=fhandle:loadArray(A,<<"map1.txt">>,?SIZE),
 	X=two_dim:get(3,3,NA),
 	io:format(" ~p ",[X]),
 	NA=NA.

