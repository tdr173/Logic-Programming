% Lab 5
% 0.0 depth
max(A, B, A) :- A >= B, !.
max(_, B, B).

depth([], 1).

depth([H|T], R) :- atomic(H), !, depth(T, R).
depth([H|T], R) :- depth(H, R1), depth(T, R2), R3 is R1+1, max(R3, R2, R).


% 0.1 flatten
flatten([], []).
flatten([H|T], [H|R]) :- atomic(H), !, flatten(T, R).
flatten([H|T], R) :- flatten(H, R1), flatten(T, R2), append(R1, R2, R).


% 0.2 heads
skip([], []).
skip([H|T], R) :- atomic(H), !, skip(T, R).
skip([H|T], [H|R]) :- skip(T,R).

heads([],[]).
heads([H|T], [H|R]) :- atomic(H), !, skip(T, T1), heads(T1, R).
heads([H|T], R) :- heads(H, R1), heads(T, R2), append(R1, R2, R).


% 0.3 member
% flatten([], []).
% flatten([H|T], [H|R]) :- atmomic(H), !, flatten(T, R).
% flatten([H|T], R) :- flatten(H, R1), flatten(T, R2), append(R1, R2, R).

member1(X, L) :- flatten(L, Flat), member(X, Flat).

member2(H, [H|_]).
member2(X, [H|_]) :- member2(X, H). % H is a list
member2(X, [_|T]) :- member2(X, T).


% 1. count_atomic
count_atomic([], 0).

count_atomic([H|T], R) :- 
    atomic(H), !,  
    count_atomic(T, R1),
    R is R1 + 1.

count_atomic([H|T], R) :-
    count_atomic(H, R1),
    count_atomic(T, R2),
    R is R1+R2.


% 2. sum_atomic -> same but R is R1 + H.


% 3. replace
replace(_, _, [], []).

replace(From, To, [H|T], [To|R]) :- 
    atomic(H),
    H == From, !,
    replace(From, To, T, R).

replace(From, To, [H|T], [H|R]) :- 
    atomic(H), !,
    replace(From, To, T, R).  

replace(From, To, [H|T], [H1|R]) :- 
    replace(From, To, H, H1),
    replace(From, To, T, R).


% 4. lasts ??
last_atomic(X, X) :- atomic(X), !.
last_atomic([_|T], R) :- last_atomic(T, R).

lasts([], []).
lasts([H|T], R) :- 
    atomic(H), !,
    lasts(T, R).
lasts([H|T], [Last|R]) :-
    last_atomic(H, Last),
    lasts(T, R).
    
% 5. replace with length
len_con_depth([], []).
