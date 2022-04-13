% EXERCISE 1) Write a Prolog program ‘ascendingorder(L,N,M,LO)’ that given a list 
% of integers L, ordered in ascending order with possible repetitions 
% of values, and two integer numbers N, M, 
% returns an ordered list LO containing all elements in L plus N and M,
% without repetitions.

% So, for instance ascendingorder([-5,-3,0,1,1,4,7],7,2,[-5,-3,0,1,2,4,7]) is true.

% if X is member of a list
member(X,[X|_]).
member(X,[_|T]):-member(X,T).

% remove duplicates
remove_duplicates([], []).
remove_duplicates([H|T],R) :- member(H,T), !,
                              remove_duplicates(T,R).
remove_duplicates([H|T],[H|R]) :- % if H is not a member of T
                                  remove_duplicates(T,R).

% insert X in its correct position in a sorted list
insert(X, [], [X]).
insert(X, [Y|T], [X,Y|T]) :- X < Y, !.
insert(X, [Y|T0], [Y|T])  :- % if Y=<X then insert X in tail
                             insert(X, T0, T).
    
ascendingorder(L,N1,N2,LO):- insert(N1,L,L1),
                             insert(N2,L1,L2),
                             remove_duplicates(L2,LO).
                                      
                                       
