WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils;

PACKAGE  Gestion_Guildes IS

   TYPE T_CellG;
   TYPE T_PtG IS ACCESS T_CellG;-- pointeur Guilde
   TYPE T_CellG IS
      RECORD
         Guilde : T_Guilde;
         Suiv   : T_Ptg;
      END RECORD;
   TYPE T_FileG IS
      RECORD
         Teteg,
         Fing  : T_Ptg;
      END RECORD;

   PROCEDURE Enfiler_Guilde (
         F : IN OUT T_Fileg;
         G : IN     T_Guilde);
   PROCEDURE Newguilde (
         G :    OUT T_Guilde);
   PROCEDURE Dissolution (
         F :        T_Ptg;
         G : IN OUT T_Guilde);
   PROCEDURE Newguilde_Coach (
         G      : IN OUT T_Guilde;
         C      : IN OUT T_Coach;
         Erreur :    OUT Boolean);
   PROCEDURE VisuG (
         F : IN     T_Ptg);
END Gestion_Guildes;
