open OUnit2
open DDB_Types

module T = DDB_Types

(* AttributeDefinition *)

let test_attribute_definition _ =
  let attr_def = T.attribute_definition "testAttributeName" T.S in
  assert_equal "testAttributeName" attr_def.name;
  assert_equal T.S attr_def.t

let test_attribute_definition_minimum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = T.attribute_definition "" T.S in ())

let test_attribute_definition_maximum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = T.attribute_definition (String.make 256 '_') T.S in ())

let test_attribute_definition_json _ =
  let attr_def = T.attribute_definition "testAttributeName" T.S in
  let json = T.json_of_attribute_definition attr_def in
  assert_equal "{\"AttributeName\":\"testAttributeName\",\"AttributeType\":\"S\"}"
    (Yojson.Basic.to_string json)


(* KeySchemaElement *)

let test_key_schema_element _ =
  let key_schema = T.key_schema_element "testAttributeName" T.HASH in
  assert_equal "testAttributeName" key_schema.name;
  assert_equal T.HASH key_schema.t

let test_key_schema_element_minimum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = T.key_schema_element "" T.RANGE in ())

let test_key_schema_element_maximum _ =
  assert_raises (Failure "AttributeName length must be between 1 and 255 inclusive.")
    (fun () -> let _ = T.key_schema_element (String.make 256 '_') T.RANGE in ())

let test_key_schema_element_json _ =
  let key_schema = T.key_schema_element "testAttributeName" T.HASH in
  let json = T.json_of_key_schema_element key_schema in
  assert_equal "{\"AttributeName\":\"testAttributeName\",\"KeyType\":\"HASH\"}"
    (Yojson.Basic.to_string json)


(* ProvisionedThroughput *)

let test_provisioned_throughput _ =
  let pt = T.provisioned_throughput 10 5 in
  assert_equal 10 pt.read_capacity;
  assert_equal 5 pt.write_capacity

let test_provisioned_throughput_minimum_read _ =
  assert_raises (Failure "Provisioned throughput must be a minimum of 1 unit.")
    (fun () -> let _ = T.provisioned_throughput 0 1 in ())

let test_provisioned_throughput_minimum_write _ =
  assert_raises (Failure "Provisioned throughput must be a minimum of 1 unit.")
    (fun () -> let _ = T.provisioned_throughput 1 0 in ())

let test_provisioned_throughput_json _ =
  let pt = T.provisioned_throughput 10 5 in
  let json = T.json_of_provisioned_throughput pt in
  assert_equal "{\"ReadCapacityUnits\":\"10\",\"WriteCapacityUnits\":\"5\"}"
    (Yojson.Basic.to_string json)


(* Projection *)

let test_projection _ =
  let nka = ["Foo"; "Bar"] in
  let proj = T.projection nka ~projection_type:(Some ALL) in
  (match proj.projection_type with
    | Some ALL -> ()
    | _ -> assert_failure "Expected Some ALL for projection_type.");
  (match proj.non_key_attributes with
    | Some ["Foo"; "Bar"] -> ()
    | _ -> assert_failure "Expected [\"Foo\"; \"Bar\"] for non_key_attributes.")

let test_projection_maximum_attrs _ =
  let nka_21 = Array.to_list (Array.make 21 "Attr") in
  assert_raises (Failure "NonKeyAttributes must be between 1 and 20 elements.")
    (fun () -> ignore (T.projection nka_21 ~projection_type:None))

let test_projection_json _ =
  let proj = T.projection ["Foo"; "Bar"] ~projection_type:(Some INCLUDE) in
  let json = T.json_of_projection proj in
  assert_equal "{\"NonKeyAttributes\":[\"Foo\",\"Bar\"],\"ProjectionType\":\"INCLUDE\"}"
    (Yojson.Basic.to_string json)


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
  "test_provisioned_throughput_json"          >:: test_provisioned_throughput_json;

  "test_projection"               >:: test_projection;
  "test_projection_maximum_attrs" >:: test_projection_maximum_attrs;
  "test_projection_json"          >:: test_projection_json;
]
