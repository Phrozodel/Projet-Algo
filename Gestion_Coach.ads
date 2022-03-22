WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils,gestion_Guildes;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils,Gestion_Guildes;

PACKAGE  gestion_coachs IS


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
      PROCEDURE Newguilde_Coach (
         Liste_G : IN     T_PtG;
         Guilde  : IN OUT T_Guilde;
         Coach   : IN OUT T_Coach;
         Liste_C : IN     T_PtC;
         Erreur  :    OUT Boolean;
         Exist_error: out boolean);
end gestion_coachs;
