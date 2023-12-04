with Ada.Text_IO;
with adare_dilithium5.dilithium;
with Interfaces.C;

use Ada;
use adare_dilithium5;
use Interfaces.C;

procedure Adare_Dilithium5_Examples0
is

  secret_key1 :   aliased dilithium.dilithium5_private_key;
  public_key1 :   aliased dilithium.dilithium5_public_key;


  signature1  :   aliased dilithium.dilithium5_signature;

  signature2  :   aliased dilithium.dilithium5_signature;

  data1       :   aliased char_array  :=  To_C ("I like Ada Lang");

  data2       :   aliased char_array  :=  data1;

  ok1         :   Boolean     :=  True;
begin

  dilithium.dilithium5_keypair (public_key1, secret_key1);

  Text_IO.New_Line;

  Text_IO.Put_Line (" Public Key1" & To_Ada (dilithium.get_dilithium5_public_key (public_key1), False));

  Text_IO.New_Line;

  Text_IO.Put_Line (" Secret Key1" & To_Ada (dilithium.get_dilithium5_private_key (secret_key1), False));

  Text_IO.New_Line;

  Text_IO.Put_Line (" data1 " & To_Ada (data1));

  dilithium.dilithium5_sign (signature1, data1, secret_key1);

  Text_IO.New_Line;

  Text_IO.Put_Line (" signature1 " & To_Ada (dilithium.get_dilithium5_signature (signature1), False));


  signature2  :=  signature1; -- just for backup or maybe offload

  ok1 :=  dilithium.dilithium5_verify (signature2, data1, public_key1);

  Text_IO.New_Line;

  Text_IO.Put_Line (" verify signature are ok ?" & ok1'Image);

  Text_IO.New_Line (2);

  b2 :
  declare
    -- just for demonstration of some uses.

    sk1     :   aliased char_array    :=  dilithium.get_dilithium5_private_key (secret_key1);
    pk1     :   aliased char_array    :=  dilithium.get_dilithium5_public_key (public_key1);
    sg1     :   aliased char_array    :=  dilithium.get_dilithium5_signature (signature1);

    seck3   :   aliased dilithium.dilithium5_private_key;
    pubk3   :   aliased dilithium.dilithium5_public_key;
    sg3     :   aliased dilithium.dilithium5_signature;
  begin


    dilithium.set_dilithium5_private_key (seck3, sk1);

    dilithium.set_dilithium5_public_key (pubk3, pk1);

    dilithium.set_dilithium5_signature (sg3, sg1);

  end b2;

  Text_IO.Put_Line (" Enjoy!!! :-]");
  Text_IO.New_Line (2);

end Adare_Dilithium5_Examples0;
