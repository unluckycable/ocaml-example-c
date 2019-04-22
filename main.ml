
let () =
  let open Sodium in
  let message = "Hello World" in
  print_endline ("message: " ^ message);
  let pkey = Sodium.crypto_aead_xchacha20poly1305_ietf_keygen () in
  print_endline("pkey: " ^ pkey);
  let nonce = Sodium.random_buffer 24 in
  print_endline("nonce: " ^ nonce);
  let ciphertext = Sodium.crypto_aead_xchacha20poly1305_ietf_encrypt message nonce pkey in
  print_endline("ciphertext: " ^ ciphertext);
  let decrypted = Sodium.crypto_aead_xchacha20poly1305_ietf_decrypt ciphertext nonce pkey in
  print_endline ("decrypted: " ^ decrypted);
  print_endline (message);
  print_endline (decrypted);
  assert (String.equal message decrypted);
  assert ((String.length message) == (String.length decrypted));
