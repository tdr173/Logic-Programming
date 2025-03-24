% 1 3 4 5 2 6

% 1.selection_sort_decreasing_order
max1([H|T], Ma) :- max1(T, Ma), Ma > H, !. 
max1([H|_], H).

delete(X, [X|T], T) :- !.
delete(X, [H|T], [H|R]) :- delete(X, T, R).
delete(_, [], []).

selection_decreasing([], []).
selection_decreasing(L1, [Ma|R]) :- 
    max1(L1, Ma), 
    delete(Ma, L1, R1),
    selection_decreasing(R1, R).


% 3. bubble_sort_fixed
bubble_sort_fixed(L, K, R) :- 
    K1 is K - 1,
    K > 0, !,
    one_pass(L, R1),
    bubble_sort_fixed(R1, K1, R).
bubble_sort_fixed(L, _, L).

one_pass([H1, H2|T], [H2|R]) :-
    H1>H2, !,
    one_pass([H1|T], R).
one_pass([H1|T], [H1|R]) :- one_pass(T, R).
one_pass([], []).


% 3.sort_chars with quickSort
quick_sort([H|T], R) :-
    char_code(H, Pivot),
    partition(Pivot, T, Sm, Lg),
    quick_sort(Sm, SmS),
    quick_sort(Lg, LgS),
    append(SmS, [H|LgS], R).
quick_sort([], []).
    
        
partition(Pivot, [H|T], [H|Sm], Lg) :-
        char_code(H, Value),
        Value < Pivot, !,
        partition(Pivot, T, Sm, Lg).
partition(Pivot, [H|T], Sm, [H|Lg]) :-
        partition(Pivot, T, Sm, Lg).
partition(_, [], [], []).


% 5. sort_lens
quick_sort_lens([H|T], R) :-
    length(H, Pivot),
    partition_lens(Pivot, T, Sm, Lg),
    quick_sort_lens(Sm, SmS),
    quick_sort_lens(Lg, LgS),
    append(SmS, [H|LgS], R).
quick_sort_lens([], []).
    
        
partition_lens(Pivot, [H|T], [H|Sm], Lg) :-
        length(H, Value),
        Value < Pivot, !,
        partition_lens(Pivot, T, Sm, Lg).
partition_lens(Pivot, [H|T], Sm, [H|Lg]) :-
        partition_lens(Pivot, T, Sm, Lg).
partition_lens(_, [], [], []).


% 2.insertion_sort_forward
