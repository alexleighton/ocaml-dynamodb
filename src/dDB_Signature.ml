module type Time =
sig
  val time: unit -> float
end

module UnixTime =
struct
  let time () = Unix.time ()
end

module AWSSignature (T: Time) =
struct
  let foo = T.time ()
end
