% 0. Delete all
delete_all(_, [], []). 

delete_all(X, [H|T], R) :- 
    H == X, !, delete_all(X, T, R).

delete_all(X, [H|T], [H|R]) :-
    delete_all(X, T, R).


% 1. add_first
add_first(_, [], []).

add_first(X, L, [X|L]).


% 2. append3
append3(L1, L2, L3, R) :-
    append(L1, L2, Aux), 
    append(Aux, L3, R).


% 3. sum_bwd and sum_fwd
sum_bwd([], 0).

sum_bwd([H|T], S) :-
    sum_bwd(T, S1), S is S1 + H.

sum_fwd([], Acc, Acc).

sum_fwd([H|T], Acc, R) :-
    Acc1 is Acc + H, sum_fwd(T, Acc1, R).

sum_fwd(L, R) :- sum_fwd(L, 0, R).


% 4. separate_parity
separate_parity([], [], []).

separate_parity([H|T], [H|E], O) :-
    0 is H mod 2, !, separate_parity(T, E, O).

separate_parity([H|T], E, [H|O]) :-
    separate_parity(T, E, O).


% 5. remove_duplicates1 - keep the first occurence, remove_duplicates2 - keep the last occurence
remove_duplicates1([], [], _).

remove_duplicates1([H|T], R, Aux) :- 
    member(H, Aux), !, remove_duplicates1(T, R, Aux).
    
remove_duplicates1([H|T], [H|R], Aux) :-
    remove_duplicates1(T, R, [H|Aux]).

remove_duplicates1(L, R) :- remove_duplicates1(L, R, []).

remove_duplicates2([], [], _).

remove_duplicates2([H|T], R, Aux) :- 
    member(H, Aux), !, 
    remove_duplicates2(T, R, Aux).
    
remove_duplicates2([H|T], [H|R], Aux) :-
    remove_duplicates2(T, R, [H|Aux]).

remove_duplicates2(L, R) :- 
    reverse(L, Rev),
    remove_duplicates2(Rev, AuxRes, []),
    reverse(AuxRes, R).


% 6. replace_all
replace_all(_, _, [], []).

replace_all(From, To, [H|T], [To|R]) :-
    H == From, !, replace_all(From, To, T, R).

replace_all(From, To, [H|T], [H|R]) :-
    replace_all(From, To, T, R).


% 7. drop_k
drop_k([], _, [], _).

drop_k([_|T], K, R, Pos) :-
    Pos1 is Pos + 1, 
    0 is Pos1 mod K, !,
    drop_k(T, K, R, Pos1).

drop_k([H|T], K, [H|R], Pos) :-
    Pos1 is Pos + 1,
    drop_k(T, K, R, Pos1).

drop_k(L, K, R) :- drop_k(L, K, R, 0).


% 8. remove_consecutive_duplicates
rcd([], [], _).

rcd([H|T], R, Last) :-
    H == Last, !,
    rcd(T, R, H).

rcd([H|T], [H|R], _) :-
    rcd(T, R, H).

rcd([H|T], [H|R]) :- rcd([H|T], R, H). % add the first element manually


% 9. pack_consecutive_duplicates
pack_same(_, [], [], []).

pack_same(H, [H|T], [H|Group], Remaining) :-
    pack_same(H, T, Group, Remaining).

pack_same(Val, [H|T], [], [H|T]) :-
    not(H == Val).

pack_consecutive_duplicates([], []).

pack_consecutive_duplicates([H|T], [[H|Group]|Result]) :-
    pack_same(H, T, Group, Rest),
    pack_consecutive_duplicates(Rest, Result).
