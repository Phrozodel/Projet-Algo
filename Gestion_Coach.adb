PACKAGE BODY Gestion_Coach IS

   -- fonction pour vérifier qu'un coach existe dans la liste (à partir de son nom donné) --

   FUNCTION Coach_Existe (Liste_C : IN T_PtC ; coach : IN T_coach) RETURN Boolean IS

      P : T_PtC := Liste_C;

   BEGIN

      IF P /= NULL THEN
         if p.Coach.NomC = coach.NomC THEN return true;
         ELSE p := p.suivC ;
         END IF;
      END IF;
      return false;

   END Coach_Existe;


   -- procedure d'insertion du nouveau coach crée dans la liste --

   PROCEDURE Insertion_ListeC (Liste_C : IN OUT T_PtC ; Coach : IN T_Coach) IS

   BEGIN
      IF NOT Coach_Existe(Liste_C, Coach) THEN
         IF Liste_C = NULL THEN
            Liste_C:= NEW T_CellC'(Coach, null);
         ELSE Liste_C:= NEW T_CellC'(Coach, Liste_C);
         END IF;
         Else put_line ("un coach a ce nom existe deja...");
      END IF;

   END Insertion_ListeC;

-- procedure de creation d'un nouveau coach --

   PROCEDURE NewCoach (Coach : IN OUT T_Coach) IS

      K,k2 : Integer;

   BEGIN
      Put_Line("Nom du coach: ");
      Get_Line(Coach.NomC,K);
      Put_Line("Nom de sa guilde: ");
      Get_line(Coach.Guilde, K2);
      Coach.sansguilde := false;

      new_line;
      Put("Felicitations! ");
      Put(Coach.NomC(1..K));
      Put(" est officiellement reconnu comme un coach!");
      New_Line;

      Put("il appartient a la guilde : "); Put(Coach.Guilde(1..k2)) ;
      new_line;

      Put(Coach.NomC(1..K));
      Put(" est un coach de niveau d'expertise "); Put(T_expertise'image(Coach.Expertise));
      New_line;
      Put("Il possede "); Put(Coach.Nb_Pokes); Put(" Pokes ");
      Put(" et "); Put(Coach.PointsC); Put(" points ");
      New_Line;

   END NewCoach;


   -- procedure de depart d'un coach (suppression de la liste) --

   PROCEDURE Depart_Coach (Liste_C : IN T_PtC ; Coach : IN OUT T_coach ) IS
      K : Integer ;
      P : T_PtC := Liste_C;

   BEGIN

      Put ("Nom du coach : ");
      Get_line (Coach.NomC, K);
      IF p = NULL THEN Put_Line ("il n'y a pas de coachs a ce moment");
      ELSe
         WHILE P/= NULL AND THEN P.suivC/= null LOOP
            IF P.suivC.Coach.NomC = Coach.NomC THEN p.suivC := p.suivC.suivC ; exit;
            ELSE P:=P.SuivC;
            END IF;
            Put_Line ("le coach n'existe pas");
         END LOOP;
      END IF;

   END Depart_Coach;


   -- procedure de visualisation --

   PROCEDURE VisuCoach (Liste_C : IN T_PtC) IS

      P : T_PtC := Liste_C;

   BEGIN

      IF Liste_C =NULL THEN Put_Line("Il n'y a pas de coachs a ce moment...");
      end if;

    while p/= NULL loop
         New_Line;
         Put("Nom du coach: ");
         Put(p.Coach.NomC);
         New_Line;
         Put("Nom de sa guilde :");
            IF p.Coach.sansguilde THEN Put ("aucune");
            ELSE Put (p.Coach.Guilde); -- pbm afffichage nom guilde
            END IF;
         New_Line;
         Put("Niveau d'expertise :");
         Put(T_Expertise'Image(p.Coach.Expertise));
         New_line;
         Put ("Nombre de Pokes : ");
         Put(p.Coach.Nb_Pokes);
         New_Line;
         Put("Nombre de Points : ");
         Put(p.Coach.PointsC);
         New_Line;
         New_Line;

         p:= p.suivC;
         end loop;

   END VisuCoach;


   -- procedure de transfert de points entre coachs --
-- à revoir, à tester car il y a des erreurs-- 

   PROCEDURE Transfert_Points (C1, C2 : IN OUT T_coach ; Liste_C : IN T_PtC) IS

      K: Integer;
      points : integer;
      P : T_PtC := Liste_C;

   BEGIN

   LOOP

      Put("quel coach donne ses points ?");
         Get_Line(C1.NomC, K);

         IF Liste_C = NULL THEN Put_Line ("il n'y a pas de coach a ce moment");
         end if;

         IF Coach_Existe(Liste_C, C1) THEN
            Put ("A quel coach voulez-vous transferer des points ?");
            Get_Line(C2.NomC, K);
            IF Coach_Existe(Liste_C, C2) THEN
                IF C2.Guilde = C1.Guilde THEN
                  LOOP
                  Put("combien de points voulez-vous lui transferer ?");
                  Get(Points);
                     IF Points > C1.PointsC THEN
                     Put_Line("transfert impossible ");
                     Put(C1.NomC) ; Put(" ne possede que ");
                     Put(C1.PointsC); Put (" points ");
                     ELSE C1.PointsC := C1.PointsC - Points;
                     C2.PointsC := C2.PointsC + Points; exit;
                     END IF;
                   END LOOP;

                ELSE Put_Line ("transfert impossible, les coachs n'appartiennent pas a la meme guilde");
                END IF;
            ELSE Put_Line ("le coach n'existe pas"); EXIT;
            end if;

         ELSE Put_Line ("le coach n'existe pas"); exit;
         END IF;
      END LOOP;

   END Transfert_Points ;


END Gestion_Coach;

