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

%Q3 part beneath here:
%track paths so they dont cross
% Q3 part:
% Track every grid cell used by a move path.
path(X,Y,PX,PY) :- target(X,Y,XX,YY), XX = X, YY > Y, PX = X, PY >= Y, PY <= YY, cell(PX,PY).
path(X,Y,PX,PY) :- target(X,Y,XX,YY), XX = X, YY < Y, PX = X, PY <= Y, PY >= YY, cell(PX,PY).
path(X,Y,PX,PY) :- target(X,Y,XX,YY), YY = Y, XX > X, PY = Y, PX >= X, PX <= XX, cell(PX,PY).
path(X,Y,PX,PY) :- target(X,Y,XX,YY), YY = Y, XX < X, PY = Y, PX <= X, PX >= XX, cell(PX,PY).
%make order pairs of nums so we compare each once
before(X1,Y1,X2,Y2) :- number(X1,Y1,_), number(X2,Y2,_), X1 < X2.
before(X1,Y1,X2,Y2) :- number(X1,Y1,_), number(X2,Y2,_), X1 = X2, Y1 < Y2.
%No paths can share a cell
:- before(X1,Y1,X2,Y2), path(X1,Y1,PX,PY), path(X2,Y2,PX,PY).

#show target/4.