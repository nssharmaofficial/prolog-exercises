% From Professor Moreno Falaschi at University of Siena 

% Exercise 3) Non empty tree is represented by the term t(N,Tree1,Tree2), 
% where ’t’ is a ternary function, N is the root (an integer value), 
% and Tree1 and Tree2 represents (inductively) the left and right subtrees.

% Write a Prolog program intersectionTrees(T,T1,L), which given two binary 
% search trees T and T1 returns the list L of the values which belong to 
% the intersection of the values in T1 and T2.

% So, for instance
% intersectionTrees(t(3,t(-1,nil,nil),t(4,nil,t(-1,nil,nil))),
%                   t(3,t(-1,nil,nil),t(4,nil,t(4,nil,nil))),
%                   [-1,3,4]).
% is true.


elements_in_tree(nil,[]).
elements_in_tree(t(X,L,R),[X|S]) :- elements_in_tree(L,SL), 
                                    elements_in_tree(R,SR), 
                                    append(SL,SR,S).
    					  
                                
remove_duplicates([], []).
remove_duplicates([H|T],R) :-     member(H,T), !,
                                  remove_duplicates(T,R).
remove_duplicates([H|T],[H|R]) :- % if H is not a member of T
                                  remove_duplicates(T,R).


list_same([],_,[]).
list_same(_,[],[]).
list_same([X|L1],L2,[X|LO]):- member(X,L2),            
                              list_same(L1,L2,LO).
list_same([X|L1],L2,LO):-     \+member(X,L2),  
                              list_same(L1,L2,LO).                                  


intersectionTrees(T1,T2,L) :- elements_in_tree(T1,L1),
                              elements_in_tree(T2,L2),
                              list_same(L1,L2,LO),
                              remove_duplicates(LO,L).
                              
% ---------------------------ANOTHER SOLUTION ---------------------------------

searchNinTree(N,t(N,_,_)).
searchNinTree(N,t(_,T1,_)) :- searchNinTree(N,T1).
searchNinTree(N,t(_,_,T2)) :- searchNinTree(N,T2).

append_without_rep([],X,X).
append_without_rep(X,[],X).
append_without_rep([X|L1],L2,[X|LO]) :- append_without_rep(L1,L2,LO). 

intersectionTrees(nil,_,[]).
intersectionTrees(_,nil,[]).
intersectionTrees(t(X,T1,T2),T3,[X|L]) :-  intersectionTrees(T1,T3,L1),
    									                     intersectionTrees(T2,T3,L2),
    									                     append_without_rep(L1,L2,L),
    									                     searchNinTree(X,T3).
intersectionTrees(t(X,T1,T2),T3,L) :- intersectionTrees(T1,T3,L1),
    									                intersectionTrees(T2,T3,L2),
    									                append_without_rep(L1,L2,L),
    									                not(searchNinTree(X,T3)).
                              		  
    		
                         
