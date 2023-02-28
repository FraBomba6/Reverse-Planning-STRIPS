%---------------------------------------
% domain
%---------------------------------------

% utils
boolean(true).
boolean(false).

% types
type(type("truck")).
inherits(type("truck"), type("object")).
type(type("furniture")).
inherits(type("furniture"), type("object")).
type(type("object")).

has(X, type(T2)) :- has(X, type(T1)), inherits(type(T1), type(T2)).

% variables
variable(variable(("assembled", X1))) :- has(X1, type("furniture")).
variable(variable(("packed", X1))) :- has(X1, type("furniture")).
variable(variable(("loaded", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
variable(variable(("moved", X1))) :- has(X1, type("furniture")).

contains(X, value(X, B)) :- variable(X), boolean(B).

% actions
action(action(("assemble_furniture", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("assemble_furniture", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("assemble_furniture", X1, X2))).
precondition(action(("assemble_furniture", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), false)) :- action(action(("assemble_furniture", X1, X2))).
precondition(action(("assemble_furniture", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), false)) :- action(action(("assemble_furniture", X1, X2))).
precondition(action(("assemble_furniture", X1, X2)), variable(("moved", X1)), value(variable(("moved", X1)), true)) :- action(action(("assemble_furniture", X1, X2))).
postcondition(action(("assemble_furniture", X1, X2)), effect(unconditional), variable(("assembled", X1)), value(variable(("assembled", X1)), true)) :- action(action(("assemble_furniture", X1, X2))).

action(action(("disassemble_furniture", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("disassemble_furniture", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), true)) :- action(action(("disassemble_furniture", X1, X2))).
precondition(action(("disassemble_furniture", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), false)) :- action(action(("disassemble_furniture", X1, X2))).
precondition(action(("disassemble_furniture", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), false)) :- action(action(("disassemble_furniture", X1, X2))).
postcondition(action(("disassemble_furniture", X1, X2)), effect(unconditional), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("disassemble_furniture", X1, X2))).
postcondition(action(("disassemble_furniture", X1, X2)), effect(unconditional), variable(("moved", X1)), value(variable(("moved", X1)), false)) :- action(action(("disassemble_furniture", X1, X2))).

action(action(("pack", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("pack", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), false)) :- action(action(("pack", X1, X2))).
precondition(action(("pack", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("pack", X1, X2))).
precondition(action(("pack", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), false)) :- action(action(("pack", X1, X2))).
precondition(action(("pack", X1, X2)), variable(("moved", X1)), value(variable(("moved", X1)), false)) :- action(action(("pack", X1, X2))).
postcondition(action(("pack", X1, X2)), effect(unconditional), variable(("packed", X1)), value(variable(("packed", X1)), true)) :- action(action(("pack", X1, X2))).

action(action(("unpack", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("unpack", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), true)) :- action(action(("unpack", X1, X2))).
precondition(action(("unpack", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("unpack", X1, X2))).
precondition(action(("unpack", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), false)) :- action(action(("unpack", X1, X2))).
precondition(action(("unpack", X1, X2)), variable(("moved", X1)), value(variable(("moved", X1)), true)) :- action(action(("unpack", X1, X2))).
postcondition(action(("unpack", X1, X2)), effect(unconditional), variable(("packed", X1)), value(variable(("packed", X1)), false)) :- action(action(("unpack", X1, X2))).

action(action(("load_truck", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("load_truck", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), true)) :- action(action(("load_truck", X1, X2))).
precondition(action(("load_truck", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("load_truck", X1, X2))).
precondition(action(("load_truck", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), false)) :- action(action(("load_truck", X1, X2))).
precondition(action(("load_truck", X1, X2)), variable(("moved", X1)), value(variable(("moved", X1)), false)) :- action(action(("load_truck", X1, X2))).
postcondition(action(("load_truck", X1, X2)), effect(unconditional), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), true)) :- action(action(("load_truck", X1, X2))).

action(action(("unload_truck", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("unload_truck", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), true)) :- action(action(("unload_truck", X1, X2))).
precondition(action(("unload_truck", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("unload_truck", X1, X2))).
precondition(action(("unload_truck", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), true)) :- action(action(("unload_truck", X1, X2))).
precondition(action(("unload_truck", X1, X2)), variable(("moved", X1)), value(variable(("moved", X1)), true)) :- action(action(("unload_truck", X1, X2))).
postcondition(action(("unload_truck", X1, X2)), effect(unconditional), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), false)) :- action(action(("unload_truck", X1, X2))).

action(action(("move", X1, X2))) :- has(X1, type("furniture")), has(X2, type("truck")).
precondition(action(("move", X1, X2)), variable(("packed", X1)), value(variable(("packed", X1)), true)) :- action(action(("move", X1, X2))).
precondition(action(("move", X1, X2)), variable(("assembled", X1)), value(variable(("assembled", X1)), false)) :- action(action(("move", X1, X2))).
precondition(action(("move", X1, X2)), variable(("loaded", X1, X2)), value(variable(("loaded", X1, X2)), true)) :- action(action(("move", X1, X2))).
precondition(action(("move", X1, X2)), variable(("moved", X1)), value(variable(("moved", X1)), false)) :- action(action(("move", X1, X2))).
postcondition(action(("move", X1, X2)), effect(unconditional), variable(("moved", X1)), value(variable(("moved", X1)), true)) :- action(action(("move", X1, X2))).

%---------------------------------------
% problem
%---------------------------------------

% objects
constant(constant("couch")).
has(constant("couch"), type("furniture")).

constant(constant("truck")).
has(constant("truck"), type("truck")).

% initial state
initialState(variable(("assembled", constant("couch"))), value(variable(("assembled", constant("couch"))), true)).

initialState(X, value(X, false)) :- variable(X), not initialState(X, value(X, true)).

% goal
goal(variable(("assembled", constant("couch"))), value(variable(("assembled", constant("couch"))), true)).
goal(variable(("moved", constant("couch"))), value(variable(("moved", constant("couch"))), true)).
#show chosen/1.
