
% Exercise 1
gcd(X,X,X).
gcd(X,Y,Z) :- X>Y, Diff is X-Y, gcd(Diff, Y, Z).
gcd(X,Y,Z) :- X<Y, Diff is Y-X, gcd(Y, Diff, Z).

lcm(X,Y,Z) :- gcd(X, Y, Z1), Z is X * Y / Z1.

% Exercise 2
triangle(A,B,C) :- A>0, B>0, C>0, A+B>C, A+C>B, B+C>A.

% Exercise 3
solve(A,B,C,X) :- Delta is B*B-4*A*C, Delta>0, X is (-B+sqrt(Delta))/2*A.
solve(A,B,C,X) :- Delta is B*B-4*A*C, Delta>0, X is (-B-sqrt(Delta))/2*A.

% Exercise 4
% 2, 2*2, 2*2*2
power(_,0,Acc,R) :- Acc = R.
power(X,Y,Acc,R) :- Y>0, Y1 is Y-1, Acc1 is Acc*X, power(X,Y1,Acc1,R).
power_fwd(X,Y,Z) :- power(X,Y,1,Z).

power_bwd(_,0,1).
power_bwd(X,Y,Z) :- Y>0, Y1 is Y-1, power_bwd(X, Y1, Z1), Z is X*Z1.

% Exercise 5
% backward calculeaza rezultatul dupa ce se calculeaza functia
fib_bwd(0, R) :- R=0.
fib_bwd(1, R) :- R=1.
fib_bwd(X, R) :- X>1, X1 is X-1, X2 is X-2, fib(X1,R1), fib(X2,R2), R is R1+R2.

fib_fwd(0,Acc1,_,X) :- Acc1 = X.
fib_fwd(N,Acc1,Acc2,X) :- N>0, N1 is N-1, AccNext is Acc1+Acc2, fib_fwd(N1, Acc2, AccNext,X).
fib_fwd(N,X) :- fib_fwd(N,0,1,X).    
