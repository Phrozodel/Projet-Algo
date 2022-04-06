
WITH Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_Guildes, Gestion_Coach, Gestion_Poke, gestion_tournois, Aleatoire, ada.Sequential_IO;
USE Ada.Text_IO,Ada.Integer_Text_IO,Outils, Gestion_Guildes, Gestion_Coach, Gestion_Poke, gestion_tournois, Aleatoire;

Package Sauvegarde IS

 PACKAGE Fichier_Sauvegarde_guilde IS NEW Ada.Sequential_IO (T_Guilde);
      USE Fichier_Sauvegarde_guilde;

   PROCEDURE Sauvegarde_Guilde (Guilde : IN T_Guilde);
   PROCEDURE Sauvegarde_ListeG (Guilde : IN T_Guilde; Liste_G : IN T_PtG);
   PROCEDURE Restaure_Guilde(Guilde : OUT T_Guilde; Liste_G : IN OUT T_PtG);
   
PACKAGE Fichier_Sauvegarde_coach IS NEW Ada.Sequential_IO (T_coach);
      USE Fichier_Sauvegarde_coach;

   PROCEDURE Sauvegarde_coach (coach : IN T_coach);
   PROCEDURE Sauvegarde_ListeC (coach: IN T_coach; Liste_C : IN T_PtC);
   PROCEDURE Restaure_coach(coach: OUT T_coach; Liste_C : IN OUT T_PtC);

PACKAGE Fichier_Sauvegarde_poke IS NEW Ada.Sequential_IO (T_poke);
      USE Fichier_Sauvegarde_poke;

   PROCEDURE Sauvegarde_poke (poke : IN T_poke);
   PROCEDURE Sauvegarde_ListeP (poke: IN T_poke; Liste_P : IN T_PtP);
   PROCEDURE Restaure_poke(poke: OUT T_poke; Liste_P : IN OUT T_PtP);

PACKAGE Fichier_Sauvegarde_stat IS NEW Ada.Sequential_IO (T_stats);
      USE Fichier_Sauvegarde_stat;

   PROCEDURE Sauvegarde_stat (stat : IN T_stats);
   PROCEDURE Restaure_Stat(Stat: OUT T_Stats);
   
PACKAGE Fichier_Sauvegarde_tabl_exp IS NEW Ada.Sequential_IO (T_tabl_expertise);
      USE Fichier_Sauvegarde_tabl_exp;

   PROCEDURE Sauvegarde_tabl_exp (Victoire_exp : IN T_tabl_expertise);
   PROCEDURE Restaure_Tabl_Exp(Victoire_Exp: OUT T_Tabl_Expertise);
   
PACKAGE Fichier_Sauvegarde_tabl_cat IS NEW Ada.Sequential_IO (T_tabl_cat);
      USE Fichier_Sauvegarde_tabl_cat;

   PROCEDURE Sauvegarde_tabl_cat (Victoire_cat : IN T_tabl_cat);
   PROCEDURE Restaure_tabl_cat(victoire_cat: OUT T_tabl_cat);


END Sauvegarde;

