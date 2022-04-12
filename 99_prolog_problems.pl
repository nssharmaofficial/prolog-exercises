% 1.) Find the last element of a list.

last([X],X).
last([_|L],X) :- last_in_list(L,X).



% 2.) Find the second last element of a list.

second_last([X,_],X).
second_last([_,L|T],X) :- second_last([L|T],X).



% 3.) Find the Kth element of a list.
%     Example:
%     ?- element_at(X, [a, b, c, d], 3).
%     X = c

kth_element(X,[X|_],1).
kth_element(X,[_|T],P) :- P>1,
                          % when it finds X in P2 position we
                          % need to count that the real position P
                          % is P2+1 because we started at head and
                          % moved to tail T.
                          P2 is P-1,    
                          kth_element(X,T,P2).
                          


% 4.) Find the number of elements of a list.

my_length(0,[]).
my_length(1,[_]).
my_length(X,[_|T]) :- my_length(X2,T),
                      X is X2+1.
                      
                      

% 5.) Reverse a list.

% reverse_help recursively pushes the elements from the beginning 
% of the first list to the front of the second list.
% This reverses the order of the elements.

reverse_help([],H,H). 
reverse_help([X|Xs],H,R) :- reverse_help(Xs,[X|H],R).
reverse(X,Y) :- reverse_help(X,_,Y).   



% 6.) Find out whether a list is a palindrome.

palindrome([]).
palindrome([_]).
palindrome(X) :- reverse(X,X). 

% 7.) Flatten a nested list structure.
%     Example:
%     ?- my_flatten([a, [b, [c, d], e]], X).
%     X = [a, b, c, d, e]












