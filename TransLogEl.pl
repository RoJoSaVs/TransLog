/*
LENGUAJES COMPILADORES E INTERPRETES
GRUPO 01
PREOYECTO TRANSLOG 
*/
%Archivos importados que contienen la base de datos
:- include(database).
%:- include(datosAdjetivos).
%:- include(datosSustantivos).
%:- include(datosVerbos).
:- include(datosPronombres).

%Funcion principal, es la funcion que se llama para ejecutar el programa
%Solicita el idioma en que se va a hacer la traduccion 
%"ES" Español -> Ingles
%"EN" Ingles -> Español
transLog:-
    write("Ingrese el idioma a traducir / Type the language to translate"), nl,
    read(IDIOMA), 
    traducir(IDIOMA), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Si el idioma ingresado es "ES" solucita al usuario que escriba 
%la oracion en español para hacer la traduccion al ingles
%Divide la oracion ingresada en una lista en la que los elementos 
%son las palabras de la oracion
traducir(IDIOMA):- 
    IDIOMA = "ES",
        write("Escriba el texto para traducir"), nl,
        read(ENTRADA),
        string_lower(ENTRADA, ORACION),
        split_string(ORACION, " ", "", ListaOracion),
        oracion(ListaOracion, TRADUCCION),
        atomic_list_concat(TRADUCCION,' ',TRADUCCION_STRING),
        write(TRADUCCION_STRING).

%Si el idioma ingresado es "EN" solucita al usuario que escriba 
%la oracion en ingles para hacer la traduccion al español
%Divide la oracion ingresada en una lista en la que los elementos 
%son las palabras de la oracion
traducir(IDIOMA):- 
    IDIOMA = "EN",
        write("Type text to translate "),
        nl,
        read(ENTRADA),
        string_lower(ENTRADA, ORACION),
        split_string(ORACION, " ", "", ListaOracion),
        oracion(TRADUCCION, ListaOracion),
        atomic_list_concat(TRADUCCION,' ',TRADUCCION_STRING),
        write(TRADUCCION_STRING).

%En caso de no poder traducir la oracion de ESPAÑOL a INGLES retorna un mensaje de error 
traducir(IDIOMA):-
    IDIOMA = "ES", 
    write(" NO SE PUEDE TRADUCIR").

%En caso de no poder traducir la oracion de INGLES a ESPAÑOL retorna un mensaje de error 
traducir(IDIOMA):-
    IDIOMA = "EN", 
    write(" CAN'T BE TRANSLATED").

%Si cuando se solicita el idioma no es "ES" o "EN" retrona un mensaje de error
%sobre el idioma seleccionado
traducir(IDIOMA):-
    write("Idioma no soportado / Language not supported").


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Funcion que une los elementos que entran en una lista
%Recibe dos listas y coloca la primera lista que recibe al principio
%y la segunda lista la coloca al final
concatenar([],X,X):- !.
concatenar([A|B],C,[A|D]):- concatenar(B,C,D).
concatenar(A,B,C,Z):-concatenar(A,B,X),concatenar(X,C,Z).
concatenar(A,B,C,D,Z):-concatenar(A,B,X),concatenar(X,C,Y),concatenar(Y,D,Z).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Funcion que se encarga de establecer la estructura que debe tener la oracion para
%que se traduzca, primero debe tener el sintagma nominal y luego el verbal
%Cuando encuentra las traducciones necesarias llama a la funcion de concatenar 
%para mostrar la traduccion
oracion(Z,ZZ):-  
    sintagmaNominal(X,XX), 
    sintagmaVerbal(Y,YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%Esta estructura de oracion se encarga de manejar algunas preguntas presentes en ambos 
%idiomas y que tienen traduccion directa del ESPAÑOL al INGLES y viceversa 
oracion(Z, ZZ):-
    incognita(X, XX),
    sintagmaVerbal(Y, YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%En caso de que la oracion no cumpla con la estructura propuesta, busca en los hechos que se 
%pueden tomar como excepciones y si encuentra una coincidencia retorna la traduccion
oracion(Z, ZZ):-
    excepcion(Z, ZZ),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%Se encarga de buscar en los hechos las palabras que se utilizan para hacer preguntas
incognita(Z, ZZ):- pregunta(Z, ZZ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%El núcleo es un sustantivo o nombre. (El coche) verde
%Suele estar constituido: DETERMINANTE + NÚCLEO + COMPLEMENTOS
%Casos de SINTAGMA NOMINAL:

%Solo tiene un pronombre
sintagmaNominal(Z,ZZ):- pronombre(NUMERO, GENERO, PERSONA, Z,ZZ).

%Posee un determinante y un adjetivo
sintagmaNominal(Z,ZZ):-  
    determinante(NUMERO, GENERO, PERSONA, X,XX),
    sintagmaAdjetivo(NUMERO, GENERO, S,SS),
    concatenar(X,S,Z), concatenar(XX,SS,ZZ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%El núcleo es un verbo. (Cené) una pizza
%Está constituido por un verbo y sus complementos: atributo, directo, 
%indirecto, circunstancial, de régimen, predicativo y agente.
%Para efectos del proyecto no se consideraron todos los complementos 
%Casos de sintagma verbal

%Solamente verbo
sintagmaVerbal(Z,ZZ):- 
    verbo(NUMERO, TIEMPO, PERSONA, Z,ZZ).

%Verbo ser y un adjetivo
sintagmaVerbal(Z,ZZ):- 
    ser(NUMERO, TIEMPO, PERSONA, X,XX),
    adjetivo(NUMERO, GENERO, M,MM),
    concatenar(X,M,Z),concatenar(XX,MM,ZZ).

%Verbo ser y sintagma nominal (ser algo)
sintagmaVerbal(Z,ZZ):- 
    ser(NUMERO, TIEMPO, PERSONA, X,XX),
    sintagmaNominal(Y,YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%Verbo estar + preposicion + sintagma nominal
sintagmaVerbal(Z,ZZ):- 
    estar(NUMERO, TIEMPO, PERSONA, X,XX),
    preposicion(estar,Y,YY),
    sintagmaNominal(N,NN),
    concatenar(X,Y,N,Z),concatenar(XX,YY,NN,ZZ).

%Verbo y un adjetivo
sintagmaVerbal(Z,ZZ):- 
    verbo(NUMERO, TIEMPO, PERSONA, X,XX),
    adjetivo(NUMERO, GENERO, A,AA),
    concatenar(X,A,Z),concatenar(XX,AA,ZZ).

%Verbo y sintagma nominal
sintagmaVerbal(Z,ZZ):- 
    verbo(NUMERO, TIEMPO, PERSONA, X,XX), 
    sintagmaNominal(Y,YY),
    concatenar(X,Y,Z),concatenar(XX,YY,ZZ).

%Sintagma verbal solo con verbo
sintagmaVerbal(X,XX):- 
    verbo(NUMERO, TIEMPO, PERSONA, X,XX).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%El núcleo es un adjetivo. Es muy (orgulloso)
%se utiliza para dar adjetivos a sustantivos, estos adjetivos pueden estar 
%antes o despues del sustantivo, o pueden estar en ambas posiciones

%Cuando un sustantivo completa la oracion en lugar de un adjetivo
%Casos en que hay un complemento indirecto
sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    sustantivo(NUMERO, GENERO, Z,ZZ).

%Une un adjetivo con un sustantivo
%Se usa mayoritariamente en INGLES
%Ejemplo: The (red car)
sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    adjetivo(NUMERO, GENERO, A1,AA1),
    sustantivo(NUMERO, GENERO, S,SS),
    concatenar(A1,S,Z),concatenar(AA1,SS,ZZ).

%Une un sustantivo con un adjetivo
%Ejemplo: Perro malo
sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    sustantivo(NUMERO, GENERO, S,SS),
    adjetivo(NUMERO, GENERO, A2,AA2),
    concatenar(S,A2,Z),concatenar(AA2,SS,ZZ).

%Casos en los que hay adjetivo, sustantivo y adjetivo otra vez en la misma oracion
%Ejemplo: La (gran playa azul) 
sintagmaAdjetivo(NUMERO, GENERO, Z,ZZ):- 
    adjetivo(NUMERO, GENERO, A1,AA1),
    sustantivo(NUMERO, GENERO, S,SS),
    adjetivo(NUMERO, GENERO, A2,AA2),
    concatenar(A1,S,A2,Z),concatenar(AA1,AA2,SS,ZZ).