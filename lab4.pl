% 1.intersect
member(H, [H|_]) :- !.
member(X, [_|T]) :- member(X, T).

intersect([], _, []).

intersect([H|T], L, [H|R1]) :-
    member(H, L), !,
    intersect(T, L, R1).

intersect([_|T], L, R) :-
    intersect(T, L, R).

% 2.diff
diff([], _, []).

diff([H|T], L, [H|R1]) :-
    \+ member(H, L), !,
    diff(T, L, R1).

diff([_|T], L, R) :-
    diff(T, L, R).


% 3.del_min, del_max
min([X], X).

min([H|T], H) :-
    min(T, M),
    H < M, !.

min([_|T], R) :-
    min(T, R).

del_min(L, R) :-
    min(L, M),
    del_all(M, L, R).
    
del_all(_, [], []).

del_all(X, [X|T], R) :- 
    del_all(X, T, R). 
    
del_all(X, [H|T], [H|R]) :-
    X \= H,
    del_all(X, T, R).

% 4.
    
