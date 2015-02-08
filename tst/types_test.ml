open OUnit2

let test_attribute_definition _ =
  let attr_def = Types.attribute_definition "testAttributeName" Types.S in
  match attr_def with
    | Types.AttributeDefinition (name, _) -> assert_equal "testAttributeName" name

let test_attribute_definition_minimum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = Types.attribute_definition "" Types.S in ())

let test_attribute_definition_maximum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = Types.attribute_definition (String.make 256 '_') Types.S in ())

let suite = "types_test" >::: [
  "test_attribute_definition" >:: test_attribute_definition;
  "test_attribute_definition_minimum" >:: test_attribute_definition_minimum;
  "test_attribute_definition_maximum" >:: test_attribute_definition_maximum
]
