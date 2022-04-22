% Detect whether a list contains a number.

num_in_list([]) :- fail.
num_in_list([X|_]) :- number(X), !.
num_in_list([_|T]) :- num_in_list(T).



% Increment elements of a list.

increment([],[]).
increment([H|T],[H2|T2]) :- H2 is H+1, 
                            increment(T,T2).
                            


% Encapsulate list elements.

encapsulate([],[]).
encapsulate([H|T],[[H]|T2]) :- encapsulate(T,T2).



% Insert zeros between each element.

insert_zeros([],[]).
insert_zeros([H|T],[H,0|T2]) :- insert_zeros(T,T2).



% Clone list.

clone_list(L,[L,L]).



% Modify list element.

modify_list([],_,_,[]).
modify_list([H|T],0,_,[H|T]).
modify_list([_|T],1,X,[X|T]).
modify_list([H|T],N,X,[H|T2]) :- N>1, 
                                 N2 is N-1,
                                 modify_list(T,N2,X,T2).



