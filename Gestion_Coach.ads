WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_guildes;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils, gestion_guildes;

PACKAGE  Gestion_Coach IS

   TYPE T_Expertise IS (Novice, Confirme, Expert,  Maitre);

   TYPE T_Coach IS RECORD
         NomC      : T_Mot:= (OTHERS  => ' ');
         Expertise : T_Expertise := Novice;
         Guilde    : T_Mot;
         Nb_Pokes  : Integer:= 0; --Inferieur a 14
         PointsC   : Integer:=6;
         sansguilde: boolean:=true;
      END RECORD;


   TYPE T_CellC;
   TYPE T_PtC IS ACCESS T_CellC; -- pointeur Coach
   TYPE T_CellC IS RECORD
         Coach : T_Coach;
         SuivC   : T_PtC;
      END RECORD;


   FUNCTION Coach_Existe (Liste_C : IN T_PtC ; Coach : IN T_Coach) return boolean;
   PROCEDURE Insertion_ListeC (Liste_C : IN OUT T_PtC ; Coach : IN T_Coach);
   PROCEDURE NewCoach (Coach : IN OUT T_Coach );
   PROCEDURE Depart_Coach (Liste_C : IN T_PtC ; coach : IN OUT T_coach );
   PROCEDURE VisuCoach (Liste_C: IN T_PtC);
   PROCEDURE Transfert_Points (C1, C2 : IN OUT T_coach ; Liste_C : IN T_PtC) ;


END Gestion_Coach;

