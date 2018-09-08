open OUnit2

let int_tcase expected actual =
  (fun _ -> assert_equal expected actual ~printer:string_of_int)

let string_of_int_option = function
  | None -> "None"
  | Some x -> "Some " ^ string_of_int x

let int_option_tcase expected actual =
  (fun _ -> assert_equal expected actual ~printer:string_of_int_option)

let tests = "test suite for sum" >::: [
    "fact_0" >:: int_tcase 1 @@ Math.fact 1;
    "fact_1" >:: int_tcase 120 @@ Math.fact 5;
    "gcd_0"  >:: int_tcase 1 @@ Math.gcd 1 10;
    "gcd_1"  >:: int_tcase 4 @@ Math.gcd 124 56;
  ] @ [
    "list_max empty" >:: int_option_tcase None @@ Math.list_max [];
    "list_max nonempty" >:: int_option_tcase (Some 5) @@ Math.list_max [1; 5; 4; -3];
  ]

let _ = run_test_tt_main tests
