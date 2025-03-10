% 1. add_first
add_first(X, [], [X]).
add_first(X, L, [X | L]).


% 2. append3
append([], L, L).
append([Head|Tail], L, Result) :-
    append(Tail, L, Result1), Result = [Head|Result1].
append3(L1, L2, L3, R) :- append(L1, L2, R1), append(R1, L3, R).


% 3. sum
sum_bwd([], 0).
sum_bwd([Head|Tail], R) :- sum_bwd(Tail, R1), R is Head + R1. 

sum_fwd(List, Result) :- sum_fwd_acc(List, 0, Result).
sum_fwd_acc([], Acc, Acc).
sum_fwd_acc([Head|Tail], Acc, Result) :- Acc1 is Acc + Head, sum_fwd_acc(Tail, Acc1, Result).


% 4. separate_parity
separate_parity([], [], []).

separate_parity([Head | Tail], E, O) :-
    Head mod 2 =:= 0, 
    separate_parity(Tail, E1, O),
    E = [Head | E1].

separate_parity([Head | Tail], E, O) :-
    Head mod 2 =:= 1,
    separate_parity(Tail, E, O1),
    O = [Head | O1].


% 5. remove_duplicates
member(X, [X | _]).
member(X, [_ | Tail]) :- member(X, Tail).

remove_duplicates([], []).

remove_duplicates([Head | Tail], Result) :- 
    remove_duplicates(Tail, Result1),
    member(Head, Result1),
    Result = Result1.

remove_duplicates([Head | Tail], Result) :- 
    remove_duplicates(Tail, Result1),
    \+ member(Head, Result1),
    Result = [Head | Result1].


% 6. replace_all 
replace_all(_, _, [], []).

replace_all(X, R, [Head | Tail], Result) :-
    replace_all(X, R, Tail, Result1),
    Head = X,
    Result = [R | Result1].

replace_all(X, R, [Head | Tail], Result) :-
    replace_all(X, R, Tail, Result1),
    Head \= X,
    Result = [Head | Result1].


% 7. drop_k
drop_k_aux([], _, _, []).

drop_k_aux([_ | Tail], Div, Pos, Result) :-
     Pos1 is Pos + 1,
     drop_k_aux(Tail, Div, Pos1, Result1),
     Pos1 mod Div =:= 0,
     Result = Result1.

drop_k_aux([Head | Tail], Div, Pos, Result) :-
     Pos1 is Pos + 1,
     drop_k_aux(Tail, Div, Pos1, Result1),
     Pos1 mod Div \= 0,
     Result = [Head | Result1].

drop_k(L, Div, Result) :- drop_k_aux(L, Div, 0, Result).


% 8. remove_consecutive_duplicates
remove_consecutive_duplicates([], []).

remove_consecutive_duplicates([Head, Head | Tail], Result) :-
    remove_consecutive_duplicates([Head | Tail], Result).

remove_consecutive_duplicates([Head | Tail], [Head | Result]) :-
    remove_consecutive_duplicates(Tail, Result).
