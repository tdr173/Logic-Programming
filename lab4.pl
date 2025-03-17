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


% 3.del_min
min([H], H).

min([H|T], M) :-
    min(T, M), H >= M, !.

min([H|_], H).

del_min(L, R) :- min(L, Min), delete(L, Min, R).


% 4.reverse_k

reverse_k([], _, []).

reverse_k([H|T], K, [H|R]) :-
    K > 0,
    !,
    K1 is K - 1,
    reverse_k(T, K1, R).

reverse_k(L, _, R) :-
    reverse(L, R). 
   

% 5.rle_encode
rle_encode_aux([], Prev, Count, [[Prev, Count]]).

rle_encode_aux([H|T], Prev, Count, R) :-
    H = Prev, !,
    Count1 is Count + 1,
    rle_encode_aux(T, H, Count1, R).
    
rle_encode_aux([H|T], Prev, Count, R) :- 
    rle_encode_aux(T, H, 1, R1),
    R=[[Prev, Count]|R1].

rle_encode([H|T], R) :- rle_encode_aux(T, H, 1, R).

% 6.
split([H|T], K, [H|L1], L2) :-
    K > 0,
    !,
    K1 is K - 1,
    split(T, K1, L1, L2).

split(L0, _, [], L0).

rotate_left(L, K, R) :- 
    split(L, K, L1, L2), 
    append(L2, L1, R).

rotate_right(L, K, R) :-
    length(L, Len), 
    New is Len - K,
    split(L, New, L1, L2),
    append(L2, L1, R).


% 7.
rnd_select(L, K, [Random|R]) :-
    K > 0,
    K1 is K - 1,
    length(L, Len),
    random_between(0, Len, Random),
    rnd_select(L, K1, R).
