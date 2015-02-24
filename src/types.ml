(*
 * AttributeDefinition
 * http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeDefinition.html
 *)

type attribute_type = S | N | B

let string_of_attribute_type = function
  | S -> "S" | N -> "N" | B -> "B"

let attribute_name name =
  let length = String.length name in
  if length < 1 || length > 255
  then failwith "AttributeName length must be between 1 and 255 inclusive."
  else name

type attribute_definition = { name: string; t: attribute_type }

let attribute_definition name typ =
  let attr_name = attribute_name name in
  { name=attr_name; t=typ }

let json_of_attribute_definition attr_def =
  `Assoc ["AttributeName", `String attr_def.name;
          "AttributeType", `String (string_of_attribute_type attr_def.t)]


(*
 * KeySchemaElement
 * http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_KeySchemaElement.html
 *)

type key_type = HASH | RANGE

let string_of_key_type = function
  | HASH -> "HASH" | RANGE -> "RANGE"

type key_schema_element = { name: string; t: key_type }

let key_schema_element name typ =
  let attr_name = attribute_name name in
  { name=attr_name; t=typ }

let json_of_key_schema_element key_schema =
  `Assoc ["AttributeName", `String key_schema.name;
          "KeyType", `String (string_of_key_type key_schema.t)]


(*
 * ProvisionedThroughput
 * http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ProvisionedThroughput.html
 *)

type provisioned_throughput = { read_capacity: int; write_capacity: int }

let provisioned_throughput read write =
  if read < 1 || write < 1
  then failwith "Provisioned throughput must be a minimum of 1 unit."
  else
    { read_capacity=read; write_capacity=write }


let json_of_provisioned_throughput pt =
  `Assoc ["ReadCapacityUnits", `String (string_of_int pt.read_capacity);
          "WriteCapacityUnits", `String (string_of_int pt.write_capacity)]
