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

% ------------------------- FIRST SOLUTION -------------------------------
% Write two lists containing all elements in the trees and then do
% intersection of both the lists to remove duplicates.

elements_in_tree(nil,[]).
elements_in_tree(t(X,L,R),[X|S]) :- elements_in_tree(L,SL), 
                                    elements_in_tree(R,SR), 
                                    append(SL,SR,S).
    					                       
intersection_help([],_,_,[]).
intersection_help([X|L1],L2,L,[X|LO]) :- member(X,L2),!,
                                         not(member(X,L)),!,
                                         intersection_help(L1,L2,[X|L],LO).
intersection_help([_|L1],L2,L,LO) :- intersection_help(L1,L2,L,LO).
intersection(L1,L2,LO) :- intersection_help(L1, L2, [], LO).                                

intersectionTrees(T1,T2,L) :- elements_in_tree(T1,L1),
                              elements_in_tree(T2,L2),
                              intersection(L1,L2,L).
                      
                      
% ---------------------------SECOND SOLUTION ---------------------------------
% For all elements in the first tree check if they appear in the second one,
% and if yes then write them in a list (one for right path and one for left).
% In the end append both lists without repetitions.

searchNinTree(N,t(N,_,_)).
searchNinTree(N,t(_,T1,_)) :- searchNinTree(N,T1).
searchNinTree(N,t(_,_,T2)) :- searchNinTree(N,T2).

append_without_rep([],X,X).
append_without_rep(X,[],X).
append_without_rep([X|L1],L2,[X|LO]) :- append_without_rep(L1,L2,LO). 

intersectionTrees(nil,_,[]).
intersectionTrees(_,nil,[]).
intersectionTrees(t(X,T1,T2),T3,[X|L]) :-  searchNinTree(X,T3), !,
                                           itersectionTrees(T1,T3,L1),
                                           intersectionTrees(T2,T3,L2),
                                           append_without_rep(L1,L2,L).
                                           
intersectionTrees(t(X,T1,T2),T3,L) :- intersectionTrees(T1,T3,L1),
                                      intersectionTrees(T2,T3,L2),
                                      append_without_rep(L1,L2,L).     
                              		     		
                         
