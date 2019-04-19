(*
#require "sodium.cmxa";;

let open Sodium in
let a = Sodium.example 1 in
print_int a;;
*)

let () =
  let open Sodium in
  let a = Sodium.example 3 in
  print_int a;
  print_endline("hello world")


