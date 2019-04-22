// https://www.linux-nantes.org/~fmonnier/OCaml/ocaml-wrapping-c.html#ref_hello_world

#define _GNU_SOURCE

#include <stdlib.h>
#include <string.h>

#include <sodium.h>
#include <sodium/core.h>
#include <sodium/crypto_aead_xchacha20poly1305.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>

/* static struct custom_operations sodium_example = { */
/*   "sodium.example", */
/*   custom_finalize_default, */
/*   custom_compare_default, */
/*   custom_hash_default, */
/*   custom_serialize_default, */
/*   custom_deserialize_default, */
/*   custom_compare_ext_default */
/* }; */

value caml_crypto_aead_xchacha20poly1305_ietf_keygen(value unit) {
  CAMLparam1 ( unit );
  CAMLlocal1 ( key );

  const int s = crypto_aead_xchacha20poly1305_ietf_KEYBYTES;
  unsigned char * raw_data = NULL;

  key = caml_alloc_string ( s );
  raw_data = String_val ( key );

  memset( raw_data, 0, s );

  crypto_aead_xchacha20poly1305_ietf_keygen ( raw_data );
  CAMLreturn ( key );
}

value caml_random_buffer(value size) {
  CAMLparam1 ( size );
  CAMLlocal1 ( buffer );
  unsigned char * raw_data = NULL;

  int s = Int_val ( size );
  buffer = caml_alloc_string( s );
  raw_data = String_val( buffer );
  memset( raw_data, 0, s );
  randombytes_buf( raw_data, s );

  CAMLreturn ( buffer );
}

value caml_crypto_aead_xchacha20poly1305_ietf_encrypt(value message, value nonce, value pkey) {
  CAMLparam3 ( message, nonce, pkey );

  CAMLlocal1 ( ciphertext );

  unsigned long long ciphertext_len;

  size_t additional_data_len = 0;
  const unsigned char *additional_data = NULL;

  size_t message_len = caml_string_length(message);
  unsigned char * message_raw = String_val(message);

  // const size_t nonce_len = caml_string_length(nonce);
  unsigned char * nonce_raw = String_val(nonce);

  // const size_t pkey_len = caml_string_length(pkey);
  unsigned char * pkey_raw = String_val(pkey);

  unsigned char * ciphertext_raw = NULL;

  size_t size_ciphertext = message_len + crypto_aead_xchacha20poly1305_ietf_ABYTES;


  ciphertext = caml_alloc_string( size_ciphertext );
  ciphertext_raw = String_val( ciphertext );
  memset( ciphertext_raw, 0, size_ciphertext );

  crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext_raw, &ciphertext_len,
					     message_raw, message_len,
					     additional_data, additional_data_len,
					     NULL, nonce_raw, pkey_raw);


  CAMLreturn ( ciphertext  );
}

value caml_crypto_aead_xchacha20poly1305_ietf_decrypt(value ciphertext, value nonce, value pkey) {
  unsigned long long decrypted_len;
  size_t additional_data_len = 0;
  const unsigned char *additional_data = NULL;
  CAMLparam3 ( ciphertext, nonce, pkey );
  CAMLlocal2 ( message, message_end );

  const size_t ciphertext_len = caml_string_length(ciphertext);
  unsigned char * ciphertext_raw = String_val(ciphertext);

  // const size_t nonce_len = caml_string_length(nonce);
  unsigned char * nonce_raw = String_val(nonce);

  // const size_t pkey_len = caml_string_length(pkey);
  unsigned char * pkey_raw = String_val(pkey);

  const unsigned int message_size = 1025;
  unsigned char * message_raw = NULL;
  message = caml_alloc_string( message_size );
  message_raw = String_val( message );
  memset( message_raw, 0, message_size );

  if (crypto_aead_xchacha20poly1305_ietf_decrypt(message_raw, &decrypted_len,
						 NULL,
						 ciphertext_raw, ciphertext_len,
						 additional_data,
						 additional_data_len,
						 nonce_raw, pkey_raw) != 0) {
    /* message forged! */
    printf("Error\n");
  } else {
    printf("Success\n");
  }

  const unsigned int message_l = strnlen(message_raw, message_size);
  message_end = caml_alloc_string( message_l );
  unsigned char * message_end_raw = String_val( message_end );
  memset( message_end_raw, 0, message_l );
  strncpy(message_end_raw, message_raw, message_l);

  CAMLreturn ( message_end );
}
