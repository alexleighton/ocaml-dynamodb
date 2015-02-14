open OUnit2

(* AttributeDefinition *)

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

let test_attribute_definition_json _ =
  let attr_def = Types.attribute_definition "testAttributeName" Types.S in
  let json = Types.json_of_attribute_definition attr_def in
  assert_equal "{\"AttributeName\":\"testAttributeName\",\"AttributeType\":\"S\"}"
    (Yojson.Basic.to_string json)


(* KeySchemaElement *)

let test_key_schema_element _ =
  let key_schema = Types.key_schema_element "testAttributeName" Types.HASH in
  match key_schema with
    | Types.KeySchemaElement (name, _) -> assert_equal "testAttributeName" name

let test_key_schema_element_minimum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = Types.key_schema_element "" Types.RANGE in ())

let test_key_schema_element_maximum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = Types.key_schema_element (String.make 256 '_') Types.RANGE in ())

let test_key_schema_element_json _ =
  let key_schema = Types.key_schema_element "testAttributeName" Types.HASH in
  let json = Types.json_of_key_schema_element key_schema in
  assert_equal "{\"AttributeName\":\"testAttributeName\",\"KeyType\":\"HASH\"}"
    (Yojson.Basic.to_string json)


(* ProvisionedThroughput *)

let test_provisioned_throughput _ =
  let pt = Types.provisioned_throughput 10 5 in
  match pt with
    | Types.ProvisionedThroughput (read, write) ->
      assert_equal 10 read;
      assert_equal 5 write

let test_provisioned_throughput_minimum_read _ =
  assert_raises (Failure "Provisioned throughput must be a minimum of 1 unit.")
    (fun () -> let _ = Types.provisioned_throughput 0 1 in ())

let test_provisioned_throughput_minimum_write _ =
  assert_raises (Failure "Provisioned throughput must be a minimum of 1 unit.")
    (fun () -> let _ = Types.provisioned_throughput 1 0 in ())


(* Test Suite *)

let suite = "types_test" >::: [
  "test_attribute_definition"         >:: test_attribute_definition;
  "test_attribute_definition_minimum" >:: test_attribute_definition_minimum;
  "test_attribute_definition_maximum" >:: test_attribute_definition_maximum;
  "test_attribute_definition_json"    >:: test_attribute_definition_json;

  "test_key_schema_element"         >:: test_key_schema_element;
  "test_key_schema_element_minimum" >:: test_key_schema_element_minimum;
  "test_key_schema_element_maximum" >:: test_key_schema_element_maximum;
  "test_key_schema_element_json"    >:: test_key_schema_element_json;

  "test_provisioned_throughput"               >:: test_provisioned_throughput;
  "test_provisioned_throughput_minimum_read"  >:: test_provisioned_throughput_minimum_read;
  "test_provisioned_throughput_minimum_write" >:: test_provisioned_throughput_minimum_write;
]
