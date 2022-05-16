% ------ Part 1 ------
% 1.1
% dropAny(? Elem, ?List, ?OutList)
dropAny(X, [X|T], T).
dropAny(X, [H|Xs], [H|L]):- dropAny(X, Xs, L).
%dropAny(10, [10,20,10,30,10],L)

% dropFirst drops only the first occurrence 
dropFirst(X, L, R):- dropAny(X, L, R), !.

%dropLast: drops only the last occurence
%dropLast(X, L, Res):- reverse(L, R), dropFirst(X, R, L1), reverse(L1, Res).
dropLast(X, [H|Xs], [H|L]):- dropLast(X, Xs, L), !.
dropLast(X, [X|T], T).

%dropAll: drop all occurrences, returning a single list as result
dropAll(X, [], []).
dropAll(X, [X | T], R) :- dropAll(X, T, R), !.
dropAll(X, [H | Xs], [H | L]) :- dropAll(X, Xs, L), !.