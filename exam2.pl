% From Professor Moreno Falaschi at University of Siena 
% Exercise 2) Write a Prolog program ‘eliminate2consecutivevalues(L,X,Y,LO)’ which
% takes one input list of integers L, and two integer values X and Y, and returns
% the list LO. LO is obtained by eliminating from L the first occurrence of 
% the ‘sequence’ X followed by Y. L is returned unchanged in case there is no occurrence
% of X followed by Y.

% So, eliminate2consecutivevalues([3,2,-1,3,5,7,-20,3,5],3,5,[3,2,-1,7,-20,3,5]) 
% is true, and eliminate2consecutivevalues([3,2,-1,3,7,-20],3,8,[3,2,-1,3,7,-20]) is true.

% ------------------------------------FIRST SOLUTION-----------------------------------------
% Find first such pair where Y is on (Kth+1) position and X on Kth position, and then
% delete Kth elements from the list twice (X and Y).

element_at(X,[X|_],1).  
element_at(X,[_|T],K) :- element_at(X,T,K2),
                         K is K2+1.

first_pair(X,Y,L,K) :- element_at(Y,L,KY),
                       KX is KY-1,
                       element_at(X,L,KX),!,
                       K is KX.
               
delete_kth(1,[_|T],T).
delete_kth(K,[X|Y],[X|R]):- K1 is K-1, %-1 because of X
                            delete_kth(K1,Y,R).
                            
eliminate2consecutivevalues(L,X,Y,L2) :- first_pair(X,Y,L,K),
                                         delete_kth(K,L,L1),  % delete X
                                         delete_kth(K,L1,L2). % delete Y
eliminate2consecutivevalues(L,X,Y,L) :- not(first_pair(X,Y,L,_)).


%---------------------------------- SECOND SOLUTION ---------------------------------------

eliminate2consecutivevalues([],X,Y,[]).
eliminate2consecutivevalues([A],X,Y,[A]).
eliminate2consecutivevalues([X,Y|L],X,Y,L) :- !.
eliminate2consecutivevalues([A,B|L],X,Y,[A|LO]) :- eliminate([B|L],X,Y,LO).

