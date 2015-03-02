module Types = DDB_Types

module AWSSignature = DDB_Signature.AWSSignature(DDB_Signature.UnixTime)

let create_table () =
  let open Lwt in
  let uri = Uri.of_string "http://localhost:8000" in
  Cohttp_lwt_unix.Client.get uri >>= fun (resp, body) ->
  Cohttp_lwt_body.to_string body >>= fun b ->
  Lwt_io.printl b

(* let _ = *)
(*   Lwt_main.run (create_table ()) *)
