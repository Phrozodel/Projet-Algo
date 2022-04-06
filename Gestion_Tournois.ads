WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_Guildes, Gestion_Coach, Gestion_Poke, Aleatoire;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_Guildes, Gestion_Coach, Gestion_Poke, Aleatoire;

PACKAGE  Gestion_Tournois IS

   TYPE T_Stats IS RECORD
         Nb_Tournois : Integer := 0;
         Nb_Match_Nul : Integer := 0;
   END RECORD;
   
   Victoire_Exp : T_Tabl_Expertise := (0, 0, 0, 0);   -- Pour gérer le nb de vict par niveau de coach
   Levelup : CONSTANT T_Tabl_Expertise := (0, 8, 14, 24); -- Pour gérer les level up
   Gain : CONSTANT T_Tabl_Expertise := (1, 2, 3, 4);   -- Pour gérer les pts marqués lors de chaque tournois

   TYPE T_Tabl_Cat IS ARRAY (T_CategorieP) OF Integer;
   Victoire_Cat : T_Tabl_Cat := (0, 0, 0, 0); -- Pour gérer le nb de victoire par cat de Poke

Type T_BM is array (T_categorieP, T_categorieP) of integer;
BM: T_BM;





FUNCTION Non_KO (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) RETURN Boolean;
FUNCTION Poke_Aleatoire (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) RETURN T_PtP;
PROCEDURE Actua_PtsC (C_Vainqueur,C_perdant : IN T_Coach ; ListeC : IN OUT T_PtC);
PROCEDURE Actua_PtsG (C_Vainqueur,C_perdant : IN T_Coach ; ListeG : IN OUT T_PtG ; ListeC : IN T_PtC);
PROCEDURE Lance_Tournoi (C1, C2 : OUT T_Coach; P1,P2 : IN OUT T_PtP ; ListeP : IN T_PtP ; ListeC : IN OUT T_PtC; ListeG : IN OUT T_PtG ; Stat : IN OUT T_Stats);


END Gestion_Tournois;





------------nouvelle version sedna -------------

WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_Guildes, Gestion_Coach, Gestion_Poke, Aleatoire;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_Guildes, Gestion_Coach, Gestion_Poke, Aleatoire;

PACKAGE  Gestion_Tournois IS

   TYPE T_Stats IS RECORD
         Nb_Tournois : Integer := 0;
         Nb_Match_Nul : Integer := 0;
   END RECORD;

   Victoire_Exp : T_Tabl_Expertise := (0, 0, 0, 0);   -- Pour gérer le nb de vict par niveau de coach
   Levelup : CONSTANT T_Tabl_Expertise := (0, 8, 14, 24); -- Pour gérer les level up
   Gain : CONSTANT T_Tabl_Expertise := (1, 2, 3, 4);   -- Pour gérer les pts marqués lors de chaque tournois

   TYPE T_Tabl_Cat IS ARRAY (T_CategorieP) OF Integer;
   Victoire_Cat : T_Tabl_Cat := (0, 0, 0, 0); -- Pour gérer le nb de victoire par cat de Poke

Type T_BM is array (T_categorieP, T_categorieP) of integer;
BM: T_BM;





FUNCTION Non_KO (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) RETURN Boolean;
FUNCTION Poke_Aleatoire (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) RETURN T_PtP;
PROCEDURE Actua_PtsC (C_Vainqueur,C_perdant : IN T_Coach ; ListeC : IN OUT T_PtC);
PROCEDURE Actua_PtsG (C_Vainqueur,C_perdant : IN T_Coach ; ListeG : IN OUT T_PtG ; ListeC : IN T_PtC);
PROCEDURE Lance_Tournoi (C1, C2 , C_vainqueur, C_perdant : OUT T_Coach; P1,P2 : IN OUT T_PtP ; ListeP : IN T_PtP ; ListeC : IN OUT T_PtC; ListeG : IN OUT T_PtG ; Stat : IN OUT T_Stats);


END Gestion_Tournois;



