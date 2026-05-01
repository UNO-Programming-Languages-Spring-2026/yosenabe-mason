% Q1 part: moves every numbered block straight to a gray line
% Each number picks a cell that is gray, and is either horiz. or vert. aligned
valid_target(X,Y,XX,YY) :-
    number(X,Y,_),
    area(XX,YY,_),
    XX = X,
    YY != Y.
valid_target(X,Y,XX,YY) :-
    number(X,Y,_),
    area(XX,YY,_),
    YY = Y,
    XX != X.
    
1 { target(X,Y,XX,YY) : valid_target(X,Y,XX,YY) } 1 :-
    number(X,Y,_).

% Q2 part beneath here 
% force each sec to have at least 1 num
:- area(_,_,A), not covered(A).

covered(A) :-
    target(_,_, XX, YY),
    area(XX, YY, A).


#show target/4.