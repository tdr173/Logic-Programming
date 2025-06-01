% 1. convertIL2CL
convertIL2CL(L, []) :- var(L), !.
convertIL2CL([H|T], [H|R]) :- convertIL2CL(T, R).

convertCL2IL([], Tail, Tail).
convertCL2IL([H|T], [H|R], Tail) :- convertCL2IL(T, R, Tail).
convertCL2IL(CL, IL) :- convertCL2IL(CL, IL, _).


% 2. append_il
append_il(L1, L2, L2) :- var(L1), !.
append_il([], L2, L2) :- !.
append_il([H|T], L2, [H|R]) :-
    append_il(T, L2, R).


% 3. reverse_il
reverse_il(L, R) :- reverse_il(L, [], R).
reverse_il(L, Acc, R) :- var(L), !, append(Acc, L, R).
reverse_il([H|T], Acc, R) :- reverse_il(T, [H|Acc], R).

