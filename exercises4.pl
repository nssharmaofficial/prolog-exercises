% From Professor Moreno Falaschi at University of Siena 

% Write a program to check if the number of elements
% in two binary trees T1 and T2 is the same.

count(nil,0).                         % the end
count(t(_,nil,nil),1).                % at node
count(t(X,T1,T2),S):- count(T1,S1), 
                      count(T2,S2), 
                      S is 1+S1+S2.   % add 1 for X
                      
equal_el_in_tree([],[]).
equal_el_in_tree(t(X,T1,T2),t(Y,B1,B2)):- count(t(X,T1,T2),S1), 
                                          count(t(Y,B1,B2),S2),
                                          S1==S2.



% Write a program to select from an input list of integers 
% all odd values.

odd([],[]).
odd([X|L],LO):- 0 is mod(X,2),      % if X is even, ignore    
                odd(L, LO).
odd([X|L],[X|LO]):- 1 is mod(X,2),  % if X is odd, copy to result   
                  odd(L, LO).



% Write a program to check if two NOT ordered input vectors
% contain same elements.

list_same_length([], []).
list_same_length([_|L1], [_|L2]) :- list_same_length(L1, L2).

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

omit(X, [X|T], T).   
omit(X, [H|T], [H|R]) :- omit(X, T, R).

same_elements([], []).
same_elements([H|T], L2) :-   list_same_length([H|T],L2), 
                              member(H,L2),
                              omit(H,L2,LO),       %LO=L2-{H}
                              same_elements(T,LO).



% Write a program which checks if two lists (L1 and L2) of integer
% values are consecutive (for one element in L1 there exists one
% which is its successor in L2).

% Checking two consecutive elements of a list
next_to(X,Y,[X,Y|_]).
next_to(X,Y,[_|Z]) :- next_to(X,Y,Z).



% Compute the depth (height) of binary tree.
% It is the number of edges on the longest path from
% the root to a leaf.

depth_tree(nil,0).
depth_tree(t(X,T1,T2),D) :- depth_tree(T1,D1),
                            depth_tree(T2,D2),
                            D is max(D1,D2) + 1.
                            
  
                   
