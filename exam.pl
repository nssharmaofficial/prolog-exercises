% EXERCISE 1) Write a Prolog program ‘ascendingorder(L,N,M,LO)’ that given a list 
% of integers L, ordered in ascending order with possible repetitions 
% of values, and two integer numbers N, M, 
% returns an ordered list LO containing all elements in L plus N and M,
% without repetitions.
% So, for instance ascendingorder([-5,-3,0,1,1,4,7],7,2,[-5,-3,0,1,2,4,7]) is true.

% append, delete repetitions, ascending order

% is X member of list
member(X,[X|_]).
member(X,[H|T]):-member(X,T).

% delete all Xs from list 
deleteall(X,[],[]).
deleteall(X,[X|T],U):-!,deleteall(X,T,U).
deleteall(X,[H|T],[H|U]):-deleteall(X,T,U).

delete_dupl([],[]).
delete_dupl([H|T],D):- member(H,T),!,
                       deleteall(H,T,T1),
                       delete_dupl(T1,D).
delete_dupl([H|T],[H|D]):-delete_dupl(T,D).


ascendingorder([],[],[],[]).
ascendingorder([],[],[N2],[N2]).
ascendingorder([],[N1],[],[N1]).
asendingorder([],[N1],[N2],[N1|N2]) :- N1<N2.
asendingorder([],[N1],[N2],[N2|N1]) :- N2=<N1.
ascendingorder([H|L],[N1],[N2],[LO]):- append([H|L],[N1],A1),
                                       append(A1,[N2],A2),
                                       delete_dupl(A2,D),
                                       ascendingorder([D,[],[],LO]).
                                       
                                       
