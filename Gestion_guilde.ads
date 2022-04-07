WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils;

PACKAGE  Gestion_Guildes IS

   TYPE T_CellG;
   TYPE T_PtG IS ACCESS T_CellG;-- pointeur Guilde
   TYPE T_CellG IS
      RECORD
         Guilde : T_Guilde;
         SuivG  : T_Ptg;
      END RECORD;


   FUNCTION Guilde_Existe (
         Liste_G : IN     T_PtG;
         Guilde  : IN     T_Guilde)
     RETURN Boolean;
   PROCEDURE Insertion_ListeG (
         Liste_G : IN OUT T_PtG;
         Guilde  : IN     T_Guilde);

   PROCEDURE Newguilde (
         G :    OUT T_Guilde);

   PROCEDURE Dissolution (
         Liste_G : IN     T_PtG;
         Guilde  : IN     T_Guilde);


   PROCEDURE VisuG (
         F : IN     T_Ptg);

END Gestion_Guildes;






---------- nouvelle version sedna -----------



WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils;

PACKAGE  Gestion_Guildes IS


   TYPE T_CellG;
   TYPE T_PtG IS ACCESS T_CellG;-- pointeur Guilde
   TYPE T_CellG IS RECORD
         Guilde : T_Guilde;
         SuivG  : T_Ptg;
      END RECORD;


   FUNCTION Guilde_Existe (Liste_G : IN T_PtG; Guilde : IN T_Guilde) RETURN Boolean;
   PROCEDURE Insertion_ListeG (Liste_G : IN OUT T_PtG; Guilde : IN T_Guilde);
   PROCEDURE Newguilde (G : OUT T_Guilde);
   PROCEDURE Dissolution (Liste_G : IN OUT T_PtG; Guilde : IN T_Guilde);
   PROCEDURE VisuG (G : IN T_Ptg);

END Gestion_Guildes;

