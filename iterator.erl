-module(iterator).
-compile(export_all).


 itr(Array,Size) ->

	receive

		{X,Y,Max,List} ->

			CurrItem = two_dim:get(X,Y,Array),



			case (X-1 == Size) and (Y-1 == Size) of

				true -> ok;

				false -> ok %io:format(" X: ~p Y: ~p Val: ~p \n",[X,Y,CurrItem])

			end,

			%check left


			case X-1 >=0 of
			true->

				LeftItem = two_dim:get(X-1,Y,Array),
				case CurrItem > LeftItem of

					true -> 
					Pid = spawn(iterator, itr, [Array,Size]),
					Pid ! {X-1,Y,Max+1,List++[LeftItem]};

					false -> 

						gen_server:call(whereis(consumer),{push,Max,List})

				end;		

			false-> gen_server:call(whereis(consumer),{push,Max,List})
			end,



			%check right
			
			case X+1 <Size of
			true->

				RightItem = two_dim:get(X+1,Y,Array),
				case CurrItem > RightItem of

					true -> 
					Pid2 = spawn(iterator, itr, [Array,Size]),
					Pid2 ! {X+1,Y,Max+1,List++[RightItem]};

					false -> 

						gen_server:call(whereis(consumer),{push,Max,List})

				end;		

			false-> gen_server:call(whereis(consumer),{push,Max,List})
			end,

			%check above

			case Y-1 >=0 of
			true->

				AboveItem = two_dim:get(X,Y-1,Array),
				case CurrItem > AboveItem of

					true -> 
					Pid3 = spawn(iterator, itr, [Array,Size]),
					Pid3 ! {X,Y-1,Max+1,List++[AboveItem]};

					false -> 

						gen_server:call(whereis(consumer),{push,Max,List})

				end;		

			false-> gen_server:call(whereis(consumer),{push,Max,List})
			end,

			%check below

			case Y+1 <Size of
			true->

				BelowItem = two_dim:get(X,Y+1,Array),
				case CurrItem > BelowItem of

					true -> 
					Pid4 = spawn(iterator, itr, [Array,Size]),
					Pid4 ! {X,Y+1,Max+1,List++[BelowItem]};

					false -> 

						gen_server:call(whereis(consumer),{push,Max,List})

				end;		

			false-> gen_server:call(whereis(consumer),{push,Max,List})
			end;




		_ -> ok

	end.

