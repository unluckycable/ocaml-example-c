# http://komar.in/en/howto_link_c_lib_statically_with_ocaml_app
# ocamlc -custom -output-obj -o modcaml.o mod.ml
# ocamlc -c modwrap.c
# cp $(LIBP)/libcamlrun.a mod.a && chmod +w mod.a
# ar r mod.a modcaml.o modwrap.o
# gcc -o prog -I $(LIBP) main.c mod.a -lm -ldl
# ocamlmklib -verbose sodium.o
# ocamlfind ocamlopt -verbose -a -verbose -linkall -fPIC -cclib "-lsodium" -ccopt "-lsodium" sodium.ml sodium_stubs.c -o sodium.cmxa
# ocamlmklib -verbose sodium.o -o sodium
# ocamlfind ocamlopt -verbose -a -cclib -lsodium  sodium.ml -o sodium.cmxa
# ocamlfind ocamlopt -verbose -fPIC -ccopt "-lsodium" sodium.ml sodium_stubs.c main.ml -o prog1

#	ocamlfind ocamlopt -verbose sodium.ml sodium_stubs.c main.ml -o prog1 -cclib '-lsodium -Wall'

#	ocamlfind ocamlopt -verbose -a -verbose -linkall -fPIC  sodium.ml sodium_stubs.c -o sodium.cmxa -cclib '-lsodium ' -ccopt '-lsodium '
#	ocamlmklib -verbose sodium.o -o sodium


.PHONY: all clean

LIBP=$(shell ocamlc -where)


all:
	ocamlfind ocamlopt -verbose -fPIC sodium.ml sodium_stubs.c main.ml -o prog1 -cclib '-lsodium -Wall'
	./prog1

clean:
	rm -vf *.cmi *.cmo *.o *.a *.cmx *.out *.cmxa *.so *.s prog prog1
