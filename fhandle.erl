
-module(fhandle).

loadfile(FileName)->
	{ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).

getNumbers(Line)->
	binary:split(Line, [<<" ">>], [global]).



loadNumbers(Array,Numbers,Index,CurrSize,Size) ->
	
	case CurrSize < Size of

	true -> 
		[Num|RNumbers] = Numbers,
		two_dim:set(Index,CurrSize,Num,Array),


loadLines(Array,Lines,CurrSize,Size) ->
	
	case CurrSize < Size of

	true -> 
		[Line|RLines]=Lines,
		Numbers = getNumbers(Line),
		loadNumbers(Array,Numbers,CurrSize,0,Size),
		loadLines(Array,RLines,CurrSize+1,Size);

	false -> 1=1

	end. 


loadArray(Array,FileName,Size)->
	TLines = fhanlde:loadfile(FileName),
	[_|Lines] = TLines,
	loadLines(Array,Lines,0,Size),

