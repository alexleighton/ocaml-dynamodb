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

type attribute_definition = AttributeDefinition of string * attribute_type

let attribute_definition name typ =
  let attr_name = attribute_name name in
  AttributeDefinition (attr_name, typ)

let json_of_attribute_definition = function
  | AttributeDefinition (name, typ) ->
    `Assoc ["AttributeName", `String name;
            "AttributeType", `String (string_of_attribute_type typ)]


(*
 * KeySchemaElement
 * http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_KeySchemaElement.html
 *)

type key_type = HASH | RANGE

let string_of_key_type = function
  | HASH -> "HASH" | RANGE -> "RANGE"

type key_schema_element = KeySchemaElement of string * key_type

let key_schema_element name typ =
  let attr_name = attribute_name name in
  KeySchemaElement (attr_name, typ)

let json_of_key_schema_element = function
  | KeySchemaElement (name, typ) ->
    `Assoc ["AttributeName", `String name;
            "KeyType", `String (string_of_key_type typ)]


(*
 * ProvisionedThroughput
 * http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ProvisionedThroughput.html
 *)

type provisioned_throughput = ProvisionedThroughput of int * int

let provisioned_throughput read write =
  if read < 1 || write < 1
  then failwith "Provisioned throughput must be a minimum of 1 unit."
  else
    ProvisionedThroughput (read, write)
