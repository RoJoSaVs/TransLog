%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         BASE DE DATOS PRONOMBRES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pronombre(singular,primera,["yo"], ["I"]):- !.
pronombre(singular,segunda,["t�"], ["you"]).
pronombre(singular,tercera,["�l"], ["he"]):- !.
pronombre(singular,tercera,["ella"], ["she"]):- !.
pronombre(singular,tercera,["ello"], ["it"]):- !.
pronombre(plural,primera,["nosotros"], ["we"]):- !.
pronombre(plural,segunda,["vosotros"], ["you"]):- !.
pronombre(plural,tercera,["ellos"], ["they"]).
pronombre(plural,tercera,["ellas"], ["they"]):- !.