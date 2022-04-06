  WITH Ada.Text_Io, Ada.Sequential_IO, Gestion_guildes;
USE Ada.Text_Io;

PACKAGE  BODY Sauvegarde IS

    -- Memorisation de liste Guilde --

    PROCEDURE Sauvegarde_Guilde(Guilde : IN T_Guilde) IS
    Sauvegarde_guilde : Fichier_Sauvegarde_guilde.File_Type;

    BEGIN
     BEGIN

     Open (Sauvegarde_guilde, Append_File, "Sauvegarde_guilde");
     EXCEPTION
        WHEN OTHERS => Create (Sauvegarde_guilde, Name => "Sauvegarde_guilde");
     END;

     Write (Sauvegarde_guilde, Guilde);
      Close (Sauvegarde_guilde);

  END Sauvegarde_Guilde;
  
  PROCEDURE Sauvegarde_ListeG (Guilde : IN T_Guilde; Liste_G : IN T_PtG) IS
  p : T_PtG := Liste_G;
  BEGIN
     WHILE P/=NULL LOOP
        Sauvegarde_Guilde(P.Guilde);
        P:= P.Suivg;
     END LOOP;
     
  END Sauvegarde_ListeG;
  

      -- restauration de la liste des guildes -- 

      PROCEDURE Restaure_Guilde(Guilde: OUT T_Guilde; Liste_G : IN OUT T_PtG) IS
      USE Fichier_Sauvegarde_guilde;

      Sauvegarde_guilde: Fichier_Sauvegarde_guilde.File_Type;
      
      BEGIN
     	BEGIN

     	Open (Sauvegarde_guilde,in_File, "Sauvegarde_guilde");
      EXCEPTION
     	WHEN OTHERS => Create (Sauvegarde_guilde, Name => "Sauvegarde_guilde");
      END;

     WHILE NOT End_Of_File(Sauvegarde_Guilde) LOOP
        
        Read (Sauvegarde_Guilde, Guilde);
        Insertion_ListeG (Liste_G, Guilde);

      END LOOP;

      Close (Sauvegarde_guilde);

  END Restaure_Guilde;
  


    -- Memorisation de liste coachs --

    PROCEDURE Sauvegarde_Coach(coach : IN T_coach) IS
    Sauvegarde_coach : Fichier_Sauvegarde_coach.File_Type;

    BEGIN
     BEGIN

     Open (Sauvegarde_coach, Append_File, "Sauvegarde_coach");
     EXCEPTION
        WHEN OTHERS => Create (Sauvegarde_coach, Name => "Sauvegarde_coach");
     END;

     Write (Sauvegarde_coach, coach);
      Close (Sauvegarde_coach);

  END Sauvegarde_coach;
  
  PROCEDURE Sauvegarde_ListeC (Coach: IN T_coach; Liste_C : IN T_PtC) IS
  p : T_PtC := Liste_C;
  BEGIN
     WHILE P/=NULL LOOP
        Sauvegarde_Coach(P.coach);
        P:= P.SuivC;
     END LOOP;
     
  END Sauvegarde_ListeC;
  

      -- restauration de la liste des coachs -- 

      PROCEDURE Restaure_coach(Coach: OUT T_coach; Liste_C : IN OUT T_PtC) IS
      USE Fichier_Sauvegarde_coach;

      Sauvegarde_coach: Fichier_Sauvegarde_coach.File_Type;
      
      BEGIN
     	BEGIN

     	Open (Sauvegarde_coach,in_File, "Sauvegarde_coach");
      EXCEPTION
     	WHEN OTHERS => Create (Sauvegarde_coach, Name => "Sauvegarde_coach");
      END;

     WHILE NOT End_Of_File(Sauvegarde_coach) LOOP
        
        Read (Sauvegarde_coach, coach);
        Insertion_ListeC (Liste_C, coach);

      END LOOP;

      Close (Sauvegarde_coach);

      END Restaure_coach;


 -- Memorisation de liste poke --

    PROCEDURE Sauvegarde_poke(poke : IN T_poke) IS
    Sauvegarde_poke : Fichier_Sauvegarde_poke.File_Type;

    BEGIN
     BEGIN

     Open (Sauvegarde_poke, Append_File, "Sauvegarde_poke");
     EXCEPTION
        WHEN OTHERS => Create (Sauvegarde_poke, Name => "Sauvegarde_poke");
     END;

     Write (Sauvegarde_poke, poke);
      Close (Sauvegarde_poke);

  END Sauvegarde_poke;
  
  PROCEDURE Sauvegarde_ListeP (poke : IN T_poke; Liste_P : IN T_PtP) IS
  p : T_PtP := Liste_P;
  BEGIN
     WHILE P/=NULL LOOP
        Sauvegarde_poke(P.poke);
        P:= P.SuivP;
     END LOOP;
     
  END Sauvegarde_ListeP;
  

      -- restauration de la liste des poke -- 

      PROCEDURE Restaure_poke(poke: OUT T_poke; Liste_P : IN OUT T_PtP) IS
      USE Fichier_Sauvegarde_poke;

      Sauvegarde_poke: Fichier_Sauvegarde_poke.File_Type;
      
      BEGIN
     	BEGIN

     	Open (Sauvegarde_poke,in_File, "Sauvegarde_poke");
      EXCEPTION
     	WHEN OTHERS => Create (Sauvegarde_poke, Name => "Sauvegarde_poke");
      END;

     WHILE NOT End_Of_File(Sauvegarde_poke) LOOP
        
        Read (Sauvegarde_poke, poke);
        Insertion_ListeP (Liste_P, poke);

      END LOOP;

      Close (Sauvegarde_poke);

  END Restaure_Poke;
  


 -- Memorisation des stats type T_stats --

    PROCEDURE Sauvegarde_stat(stat : IN T_stats) IS
    Sauvegarde_stat : Fichier_Sauvegarde_stat.File_Type;

    BEGIN
     BEGIN

     Open (Sauvegarde_stat, Append_File, "Sauvegarde_stat");
     EXCEPTION
        WHEN OTHERS => Create (Sauvegarde_stat, Name => "Sauvegarde_stat");
     END;

     Write (Sauvegarde_stat, stat);
      Close (Sauvegarde_stat);

  END Sauvegarde_stat;
   

      -- restauration des stats type T_stats-- 

      PROCEDURE Restaure_stat(stat: OUT T_stats) IS
      USE Fichier_Sauvegarde_stat;

      Sauvegarde_stat: Fichier_Sauvegarde_stat.File_Type;
      
      BEGIN
     	BEGIN

     	Open (Sauvegarde_stat,in_File, "Sauvegarde_stat");
      EXCEPTION
     	WHEN OTHERS => Create (Sauvegarde_stat, Name => "Sauvegarde_stat");
      END;

     WHILE NOT End_Of_File(Sauvegarde_stat) LOOP
        
        Read (Sauvegarde_stat, stat);

      END LOOP;

      Close (Sauvegarde_stat);

  END Restaure_stat;


-- Memorisation du tableau des exp --

    PROCEDURE Sauvegarde_tabl_exp(victoire_exp : IN T_Tabl_expertise) IS
    Sauvegarde_tabl_exp : Fichier_Sauvegarde_tabl_exp.File_Type;

    BEGIN
     BEGIN

     Open (Sauvegarde_tabl_exp, Append_File, "Sauvegarde_tabl_exp");
     EXCEPTION
        WHEN OTHERS => Create (Sauvegarde_tabl_exp, Name => "Sauvegarde_tabl_exp");
     END;

     Write (Sauvegarde_tabl_exp, victoire_exp);
      Close (Sauvegarde_tabl_exp);

  END Sauvegarde_tabl_exp;
   

      -- restauration du tableau des exp -- 

      PROCEDURE Restaure_tabl_exp(victoire_exp: OUT T_tabl_expertise) IS
      USE Fichier_Sauvegarde_tabl_exp;

      Sauvegarde_tabl_exp: Fichier_Sauvegarde_tabl_exp.File_Type;
      
      BEGIN
     	BEGIN

     	Open (Sauvegarde_tabl_exp,in_File, "Sauvegarde_tabl_exp");
      EXCEPTION
     	WHEN OTHERS => Create (Sauvegarde_tabl_exp, Name => "Sauvegarde_tabl_exp");
      END;

     WHILE NOT End_Of_File(Sauvegarde_tabl_exp) LOOP
        
        Read (Sauvegarde_tabl_exp, Victoire_exp);

      END LOOP;

      Close (Sauvegarde_tabl_exp);

  END Restaure_tabl_exp;



-- Memorisation du tableau des cat --

    PROCEDURE Sauvegarde_tabl_cat(victoire_cat : IN T_Tabl_cat) IS
    Sauvegarde_tabl_cat : Fichier_Sauvegarde_tabl_cat.File_Type;

    BEGIN
     BEGIN

     Open (Sauvegarde_tabl_cat, Append_File, "Sauvegarde_tabl_cat");
     EXCEPTION
        WHEN OTHERS => Create (Sauvegarde_tabl_cat, Name => "Sauvegarde_tabl_cat");
     END;

     Write (Sauvegarde_tabl_cat, victoire_cat);
      Close (Sauvegarde_tabl_cat);

  END Sauvegarde_tabl_cat;
   

      -- restauration du tableau des cat -- 

      PROCEDURE Restaure_tabl_cat(victoire_cat: OUT T_tabl_cat) IS
      USE Fichier_Sauvegarde_tabl_cat;

      Sauvegarde_tabl_cat: Fichier_Sauvegarde_tabl_cat.File_Type;
      
      BEGIN
     	BEGIN

     	Open (Sauvegarde_tabl_cat,in_File, "Sauvegarde_tabl_cat");
      EXCEPTION
     	WHEN OTHERS => Create (Sauvegarde_tabl_cat, Name => "Sauvegarde_tabl_cat");
      END;

     WHILE NOT End_Of_File(Sauvegarde_tabl_cat) LOOP
        
        Read (Sauvegarde_tabl_cat, Victoire_cat);

      END LOOP;

      Close (Sauvegarde_tabl_cat);

  END Restaure_tabl_cat;

    
end sauvegarde; 
