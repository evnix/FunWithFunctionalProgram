
-module(fhandle).

loadfile(FileName)->
	{ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).

getNumbers(Line)->
	binary:split(Line, [<<" ">>], [global]).


loadArray(Array,FileName)->
	TLines = fhanlde:loadfile(FileName),
	[_|Lines] = TLines,
	