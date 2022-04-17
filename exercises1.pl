% From Professor Moreno Falaschi at University of Siena 

% Write a predicate second(X,List) which checks
% if X is the second element of List.

second(X,[_,X|_]). 



% Write a Prolog program which computes
% the fibonacci numbers.
% F(0)=0, F(1)=1
% F(n)=F(n-1)+F(n-2) 

fibonacci(0,1):-!.    % cut down the backtracking
fibonacci(1,1):-!.    % cut down the backtracking
fibonacci(N,X):-
  N > 0, 
  N2 is N - 2, 
  N1 is N - 1,
  fibonacci(N2,X2),   % get the X2 value
  fibonacci(N1,X1),   % get the X1 value
  X is X1 + X2.       % calculate the Fibonacci number



% Write a program which takes in input two ordered lists of 
% integers and returns an ordered list of integers containing
% all elements in the original lists.

merge([],L1,L1).          
merge(L2,[],L2).          
merge([X|L1],[Y|L2],[X|L]) :- X<Y, merge(L1,[Y|L2],L). 
merge([X|L1],[Y|L2],[Y|L]) :- Y=<X, merge([X|L1],L2,L). 

% using cut operator
merge([],L,L):- !. 
merge(L,[],L):- !.
merge([X|L],[Y|L1],[X|LO]) :- X<Y, !, merge(L,[Y|L1],LO).
merge([X|L],[Y|L1],[Y|LO]) :- merge([X|L],L1,LO).



% Write a program that taken one list L of integers and one 
% integer value N, divides the elements of L in two lists 
% L1 and L2 such that all elements less or equal than N 
% are in L1 and in L2 all the others.

partition(N,[],[],[]).
partition(N,[X|L],[X|L1],L2) :- X=<N, partition(N,L,L1,L2). 
partition(N,[X|L],L1,[X|L2])  :- X>N,  partition(N,L,L1,L2). 



% Write a program which given a list of integers L returns 
% an ordered list of integers containing the elements in L.

quicksort([],[]).
quicksort([X|L],L0) :- partition(X,L,L1,L2),
                       quicksort(L1,L01),
                       quicksort(L2,L02),
                       append(L01,[X|L02],L0).



% Write a program which given value N
% decides if N belongs to L.

member(N,[N|L]).
member(N,[_|L]) :- member(N,L). 



% Write a program which given two lists L1 and L2 of
% integers decides if all elements in the first list
% are present in the second one.

subset([],L2).
subset([X|L],L2) :- member(X,L2),
                    subset(L,L2).





% Write a program which returns only positive integers
% in a list.

positiveValues([], []).
positiveValues([X|L], [X|LO]) :- X>0, positiveValues(L, LO).
positiveValues([X|L], LO) :- X=<0, positiveValues(L, LO).



% Write a program to look for a value N inside a 
% binary search tree.

% we represent a non-empty binary tree as: t(X,T1,T2)
% where X is the value labelling the root of the tree, 
% and T1, T2 are respectively the left and the right 
% subtrees of the root, represented recursively.

searchNinTree(N,t(N,_,_)).
searchNinTree(N,t(_,T1,_)) :- searchNinTree(N,T1).
searchNinTree(N,t(_,_,T2)) :- searchNinTree(N,T2).




