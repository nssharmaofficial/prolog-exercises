% 1.01 (*) Find the last element of a list.

% Example:
% ?- my_last(X, [a, b, c, d]).
% X = d

last_element([X],X).
last_element([_|T],X) :- last_element(T,X).


% 1.02 (*) Find the last but one element of a list.

% Example:
% ?- last_but_one(X, [a, b, c, d]).
% X = c

second_last_element([X,_],[X]).
second_last_element([_|T],X) :- second_last_element(T,X).


% 1.03 (*) Find the Kth element of a list.
% The first element in the list is number 1.

% Example:
% ?- element_at(X, [a, b, c, d], 3).
% X = c

kth_element([X|_],1,[X]).
kth_element([_|T],K,X) :- K>1, 
    					  K2 is K-1,
    					  kth_element(T,K2,X).
                

% 1.04 (*) Find the number of elements of a list.

% Example:
% ?- my_length(X, [a, b, c]).
% X = 3

my_length([],0).
my_length([_|T],L) :- my_length(T,L2), L is L2+1.


% 1.05 (*) Reverse a list.

% Example:
% ?- reverse([a, b, c, d], X).
% X = [d, c, b, a]

reverse([],[]).
reverse([H|T],L) :- reverse(T,LO),
    				append(LO,[H],L).


% 1.06 (*) Find out whether a list is a palindrome.

% Example:
% ?- is_palindrome([x, a, m, a, x]).
% true.

is_palindrome(X) :- my_reverse(X, X).


% 1.07 (**) Flatten a nested list structure.

% Example:
% ?- my_flatten([a, [b, [c, d], e]], X).
% X = [a, b, c, d, e]

unlist([],[]).
unlist(X,[X]) :- not(is_list(X)).
unlist([H|T],L) :- unlist(H,H1),
                   unlist(T,T1),
                   append(H1,T1,L).


% 1.08 (**) Eliminate consecutive duplicates of list elements.

% Example:
% ?- compress([a, a, a, a, b, c, c, a, a, d, e, e, e, e], X).
% X = [a, b, c, d, e]

remove_cons_duplicates([],[]).
remove_cons_duplicates([X],[X]).
remove_cons_duplicates([X,X|T],L) :- remove_cons_duplicates([X|T],L).
remove_cons_duplicates([X,Y|T],[X|L]) :- remove_cons_duplicates([Y|T],L).


% 1.09 (**) Pack consecutive duplicates of list elements into sublists.

% Example:
% ?- pack([a, a, a, a, b, c, c, a, a, d, e, e, e, e], X).
% X = [[a, a, a, a], [b], [c, c], [a, a], [d], [e, e, e, e]]

duplicates_in_sublist([],[]).
duplicates_in_sublist([X],[[X]]).
duplicates_in_sublist([X|T],[[X,X|T1]|T2] ) :- duplicates_in_sublist(T,[[X|T1]|T2]). 
duplicates_in_sublist([X|T],[[X],[Y|T1]|T2]):-duplicates_in_sublist(T,[[Y|T1]|T2]).


% 1.10 (*) Run-length encoding of a list.

% Example:
% ?- encode([a, a, a, a, b, c, c, a, a, d, e, e, e, e], X).
% X = [[4, a], [1, b], [2, c], [2, a], [1, d], [4, e]]

encode([],[]).
encode([X],[[1,X]]).
encode([X,X|T], [[N,X]|T2]) :- encode([X|T],[[N2,X]|T2]),
    						   N is N2+1.
encode([X,Y|T], [[1,X],[N,Y]|T2]) :- encode([Y|T],[[N,Y]|T2]).


% 1.12 (**) Decode a run-length encoded list.

% Example:
% ?- decode([[4, a], [1, b], [2, c], [2, a], [1, d], [4, e]], X).
% X = [a, a, a, a, b, c, c, a, a, d, e, e, e, e]

decode([],[]).
decode([[N,X]|T],L) :- write_multiple(X,N,L1),
    				   decode(T,L2),
    				   append(L1,L2,L).
write_multiple(_,0,[]).
write_multiple(X,N,[X|L]) :- N2 is N-1,
    						 write_multiple(X,N2,L).


% 1.15 ()*) Duplicate the elements of a list a given number of times.

% Example:
% ?- dupli([a, b, c], 3, X).
% X = [a, a, a, b, b, b, c, c, c]

duplicate([],_,[]).
duplicate([X|T],N,L) :- write_multiple(X,N,L1),
    				    duplicate(T,N,L2),
    				    append(L1,L2,L).


% 1.16 (**) Drop every Nth element from a list.

% Example:
% ?- drop_every([a, b, c, d, e, f, g, h, i, k], 3, X).
% X = [a, b, d, e, g, h, k]

drop_every([],_,[]).
drop_every(X,N,Y) :-
  X \= [],
  N2 is N-1,
  take(N2,X,S),
  drop(N,X,E),
  drop_every(E,N,E_),
  append(S,E_,Y).

take(_,[],[]).
take(0,_,[]).
take(N,[X|T],[X|Y]) :- N > 0,
                       N2 is N-1,
                       take(N2,T,Y).

drop(_,[],[]).
drop(0,X,X).
drop(N,[_|T],Y) :- N > 0, 
                   N2 is N-1,
                   drop(N2,T,Y).


% 1.17 (*) Split a list into two parts; the length of the first part is given.

% Example:
% ?- split([a, b, c, d, e, f, g], 3, L1, L2)
% L1 = [a, b, c]
% L2 = [d, e, f, g]

split(X,N,L1,L2) :- take(N,X,L1),drop(N,X,L2).


% 1.18 (**) Extract a slice from a list.
% Given two indices, I and K, the slice is the list containing the elements
% between the Ith and Kth element of the original list (both limits included).
% Start counting the elements with 1.

% Example:
% ?- slice([a, b, c, d, e, f, g, h, i, k], 3, 7, L)
% L = [c, d, e, f, g]

slice(L,Start,End,LO) :- take(End,L,L1),
    					 Start2 is Start-1,
    					 drop(Start2,L1,LO).
                         

% 1.20 (*) Remove the Kth element from a list.

% Example:
% ?- remove_at(X, [a, b, c, d], 2, R).
% X = b
% R = [a, c, d]

remove_at(X, L, N, LO) :- N2 is N-1,
    					  split(L, N2, L1, [X|L2]),
    					  append(L1, L2, LO).


% 1.21 (*) Insert an element at a given position into a list.

% Example:
% ?- insert_at(alfa,[a,b,c,d],2,L).
% L = [a,alfa,b,c,d]

insert_at(X,L,N,LO) :- N2 is N-1,
    				   split(L,N2,L1,L2),
    				   append(L1,[X|L2],LO).
                       
                       
                       
