WITH Ada.Text_IO,Ada.Integer_Text_IO;
USE Ada.Text_IO,Ada.Integer_Text_IO;

PACKAGE  Outils IS

subtype t_mot is string (1..30);

   --Noms Sont Uniques → Contrainte Appliquee Au Moment Des Saisies

   TYPE T_Guilde IS
      RECORD
         NomG       : T_Mot   := (OTHERS => ' ');
         Nb_Membres : Integer := 0;
         PointsG    : Integer := 4;
                  Dissoute: boolean:=false;
      END RECORD;
   TYPE T_Expertise IS
         (Novice,
          Confirme,
          Expert,
          Maitre);
   TYPE T_Coach IS
      RECORD
         NomC      : T_Mot       := (OTHERS => ' ');
         Expertise : T_Expertise := Novice;
         Guilde    : T_Guilde;
         Nb_Pokes  : Integer     := 0;               --Inferieur a 14
         PointsC   : Integer;
                  sansguilde: boolean:=true;
      END RECORD;


   TYPE T_CategorieP IS
         (Eau,
          Feu,
          Terre,
          Air);

   TYPE T_Poke IS
      RECORD
         NomP  : T_Mot   := (OTHERS => ' ');          --Unique PV : Integer := 6;
         Force : Integer := 2;
         Coach : T_Coach ;
                  Orphelin: boolean:=true;
      END RECORD;

Procedure rien; --juste pour que le body soit accepte pour l'instant
END Outils;
