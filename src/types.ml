(*
 * Attribute Definition
 * http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeDefinition.html
 *)

type attribute_type = S | N | B

let attribute_name name =
  let length = String.length name in
  if length < 1 || length > 255
  then failwith "AttributeName length must be between 1 and 255 inclusive."
  else name

type attribute_definition = AttributeDefinition of string * attribute_type

let attribute_definition name typ =
  let attr_name = attribute_name name in
  AttributeDefinition (attr_name, typ)
