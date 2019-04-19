# ocamlc -custom -output-obj -o modcaml.o mod.ml
# ocamlc -c modwrap.c
# cp $(LIBP)/libcamlrun.a mod.a && chmod +w mod.a
# ar r mod.a modcaml.o modwrap.o
# gcc -o prog -I $(LIBP) main.c mod.a -lm -ldl


.PHONY: all clean

LIBP=$(shell ocamlc -where)


all:
	ocamlopt -a -verbose -fPIC -ccopt "-lsodium" sodium.ml sodium_stubs.c -o sodium.cmxa
	ocamlopt -verbose -fPIC sodium.ml sodium_stubs.c main.ml -o prog1
	./prog1

clean:
	rm -vf *.cmi *.cmo *.o *.a *.cmx *.out *.cmxa prog prog1
