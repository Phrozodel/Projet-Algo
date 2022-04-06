WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils,  Gestion_Coachs, aleatoire;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils,  Gestion_Coachs, aleatoire;

PACKAGE  Gestion_Poke IS


   TYPE T_CategorieP IS (Eau, Feu, Terre, Air);

   TYPE T_Poke IS RECORD
         NomP  : T_Mot   := (OTHERS => ' '); --Unique
         PV : Integer := 6;
         Force : Integer := 2;
         Coach : T_Mot ;
         Orphelin: Boolean:=True;
         cat : T_categorieP;
   END RECORD;


  TYPE T_CellP;
  TYPE T_PtP IS ACCESS T_CellP; -- pointeur Poke
  TYPE T_CellP IS RECORD
        Poke : T_Poke;
        SuivP   : T_PtP;
  END RECORD;

  TYPE T_Tabl_Expertise IS ARRAY (T_Expertise) OF Integer;

  MaxPokes: T_Tabl_Expertise:=(3,5,10,8); -- Pour gérer le nb max de Pokes par expertise

  Force: T_Tabl_Expertise:=(2,5,8,10); -- Pour gérer les forces des Pokes

  Borne: T_Tabl_Expertise:=(500,400,300,100);
  
  -- fonctions et procedures --
  
  FUNCTION Poke_Existe (Liste_P : IN T_PtP ; Poke : IN T_Poke) RETURN Boolean;
  PROCEDURE NewPoke (Poke : IN OUT T_Poke);
  PROCEDURE Insertion_ListeP (Liste_P : IN OUT T_PtP ; Poke : IN T_Poke);
  PROCEDURE VisuPoke (Liste_P : IN T_PtP);
  PROCEDURE Disparition_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C : IN T_PtC);
  PROCEDURE Adoption_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C: IN T_PtC; Coach : IN OUT T_coach);
  PROCEDURE Soin_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C : IN T_PtC );
  
  


end Gestion_Poke;



--------------- nouvelle version sedna -------------------


WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils, gestion_guildes,  Gestion_coach, aleatoire;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils, gestion_guildes, Gestion_coach, aleatoire;

PACKAGE  Gestion_Poke IS


   TYPE T_CategorieP IS (Eau, Feu, Terre, Air);

   TYPE T_Poke IS RECORD
         NomP  : T_Mot   := (OTHERS => ' '); --Unique
         PV : Integer := 6;
         Force : Integer := 2;
         Coach : T_Mot ;
         Orphelin: Boolean:=True;
      Cat : T_CategorieP;
      KO : boolean := false;
   END RECORD;


  TYPE T_CellP;
  TYPE T_PtP IS ACCESS T_CellP; -- pointeur Poke
  TYPE T_CellP IS RECORD
        Poke : T_Poke;
        SuivP   : T_PtP;
  END RECORD;

  TYPE T_Tabl_Expertise IS ARRAY (T_Expertise) OF Integer;

  MaxPokes: T_Tabl_Expertise:=(3,5,10,8); -- Pour gérer le nb max de Pokes par expertise

  Force: T_Tabl_Expertise:=(2,5,8,10); -- Pour gérer les forces des Pokes

  Borne: T_Tabl_Expertise:=(500,400,300,100);

  -- fonctions et procedures --

  FUNCTION Poke_Existe (Liste_P : IN T_PtP ; Poke : IN T_Poke) RETURN Boolean;
  PROCEDURE NewPoke (Poke : IN OUT T_Poke);
  PROCEDURE Insertion_ListeP (Liste_P : IN OUT T_PtP ; Poke : IN T_Poke);
  PROCEDURE VisuPoke (Liste_P : IN T_PtP);
  PROCEDURE Disparition_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C : IN T_PtC);
  PROCEDURE Adoption_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C: IN T_PtC; Coach : OUT T_coach);
  PROCEDURE Soin_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C : IN T_PtC );




end Gestion_Poke;
