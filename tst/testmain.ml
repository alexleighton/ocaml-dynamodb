open OUnit2

let test1 test_ctxt = assert_equal 2 2

let suite = "suite" >::: ["test1" >:: test1]

let _ =
  run_test_tt_main suite
