# ocamlc -custom -output-obj -o modcaml.o mod.ml
# ocamlc -c modwrap.c
# cp $(LIBP)/libcamlrun.a mod.a && chmod +w mod.a
# ar r mod.a modcaml.o modwrap.o
# gcc -o prog -I $(LIBP) main.c mod.a -lm -ldl


.PHONY: all clean

LIBP=$(shell ocamlc -where)


all:
	ocamlopt -verbose -fPIC  mod.ml modwrap.c main.c -o prog

clean:
	rm -vf *.cmi *.cmo *.o *.a *.cmx prog