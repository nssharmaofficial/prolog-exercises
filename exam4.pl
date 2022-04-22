% Exercise 4) Consider a binary tree of integers represented by the notation
% t(N,Tree1,Tree2). Write a Prolog program NoccurrencesInTree(T,N,L),
% which given one binary search tree T and a positive integer N, returns
% the list L of the values which belong to T, and which occur exactly N
% times in T. 

% So, for instance
% NoccurrencesInTree(t(-1,t(3,nil,nil),t(4,nil,t(-1,nil,t(3,nil,nil)))),2,[-1,3])
% is true.

% occurrences_list(Element,List,N occurrences)
occurrences_list(_,[],0).
occurrences_list(X,[X],1).
occurrences_list(X,[X|L],N):- !, occurrences_list(X,L,N2), N is N2+1.
occurrences_list(X,[_|L],N):- occurrences_list(X,L,N).

% delete all X in list
deleteallX(_,[],[]).
deleteallX(X,[X|T],L):-!,deleteallX(X,T,L).
deleteallX(X,[Y|T],[Y|L]):-deleteallX(X,T,L).

% noccurencesInList(List,N,Elements occurring N times in List)

% If I have a noccurencesInList([1,1,1,2,2],3,L) it will take the
% first element 1 and ask how many times it occurs in the rest of 
% the list (its 2 times). Since we ask for elements that occur 3
% times, when we delete the two 1s from the rest of the list, we
% will be left with list containing all the elements that occur
% 3 times (L=[1]).

noccurrencesInList([],_,[]).
noccurrencesInList([X|L],N,[X|LO]):- occurrences_list(X,L,C2),
                                     C is C2+1, C==N, !,
                                     deleteallX(X,L,LR),
                                     noccurrencesInList(LR,N,LO).   
noccurrencesInList([X|L],N,LO):- occurrences_list(X,L,_),
                                 deleteallX(X,L,LR),
                                 noccurrencesInList(LR,N,LO).

elements_in_tree(nil,[]).
elements_in_tree(t(X,L,R),[X|S]) :- elements_in_tree(L,SL), 
                                    elements_in_tree(R,SR), 
                                    append(SL,SR,S).
                                    
noccurrencesInTree(nil,_,[]).
noccurrencesInTree(T,N,LO):- elements_in_tree(T,L),noccurrencesInList(L,N,LO).                                    
                                    
                                    
