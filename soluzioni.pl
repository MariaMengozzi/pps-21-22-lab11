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
dropAll(_, [], []).
dropAll(X, [ X | T ], L) :- dropAll(X, T, L), !.
dropAll(X, [ H | T ], [H | L]) :- dropAll(X, T, L).

% ------ Part 2 ------
% 2.1 - fromList(+List, -Graph)
fromList([_], []).
fromList([H1, H2 | T], [e(H1, H2) | L]) :- fromList([H2 | T], L).
%fromList([1,2,3], [e(1,2), e(2,3)]).
%fromList([1,2], [e(1,2)]).
%fromList([1], []).

%fromCircList(+List, -Graph)
last([H], H).
last([H|T], L):- last(T, L).

fromCircList2([E], [e(E,E)]).
fromCircList2([H|T], R):- fromList([H|T], G),
				last(T, L), !,
	`			append(G, [e(L, H)], R).

fromCircList([E], [e(E,E)]).
fromCircList([H|T], G):- withFirst(H, [H| T], G).
withFirst(H, [L], [e(L,H)]).
withFirst(H, [H1, H2|T], [e(H1, H2)|L]):- withFirst(H, [H2|T], L).

%fromCircList([1,2,3,4], [e(1,2), e(2,3), e(3,4), e(4,1)]).
%fromCircList([1,2,3], [e(1,2), e(2,3), e(3,1)]).
%fromCircList([1,2], [e(1,2), e(2,1)]).
%fromCircList([1], [e(1,1)]).

%2.3
%in_degree(+Graph, +Node, -Deg) - deg is the number of edges leadin into Node
in_degree([], _, 0).
in_degree([e(_, N)|T], N, D):- in_degree(T, N, D1), D is D1+1, !.
in_degree([e(_, H2)|T], N, D):- in_degree(T, N, D).

%in_degree([e(1,2), e(1,3), e(3,2)], 2, 2).
%in_degree([e(1,2), e(1,3), e(3,2)], 3, 1).
%in_degree([e(1,2), e(1,3), e(3,2)], 1, 0).

%2.4
%dropNode(+Graph, +Node, -OutGraph)
%drop all edges starting and leaving from a Node
% use dropAll defined in 1.1?? No, we cannot because in 1.1 we have used cut,
%so only one branch generated by the _ operator is explored. 
%so we have to change it adding a copy because it unify too soon

dropAll2(_, [], []).
dropAll2(X, [ Y | T ], L) :- copy_term(X, Y), dropAll2(X, T, L), !.
dropAll2(X, [ H | T ], [H | L]) :- dropAll2(X, T, L).

dropNode(G, N, OG):- dropAll2(e(N,_), G, G2), dropAll2(e(_,N), G2, OG).
%dropNode([e(1,2), e(1,3), e(2,3)], 1, [e(2,3)]).

%2.5
% reaching (+ Graph , + Node , - List ) 
% all the nodes that can be reached in 1 step from Node
% possibly use findall , looking for e ( Node , _ ) combined
% with member (? Elem ,? List )
%findall(Obj, Goal, L) - "Give me a list containing all the instantiations of Object which satisfy Goal." 
reaching(G, N, L):- findall(X, member(e(N,X), G), L).
%reaching([e(1,2),e(1,3),e(2,3)],1,[2,3]).
%reaching([e(1,2),e(1,2),e(2,3)],1,[2,2]).

%2.6
% anypath (+ Graph , + Node1 , + Node2 , - ListPath )
% a path from Node1 to Node2
% if there are many path , they are showed 1 - by -1
anypath([e(N1,N2)|T], N1, N2, [e(N1, N2)]).
anypath([e(N1, H2)|T], N1, N2, [e(N1, H2)|L]):- anypath(T, H2, N2, L).
anypath([e(H1, H2)|T], N1, N2, L):- anypath(T, N1, N2, L).
%anypath([e(1,2),e(1,3),e(2,3)],1,3,L).
%anypath([e(1,2),e(1,3),e(2,3)],1,2,L).
%anypath([e(1,2),e(1,3),e(2,3),e(1,4), e(2,4), e(3,4)],1,4,L).
%anypath([e(1,1), e(1,2), e(2,1)], 1, 1, L) -- with cut in line 86 doesn't find all paths

%2.7 
% allreaching(+Graph, +Node, -List)
% all the nodes that can be reached from Node
% suppose the graph is NOT circular
% Use findall and anyPath !
allreaching(G, N, L) :- findall(X, anypath(G, N, X, L2), L).
% allreaching([e(1,2),e(2,3),e(3,5)],1,[2,3,5]).

%2.8
%During last lesson we see how to generate a grid-like network. Adapt
%that code to create a graph for the predicates implemented so far.
%Try to generate all paths from a node to another, limiting the
%maximum number of hops

%generate a complete graph  with N nodes
graphlink(N, N, _, []).
graphlink(N, X, X, L):- X2 is X+1,
			graphlink(N, X2, 0, L), !.
graphlink(N, X, Y, [e(X,Y)| L]):-  
				Y < X, 
				Y2 is Y+1, 
				graphlink(N, X, Y2, L), !.


 
	




