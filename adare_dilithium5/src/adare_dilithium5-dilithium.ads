
with Interfaces.C;
use Interfaces.C;

package adare_dilithium5.dilithium with Pure is

  pragma  Assertion_Policy (Check);

  dilithium5_private_key_length : constant Interfaces.C.size_t;
  dilithium5_public_key_length  : constant Interfaces.C.size_t;
  dilithium5_signature_length   : constant Interfaces.C.size_t;

  type dilithium5_private_key is private
    with Preelaborable_Initialization;

  type dilithium5_public_key  is private
    with Preelaborable_Initialization;

  type dilithium5_signature   is private
    with Preelaborable_Initialization;

  function  get_dilithium5_private_key  (from_key : aliased dilithium5_private_key) return Interfaces.C.char_array;
  function  get_dilithium5_public_key   (from_key : aliased dilithium5_public_key)  return Interfaces.C.char_array;
  function  get_dilithium5_signature    (from_ciphertext  : aliased dilithium5_signature) return Interfaces.C.char_array;

  procedure set_dilithium5_private_key
    (to_key :   out dilithium5_private_key;
     from   :   aliased in  Interfaces.C.char_array)
     with Pre    => from'Length = dilithium5_private_key_length;

  procedure set_dilithium5_public_key
    (to_key :   out dilithium5_public_key;
     from   :   aliased in  Interfaces.C.char_array)
     with Pre    => from'Length = dilithium5_public_key_length;

  procedure set_dilithium5_signature
    (to_sign  : out dilithium5_signature;
     from     : aliased in  Interfaces.C.char_array)
     with Pre    => from'Length = dilithium5_signature_length;


  procedure dilithium5_keypair
    (public_key   : out dilithium5_public_key;
     private_key  : out dilithium5_private_key);


  procedure dilithium5_sign -- create a signature only part. a PQClean Bonus (Thanks)!
    (signature      :   out dilithium5_signature; -- create a sign only :-)
     data_to_sign   :   aliased in Interfaces.C.char_array;
     private_key    :   aliased in dilithium5_private_key)
     with Pre => data_to_sign'Length > 1;

  function dilithium5_verify
    (signature      :   aliased in dilithium5_signature; -- verify a sign only. a PQClean Bonus (Thanks)!
      data_to_verify :   aliased in Interfaces.C.char_array;
      public_key     :   aliased in dilithium5_public_key
    ) return Boolean
    with Pre => data_to_verify'Length > 1;


  -- return if ok => create and return a combination of signature and message
  -- otherwise return a zero length char_array
  function dilithium5_sign_message
    (data_to_sign   :   aliased in Interfaces.C.char_array;
     private_key    :   aliased in dilithium5_private_key) return Interfaces.C.char_array
    with Pre => data_to_sign'Length > 1;

  -- return if ok => create and return the original message
  -- otherwise return a zero length char_array.
  function dilithium5_verify_open
    (signature_and_message      :   aliased in Interfaces.C.char_array;
     public_key     :   aliased in dilithium5_public_key
    ) return Interfaces.C.char_array
    with Pre => signature_and_message'Length > dilithium5_signature_length + 1;


private

  dilithium5_private_key_length  :   constant Interfaces.C.size_t   :=  4896;
  dilithium5_public_key_length   :   constant Interfaces.C.size_t   :=  2592;
  dilithium5_signature_length    :   constant Interfaces.C.size_t   :=  4627;

  type dilithium5_private_key is
    record
      val : aliased Interfaces.C.char_array (1 .. dilithium5_private_key_length)
          :=  (others =>  Interfaces.C.char'Val (0));
    end record;

    type dilithium5_public_key  is
      record
        val : aliased Interfaces.C.char_array (1 .. dilithium5_public_key_length)
            :=  (others =>  Interfaces.C.char'Val (0));
      end record;

  type dilithium5_signature  is
    record
      val : aliased Interfaces.C.char_array (1 .. dilithium5_signature_length)
          :=  (others =>  Interfaces.C.char'Val (0));
    end record;

end adare_dilithium5.dilithium;
