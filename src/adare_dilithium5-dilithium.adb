
with adare_dilithium5.inners;

package body adare_dilithium5.dilithium with Pure is

  function    get_dilithium5_private_key (from_key   :   aliased dilithium5_private_key)    return Interfaces.C.char_array
  is (Interfaces.C.char_array (from_key.val));

  function    get_dilithium5_public_key  (from_key   :   aliased dilithium5_public_key) return Interfaces.C.char_array
  is (Interfaces.C.char_array (from_key.val));

  function    get_dilithium5_signature   (from_ciphertext    :   aliased dilithium5_signature) return Interfaces.C.char_array
  is (Interfaces.C.char_array (from_ciphertext.val));


  procedure   set_dilithium5_private_key
    (to_key :   out dilithium5_private_key;
     from   :   aliased in  Interfaces.C.char_array)
  is
  begin
    to_key.val := from;
  end set_dilithium5_private_key;

  procedure   set_dilithium5_public_key
    (to_key :   out dilithium5_public_key;
      from   :   aliased in  Interfaces.C.char_array)
  is
  begin
      to_key.val := from;
  end set_dilithium5_public_key;

  procedure   set_dilithium5_signature
    (to_sign    :   out dilithium5_signature;
      from       :   aliased in  Interfaces.C.char_array)
  is
  begin
    to_sign.val := from;
  end set_dilithium5_signature;

  use adare_dilithium5.inners;

  procedure dilithium5_keypair
    (public_key     :   out dilithium5_public_key;
      private_key    :   out dilithium5_private_key)
  is
    i   :   constant    Interfaces.C.int
        := internal_dilithium5_keypair (public_key.val'Address, private_key.val'Address)
            with Unreferenced;
  begin
    null;
  end dilithium5_keypair;


  procedure dilithium5_sign
    (signature      :   out dilithium5_signature;
     data_to_sign   :   aliased in Interfaces.C.char_array;
     private_key    :   aliased in dilithium5_private_key)
  is
    sl  : aliased Interfaces.C.size_t := signature.val'Length;

    i   : constant    Interfaces.C.int
        := internal_dilithium5_sign_create (signature.val'Address, sl'Address,
            data_to_sign'Address, data_to_sign'Length, private_key.val'Address)
                with Unreferenced;
  begin
      null;
  end dilithium5_sign;

  function dilithium5_verify
    (signature      :   aliased in dilithium5_signature;
      data_to_verify :   aliased in Interfaces.C.char_array;
      public_key     :   aliased in dilithium5_public_key
    ) return Boolean
  is (0 = internal_dilithium5_sign_verify (signature.val'Address, signature.val'Length,
      data_to_verify'Address, data_to_verify'Length, public_key.val'Address));


  function dilithium5_sign_message -- create and return  or a combination of signature and message or a zero length char_array
  (data_to_sign : aliased in Interfaces.C.char_array;
    private_key  : aliased in dilithium5_private_key)
    return Interfaces.C.char_array
  is
    csl : aliased Interfaces.C.char_array :=
      Interfaces.C.char_array'(1 .. data_to_sign'Length + dilithium5_signature_length + 1 => char'Val (0));
    sl  : aliased Interfaces.C.size_t := csl'Length;

    i   : constant    Interfaces.C.int
        := internal_dilithium5_sign (csl'Address, sl'Address,
           data_to_sign'Address, data_to_sign'Length, private_key.val'Address);
  begin
    return char_array'(if i = 0 then csl (1 .. sl) else (1 .. 0 => char'Val (0)));
  end dilithium5_sign_message;


  function dilithium5_verify_open
    (signature_and_message : aliased in Interfaces.C.char_array;
      public_key            : aliased in dilithium5_public_key)
      return Interfaces.C.char_array
  is
    csl : aliased Interfaces.C.char_array :=
      Interfaces.C.char_array'(1 .. (signature_and_message'Length + 2) - dilithium5_signature_length => char'Val (0));

    sl  : aliased Interfaces.C.size_t := csl'Length;

    i   : constant    Interfaces.C.int
        := internal_dilithium5_open (csl'Address, sl'Address,
                signature_and_message'Address, signature_and_message'Length, public_key.val'Address);
  begin
      return char_array'(if i = 0 then csl (1 .. sl) else (1 .. 0 => char'Val (0)));
  end dilithium5_verify_open;

end adare_dilithium5.dilithium;
