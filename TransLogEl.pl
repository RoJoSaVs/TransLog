/*
LENGUAJES COMPILADORES E INTERPRETES
GRUPO 01
PREOYECTO TRANSLOG 
*/
:- include(database).
%:- include(datosAdjetivos).
%:- include(datosSustantivos).
%:- include(datosVerbos).
%:- include(datosPronombres).

transLog:-
    write("Ingrese el idioma a traducir / Type the language to translate"), nl,
    read(IDIOMA), 
    traducir(IDIOMA), !.

traducir(IDIOMA):- 
    IDIOMA = "ES",
        write("Escriba el texto para traducir"), nl,
        read(ENTRADA),
        string_lower(ENTRADA, ORACION),
        split_string(ORACION, " ", "", ListaOracion),
        oracion(ListaOracion, TRADUCCION),
        write(TRADUCCION). 

traducir(IDIOMA):- 
    IDIOMA = "EN",
        write("Type text to translate "),
        nl,
        read(ENTRADA),
        string_lower(ENTRADA, ORACION),
        split_string(ORACION, " ", "", ListaOracion),
        oracion(TRADUCCION, ListaOracion),
        write(TRADUCCION).

traducir(IDIOMA):-
    IDIOMA = "ES", 
    write(" NO SE PUEDE TRADUCIR").

traducir(IDIOMA):-
    IDIOMA = "EN", 
    write(" CAN'T BE TRANSLATED").

traducir(IDIOMA):-
    write("Idioma no soportado / Language not supported").

concatenar([],X,X):- !.
concatenar([A|B],C,[A|D]):- concatenar(B,C,D).
concatenar(A,B,C,Z):-concatenar(A,B,X),concatenar(X,C,Z).
concatenar(A,B,C,D,Z):-concatenar(A,B,X),concatenar(X,C,Y),concatenar(Y,D,Z).


oracion(Z,ZZ):-  
    sintagmaNominal(X,XX), 
    sintagmaVerbal(Y,YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).


%El núcleo es un sustantivo o nombre. (El coche) verde
%Suele estar constituido: DETERMINANTE + NÚCLEO + COMPLEMENTOS
%Solo tiene un pronombre
%%Casos de sintagma nominal:
%solo un pronombre
sintagmaNominal(Z,ZZ):- pronombre(NUMERO, GENERO, PERSONA, Z,ZZ).

%%% un determinante y un adjetivo
sintagmaNominal(Z,ZZ):-  
    determinante(NUMERO, GENERO, PERSONA, X,XX),
    sintagmaAdjetivo(NUMERO, GENERO, S,SS),
    concatenar(X,S,Z), concatenar(XX,SS,ZZ).

%Casos de sintagma verbal
%Solamente verbo
sintagmaVerbal(Z,ZZ):- 
    verbo(NUMERO, TIEMPO, PERSONA, Z,ZZ).

%Verbo ser + adjetivo
sintagmaVerbal(Z,ZZ):- 
    ser(NUMERO, TIEMPO, PERSONA, X,XX),
    adjetivo(NUMERO, GENERO, M,MM),
    concatenar(X,M,Z),concatenar(XX,MM,ZZ).

%Verbo ser + sintagma nominal (ser algo)
sintagmaVerbal(Z,ZZ):- 
    ser(NUMERO, TIEMPO, PERSONA, X,XX),
    sintagmaNominal(Y,YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%Verbo estar + preposicion + sintagma nominal
%estar en un lugar
sintagmaVerbal(Z,ZZ):- 
    estar(NUMERO, TIEMPO, PERSONA, X,XX),
    preposicion(estar,Y,YY),
    sintagmaNominal(N,NN),
    concatenar(X,Y,N,Z),concatenar(XX,YY,NN,ZZ).

%Verbo + adjetivo
%El adjetivo va despues del verbo 
%correr rapido
sintagmaVerbal(Z,ZZ):- 
    verbo(NUMERO, TIEMPO, PERSONA, X,XX),
    adjetivo(NUMERO, GENERO, A,AA),
    concatenar(X,A,Z),concatenar(XX,AA,ZZ).

sintagmaVerbal(Z,ZZ):- 
    verbo(NUMERO, TIEMPO, PERSONA, X,XX), 
    sintagmaNominal(Y,YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%Sintagma verbal solo con verbo
sintagmaVerbal(X,XX):- 
    verbo(NUMERO, TIEMPO, PERSONA, X,XX).


%Une un adjetivo con un sustantivo
%se utiliza para dar adjetivos a sustantivos, estos adjetivos pueden estar 
%antes o despues del sustantivo, o pueden estar en ambas posiciones
sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    sustantivo(NUMERO, GENERO, Z,ZZ).

sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    adjetivo(NUMERO, GENERO, A1,AA1),
    sustantivo(NUMERO, GENERO, S,SS),
    concatenar(A1,S,Z),concatenar(AA1,SS,ZZ).

sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    sustantivo(NUMERO, GENERO, S,SS),
    adjetivo(NUMERO, GENERO, A2,AA2),
    concatenar(S,A2,Z),concatenar(AA2,SS,ZZ).

sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    adjetivo(NUMERO, GENERO, A1,AA1),
    sustantivo(NUMERO, GENERO, S,SS),
    adjetivo(NUMERO, GENERO, A2,AA2),
    concatenar(A1,S,A2,Z),concatenar(AA1,AA2,SS,ZZ).