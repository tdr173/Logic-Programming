% 0. union
union([], L2, L2).

union([H1|T1], L2, [H1|R]) :-
    \+ member(H1, L2), !, 
    union(T1, L2, R).
        
union([_|T1], L2, R) :-
    union(T1, L2, R).
   

% 1. intersect 
intersect([], _, []).

intersect([H1|T1], L2, [H1|R]) :-
    member(H1, L2), !, 
    intersect(T1, L2, R).

intersect([_|T1], L2, R) :-
    intersect(T1, L2, R).


% 2. difference
diff([], _, []).

diff([H1|T1], L2, [H1|R]) :-
    \+ member(H1, L2), !,
    diff(T1, L2, R).

diff([_|T1], L2, R) :-
    diff(T1, L2, R).


% 3. del_min
min([X], X).

min([H|T], Min) :-
    min(T, TempMin), 
    Min is min(H, TempMin).

del_min([], []).

del_min([H|T], R) :-
    min([H|T], Min),
    H == Min, !,
    del_min(T, R).

del_min([H|T], [H|R]) :-
    del_min(T, R).
    

% 4. reverse_k
reverse_k([], _, [], [], _).

reverse_k([H|T], K, [H|Left], Right, Index) :- 
    Index1 is Index + 1,
    Index1 =< K, !,
    reverse_k(T, K, Left, Right, Index1).

reverse_k([H|T], K, _, [H|Right], Index) :- 
    Index1 is Index + 1,
    reverse_k(T, K, [], Right, Index1).

reverse_k(L, K, R) :- 
    reverse_k(L, K, Left, Right, 0),
    reverse(Right, Right1),
    append(Left, Right1, R).
    
    
% (5+6). rle_encode
rle_encode([], []).

rle_encode([H|T], R) :-
    pack(T, H, 1, R).

pack([], Last, 1, [Last]).

pack([], Last, Count, [[Last, Count]]).

pack([H|T], Last, Count, Result) :-
    H == Last, !,
    Count1 is Count + 1, 
    pack(T, H, Count1, Result).

pack([H|T], Last, 1, [Last|Result]) :-
    pack(T, H, 1, Result).

pack([H|T], Last, Count, [[Last, Count]|Result]) :- 
    Count > 1,
    pack(T, H, 1, Result).


% 7. rotations

rotateLeft([], _, [], [], _).

rotateLeft([H|T], K, Left, [H|Right], Index) :-
    Index1 is Index + 1, 
    K < Index1, !, 
    rotateLeft(T, K, Left, Right, Index1).

rotateLeft([H|T], K, [H|Left], Right, Index) :-
    Index1 is Index + 1, 
    rotateLeft(T, K, Left, Right, Index1).

rotateLeft([], _, []).

rotateLeft(L, K, R) :- 
    length(L, Len),
    NewK is Len - K,
    rotateLeft(L, NewK, Left, Right, 0),
    append(Right, Left, R).
