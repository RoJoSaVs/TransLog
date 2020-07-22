%%preposiciones utilizadas para lugares
preposicion(de, ["de"], ["of"]).
preposicion(estar, ["en"], ["in"]).


pronombre(singular, masculino, primera, ["yo"], ["i"]).
pronombre(singular, masculino, tercera, ["eel"], ["he"]).

determinante(singular, masculino, tercera, ["un"], ["a"]).
determinante(singular, masculino, tercera, ["un"], ["an"]).
determinante(singular, femenino, tercera, ["una"], ["a"]).
determinante(singular, femenino, tercera, ["una"], ["an"]).
determinante(singular, masculino, tercera, ["el"], ["the"]).
determinante(singular, femenino, tercera, ["la"], ["the"]).
determinante(plural, masculino, tercera, ["los"], ["the"]).
determinante(plural, femenino, tercera, ["las"], ["the"]).


adjetivo(singular, masculino, ["grande"], ["big"]).
adjetivo(singular, femenino, ["grande"], ["big"]).
adjetivo(singular, masculino, ["rojo"], ["red"]).
adjetivo(singular, femenino, ["roja"], ["red"]).
adjetivo(singular, masculino, ["gran"], ["big"]).
adjetivo(singular, femenino, ["gran"], ["big"]).


sustantivo(singular, femenino, ["playa"], ["beach"]).
sustantivo(singular, femenino, ["vida"], ["life"]).
sustantivo(singular, masculino, ["uno"], ["one"]).
sustantivo(singular, masculino, ["hombre"], ["man"]).
sustantivo(singular, femenino, ["naranja"], ["orange"]).
sustantivo(singular, masculino, ["perro"], ["dog"]).
sustantivo(singular, femenino, ["perra"], ["dog"]).
sustantivo(singular, masculino, ["carro"], ["car"]).



verbo(singular, presente, primera, ["como"], ["eat"]).
verbo(singular, pret_perf, primera, ["comi"], ["ate"]).
verbo(singular, pret_perf, primera, ["comere"], ["will", "eat"]).
verbo(singular, presente, tercera, ["come"], ["eats"]).
verbo(singular, pret_perf, tercera, ["comio"], ["ate"]).
verbo(singular, pret_perf, tercera, ["comera"], ["will","eat"]).


ser(singular, presente, tercera, ["es"], ["is"]).
ser(singular, presente, primera, ["soy"], ["am"]).
estar(singular, presente, primera, ["estoy"], ["am"]).
estar(singular, presente, tercera, ["esta"], ["is"]).

excepcion(["que","edad", "tienes"],["how", "old", "are", "you"]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pregunta(["quien"], ["who"]).
pregunta(["que"], ["what"]).
pregunta(["cual"], ["which"]).
pregunta(["cuando"], ["when"]).
pregunta(["por", "que"], ["why"]).
pregunta(["donde"], ["where"]).
pregunta(["como"], ["how"]).
pregunta(["cuantos"], ["how", "much"]).
pregunta(["cuantos"], ["how", "many"]).
pregunta(["con", "que", "frecuencia"], ["how","often"]).
