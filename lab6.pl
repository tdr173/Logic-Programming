% 1.count_atomic
count_atomic([], 0).

count_atomic([H|T], R) :-
    atomic(H), !,
    count_atomic(T, RT),
    R is 1 + RT.

count_atomic([H|T], R) :-
    count_atomic(H, R1),
    count_atomic(T, R2),
    R is R1 + R2.


% 2.sum_atomic
sum_atomic([], 0).

sum_atomic([H|T], R) :-
    atomic(H), !,
    sum_atomic(T, RT),
    R is H + RT.

sum_atomic([H|T], R) :-
    sum_atomic(H, R1),
    sum_atomic(T, R2),
    R is R1 + R2.


% 3.replace
replace(_, _, [], []).
replace(Val, Replace, [H|T], [Replace|R]) :-
        atomic(H), 
        H == Val, !,
        replace(Val, Replace, T, R).
        
replace(Val, Replace, [H|T], [H|R]) :-
    atomic(H), !,
    replace(Val, Replace, T, R).

replace(Val, Replace, [H|T], [RH|RT]) :-
    replace(Val, Replace, H, RH),
    replace(Val, Replace, T, RT).


% 4.lasts
lasts([], []).
lasts([H], [H]) :-
    atomic(H), !.

lasts([H|T], R) :-
    atomic(H), !,
    lasts(T, R).

lasts([H|T], R) :- 
    lasts(H, RH),
    lasts(T, RT),
    append(RH, RT, R).


% 5.len_con_depth
len_con_depth_aux([], 0, []) :- !.
len_con_depth_aux([], Cnt, [Cnt]).

len_con_depth_aux([H|T], Cnt, R) :-
    atomic(H), !,
    Cnt1 is Cnt + 1, 
    len_con_depth_aux(T, Cnt1, R). 

len_con_depth_aux([H|T], Cnt, R) :-
    Cnt > 0, !, 
    len_con_depth_aux(H, 0, RH),
    len_con_depth_aux(T, 0, RT), 
    R = [Cnt, RH|RT].

len_con_depth_aux([H|T], _, R) :-
    len_con_depth_aux(H, 0, RH),
    len_con_depth_aux(T, 0, RT), 
    R = [RH|RT].

len_con_depth([H|T], R) :- 
    len_con_depth_aux([H|T], 0, R).




        
        
        
        
        
        
        
