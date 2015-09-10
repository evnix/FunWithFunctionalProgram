
-module(fhandle).
-compile(export_all).
loadfile(FileName)->
	{ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).

getNumbers(Line)->
	binary:split(Line, [<<" ">>], [global]).



loadNumbers(Array,Numbers,Index,CurrSize,Size) ->
	
	case CurrSize < Size of

	true -> 
		[Num|RNumbers] = Numbers,
		NArray = two_dim:set(Index,CurrSize,list_to_integer(binary_to_list(Num)),Array),
		loadNumbers(NArray,RNumbers,Index,CurrSize+1,Size);

	false -> Array
	end.	 


loadLines(Array,Lines,CurrSize,Size) ->
	
	case CurrSize < Size of

	true -> 
		[Line|RLines]=Lines,
		Numbers = getNumbers(Line),
		NArray = loadNumbers(Array,Numbers,CurrSize,0,Size),
		loadLines(NArray,RLines,CurrSize+1,Size);

	false -> Array

	end. 


loadArray(FileName)->
	TLines = loadfile(FileName),
	[SizeLine|Lines] = TLines,
	[TSize|_]=getNumbers(SizeLine),
	NSize=list_to_integer(binary_to_list(TSize)),

	Array = two_dim:create(NSize,NSize),

	NArray = loadLines(Array,Lines,0,NSize),
	{NSize,NArray}.
