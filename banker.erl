-module(banker).
-export([start/1, status/0, loop/3]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Client Side
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start(Capital) ->
	Bank = spawn(banker, loop, [ Capital, Capital, [] ]),
	register(banker, Bank),
	whereis(banker).


status() ->
	banker ! { self(), status },
	receive
		Any -> Any
	end.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Server Side
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

loop(Capital,Cash,Clients) -> 
	receive
		{Pid, status} ->
			Pid ! {Capital,Cash,Clients}
	end.

