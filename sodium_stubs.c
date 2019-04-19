#include <sodium/core.h>
#include <sodium/crypto_aead_xchacha20poly1305.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>


/* Encapsulation of opaque window handles (of type WINDOW *)
   as OCaml custom blocks. */

static struct custom_operations sodium_example = {
  "sodium.example",
  custom_finalize_default,
  custom_compare_default,
  custom_hash_default,
  custom_serialize_default,
  custom_deserialize_default,
  custom_compare_ext_default
};

value caml_example(value number)
{
  CAMLparam1(number);
  CAMLreturn(number);
}
