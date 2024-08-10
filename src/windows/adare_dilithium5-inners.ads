
with Interfaces.C;
with System;

package adare_dilithium5.inners with Pure is

  function internal_dilithium5_keypair
    (public_key_i   :   System.Address; -- out
      private_key_i  :   System.Address  -- out
    ) return Interfaces.C.int

    with Import => True, Convention => StdCall, External_Name => "PQCLEAN_DILITHIUM5_CLEAN_crypto_sign_keypair";

  function internal_dilithium5_sign_create -- only signture, without original message combined
    (signature_i        :   System.Address; -- out
      signature_length_i :   System.Address; -- out
      message_i          :   System.Address; -- in
      message_length_i   :   Interfaces.C.size_t; -- in
      secret_key_i       :   System.Address  -- in
    ) return Interfaces.C.int

    with Import => True, Convention => StdCall, External_Name => "PQCLEAN_DILITHIUM5_CLEAN_crypto_sign_signature";

  function internal_dilithium5_sign_verify -- only signture, without original message combined
    (signature_i        :   System.Address; -- in
      signature_length_i :   Interfaces.C.size_t; -- in
      message_i          :   System.Address; -- in
      message_length_i   :   Interfaces.C.size_t; -- in
      public_key_i       :   System.Address  -- in
    ) return Interfaces.C.int

    with Import => True, Convention => StdCall, External_Name => "PQCLEAN_DILITHIUM5_CLEAN_crypto_sign_verify";


  function internal_dilithium5_sign -- message and signature combined
    (signature_message_i        :   System.Address; -- out
      signature_message_length_i :   System.Address; -- out
      message_i          :   System.Address; -- in
      message_length_i   :   Interfaces.C.size_t; -- in
      secret_key_i       :   System.Address  -- in
    ) return Interfaces.C.int

    with Import => True, Convention => StdCall, External_Name => "PQCLEAN_DILITHIUM5_CLEAN_crypto_sign";

  function internal_dilithium5_open  -- message and signature combined
    (message_i          :   System.Address; -- out
      message_length_i   :   System.Address; -- out
      signature_message_i        :   System.Address; -- in
      signature_message_length_i :   Interfaces.C.size_t; -- in
      public_key_i       :   System.Address  -- in
    ) return Interfaces.C.int

    with Import => True, Convention => StdCall, External_Name => "PQCLEAN_DILITHIUM5_CLEAN_crypto_sign_open";


end adare_dilithium5.inners;
