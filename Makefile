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
# ocamlfind ocamlopt -verbose sodium.ml sodium_stubs.c main.ml -o prog1 -cclib '-lsodium -Wall'
#
# ocamlfind ocamlopt -verbose -a -verbose -linkall -fPIC  sodium.ml sodium_stubs.c -o sodium.cmxa -cclib '-lsodium ' -ccopt '-lsodium '
#
# ocamlmklib -verbose sodium.o -o sodium
# ocamlfind ocamlopt -a -verbose -fPIC sodium.ml sodium_stubs.c main.ml -cclib '-lsodium -Wall' -o sodium
#	ocamlfind -ccopt '--std=c99 -Wall -pedantic -Werror -Wno-pointer-sign' -c lib/sodium_stubs.c
#
#	ocamlfind ocamlopt -a -verbose -fPIC sodium.ml sodium_stubs.c -cclib '-lsodium -Wall' -ccopt -static -o sodium
#	ocamlmklib -verbose sodium.a -o sodium
#	ocamlfind ocamlopt -a -verbose -fPIC sodium_stubs.c -cclib '-lsodium -Wall --std=c99 -pedantic -Werror -Wno-pointer-sign' -ccopt '-static' -o sodium.cmx



.PHONY: all clean

all:
	dune build @all


clean:
	dune clean
	rm -vf *.cmi *.cmo *.o *.a *.cmx *.out *.cmxa *.so *.s test dune-project ./.merlin
	rm -rfv ./_build/
