% Write a Prolog program for computing the addition 
% of two natural numbers represented in the Peano form:
% using the constant 0 and the unary successor function for
% the terms representing the natural numbers.

s(0).
s(X):- X.
plus(0,X,X).
plus(s(X),Y,s(Z)) :- plus(X,Y,Z).

minus(X,Y,Z) :- plus(Z,Y,X).

% Using the same notation compute the product of two 
% natural numbers.

prod(0,_,0).
prod(s(X),Y,R) :- prod(X,Y,Z),
                  plus(Y,Z,R).



% Write a program which computes the permutations of a list
% of elements. 

% X is an element of L such that when you remove it from L
% you obtain list R (gives you many possibilities of all 
% the lists without X). X will be then put in the first position 
% and R (which is L-{X}) will be permutated recursively again.

omit(X,[X|T],T).
omit(X,[H|L],[H|R]) :- omit(X,L,R).
permute([],[]).
permute(L,[X|LO]) :- omit(X,L,R),
                     permute(R,LO).



% Write a program which computes the merge sort of the
% input list.

% 1.) split(L,L1,L2) :- “it divides the input list of integers in 
%     2 sublists L1 and L2 of length almost equal (one can have at 
%     most one more element than in the other one)”

split([],[],[]).
split([L],[L],[]).
split([A,B|L],[A|L1],[B|L2]) :- split(L,L1,L2).

% 2.) merge(L1,L2,LO):- “the two input ordered list L1 and L2 are
%     merged together in the ordered list LO”

merge([],L,L).
merge(L,[],L).
merge([X|L1],[Y|L2],[X|LO]) :- X<Y,  merge(L1,[Y|L2],LO).
merge([X|L1],[Y|L2],[Y|LO]) :- Y=<X, merge([X|L1],L2,LO).

% 3.) mergesort(L,LO):- “LO is the ordered list containing the values
%     in the input list L, using the merge sort algorithm”

mergesort([],[]).
mergesort([X],[X]).     % empty list or list with only 1 element
mergesort([X,Y|L],LO) :- split([X,Y|L],P1,P2),
                         mergesort(P1,S1),
                         mergesort(P2,S2),
                         merge(S1,S2,LO).
                        


% Write a program which computes the vectorial product of
% two elements.

vectProd([],[],0).
vectProd([X|L1],[Y|L2],R) :- vectProd(L1,L2,L),
                             R is X*Y + L.



% Write a program which computes the reversed list LO of 
% an input list L.

%solution1) 
reverse([],[]).
reverse([H|L],R) :- reverse(L,T),    % reversing tail
                    append(T,[H],R). % appending head to reversed tail

%solution2)  
% reverse_help recursively pushes the elements from the beginning 
% of the first list to the front of the second list.
% This reverses the order of the elements.
reverse_help([],H,H).    
reverse_help([X|Xs],H,R) :- reverse_help(Xs,[X|H],R).
reverse(X,Y) :- reverse_help(X,[],Y). 

                  
                  
% Write a program which takes an input list of single
% characters and checks if its palindrome.

palindrome(L) :- reverse(L,L).

