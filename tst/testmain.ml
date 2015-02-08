open OUnit2

let suite = "main_suite" >::: [
  Types_test.suite
]

let _ =
  run_test_tt_main suite
