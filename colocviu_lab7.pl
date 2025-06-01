% Exemplu de arbori
tree1(
    t(6,
      t(4, t(2, nil, nil), t(5, nil, nil)),
      t(9, t(7, nil, nil), nil)
    )
).

tree2(
    t(5,
      t(3, t(2, nil, nil), t(4, nil, nil)),
      t(7, t(6, nil, nil), t(8, nil, nil))
    )
).



% 1. INORDER (în ordine crescătoare: stânga → rădăcină → dreapta)
inorder(nil, []).
inorder(t(K, L, R), List) :-
    inorder(L, LL),
    inorder(R, LR),
    append(LL, [K|LR], List).

% 2. PREORDER (rădăcină → stânga → dreapta)
preorder(nil, []).
preorder(t(K, L, R), List) :-
    preorder(L, LL),
    preorder(R, LR),
    append([K|LL], LR, List).

% 3. POSTORDER (stânga → dreapta → rădăcină)
postorder(nil, []).
postorder(t(K, L, R), List) :-
    postorder(L, LL),
    postorder(R, LR),
    append(LL, LR, R1),
    append(R1, [K], List).



% 4. CAUTĂ O CHEIE ÎN BST
search_key(K, t(K, _, _)) :- !.
search_key(Key, t(K, L, _)) :-
    Key < K,  !,
    search_key(Key, L).
search_key(Key, t(_, _, R)) :-
    search_key(Key, R).



% 5. AFIȘARE „GRAFICĂ” A ARBORILOR (în ordine infixă, cu indentare)
%    Usează tab(8) pentru fiecare nivel suplimentar.
pretty_print(T) :- pretty_print(T, 0).

pretty_print(nil, _).
pretty_print(t(K, L, R), D) :-
    D1 is D + 1,
    pretty_print(L, D1),
    print_key(K, D),
    pretty_print(R, D1).

print_key(K, D) :-
    D > 0, !,
    D1 is D - 1,
    tab(8),
    print_key(K, D1).
print_key(K, _) :-
    write(K), nl.



% 6. INSERT ÎN BST
%    Dacă arborele e gol, creează un nod cu Key.
%    Dacă Key există deja, nu-l inserăm (cut+fail previn dublarea).
%    Altfel, coborâm stânga sau dreapta după valoare.
insert(Key, nil, t(Key, nil, nil)).
insert(Key, t(Key, L, R), t(Key, L, R)) :- !.
insert(Key, t(K, L, R), t(K, NL, R)) :-
    Key < K, !,
    insert(Key, L, NL).
insert(Key, t(K, L, R), t(K, L, NR)) :-
    insert(Key, R, NR).



% 7. DELETE ÎN BST
%    (1) Nod cu un singur copil pe dreapta → înlocuim cu R
%    (2) Nod cu un singur copil pe stânga  → înlocuim cu L
%    (3) Nod cu doi copii                 → găsim predecesor în stânga
%    (4) Căutare recursivă în stânga      → Key < K
%    (5) Căutare recursivă în dreapta     → Key > K
delete(Key, t(Key, L, nil), L) :- !.
delete(Key, t(Key, nil, R), R) :- !.
delete(Key, t(Key, L, R), t(Pred, NL, R)) :-   % doi copii → înlocuim cu predecesor
    !,
    get_pred(L, Pred, NL).
delete(Key, t(K, L, R), t(K, NL, R)) :-
    Key < K,  !,
    delete(Key, L, NL).
delete(Key, t(K, L, R), t(K, L, NR)) :-
    Key > K,        % e mai clar să specificăm „Key > K”
    delete(Key, R, NR).

% 7.a. get_pred/3: extrage cheia maximă (predecesor) din subarborele stâng
get_pred(t(Pred, L, nil), Pred, L) :- !.
get_pred(t(K, L, R), Pred, t(K, L, NR)) :-
    get_pred(R, Pred, NR).



% 8. HEIGHT (înălțimea arborelui)
%    Height(nil) = 0
%    Height(t(_, L, R)) = 1 + max(Height(L), Height(R))
height(nil, 0).
height(t(_, L, R), H) :-
    height(L, HL),
    height(R, HR),
    max(HL, HR, M),
    H is M + 1.

% 8.a. max/3: al treilea parametru este maximul primilor doi
max(A, B, A) :- A >= B, !.
max(_, B, B).

tree1(t(6, t(4,t(2,nil,nil),t(5,nil,nil)), t(9,t(7,nil,nil),nil))).
tree2(t(5, t(3, t(2, nil, nil), t(4, nil, nil)), t(7, t(6, nil, nil), t(8, nil, nil)))).

% 4. leaves to list 
ltl(nil, []).
ltl(t(K, nil, nil), [K]).
ltl(t(_, L, R), Res) :-
    ltl(L, R1),
    ltl(R, R2),
    append(R1, R2, Res).

% 5. all internal
itl(nil, []).
itl(t(_, nil, nil), []) :- !.
itl(t(K, L, R), [K|Res]) :-
    itl(L, R1),
    itl(R, R2),
    append(R1, R2, Res).

height(nil, 0).
height(t(_, L, R), H) :- 
    height(L, H1),
    height(R, H2),
    max(H1, H2, Max),
    H is Max + 1.

max(A, B, A) :- A > B, !.
max(_, B, B).


% 6. 
same_depth(nil, _, []).
same_depth(t(Key, _, _), 1, [Key]).
same_depth(t(_, L, R), D, Res) :- 
    D > 1, 
    D1 is D-1,
    same_depth(L, D1, NL),
    same_depth(R, D1, NR),
    append(NL, NR, Res).

% 7. diam
diam(nil, 0).
diam(t(K, L, R), D) :-
    diam(L, DL),
    diam(R, DR),
    height(L, HL),
    height(R, HR),
    AuxH is HL+HR+1,
    max(DL, DR, Dmax),
    max(Dmax, AuxH, MaxAux).





