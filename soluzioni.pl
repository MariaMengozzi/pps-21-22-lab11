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

% ------ Part 2 ------
% 2.1 - fromList(+List, -Graph)
fromList([_], []).
fromList([H1, H2|T], [e(H1, H2)|L]):- fromList([H2|T], L).
%fromList([1,2,3], [e(1,2), e(2,3)]).
%fromList([1,2], e(1,2)).
%fromList([1], []).

%fromCircList(+List, -Graph)
last([H], H).
last([H|T], L):- last(T, L).

fromCircList2([E], e(E,E)).
fromCircList2([H|T], R):- fromList([H|T], G),
				last(T, L), !,
	`			append(G, [e(L, H)], R).

fromCircList([E], e(E,E)).
fromCircList([H|T], G):- withFirst(H, [H| T], G).
withFirst(H, [L], [e(L,H)]).
withFirst(H, [H1, H2|T], [e(H1, H2)|L]):- withFirst(H, [H2|T], L).

%fromCircList([1,2,3,4], [e(1,2), e(2,3), e(3,4), e(4,1)]).
%fromCircList([1,2,3], [e(1,2), e(2,3), e(3,1)]).
%fromCircList([1,2], [e(1,2), e(2,1)]).
%fromCircList([1], e(1,1)).
