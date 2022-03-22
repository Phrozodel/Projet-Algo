PACKAGE BODY Gestion_Coachs IS


   FUNCTION Coach_Existe (
         Liste_C : IN     T_PtC;
         Coach   : IN     T_Coach)
     RETURN Boolean IS

      P : T_PtC := Liste_C;

   BEGIN

      WHILE P /= NULL LOOP
         IF P.Coach.NomC = Coach.NomC THEN
            RETURN True;
         ELSE
            P := P.SuivC ;
         END IF;
      END LOOP;
      RETURN False;

   END Coach_Existe;


   -- procedure d'insertion du nouveau coach cr?e dans la liste --

   PROCEDURE Insertion_ListeC (
         Liste_C : IN OUT T_PtC;
         Coach   : IN     T_Coach) IS

   BEGIN
      IF NOT Coach_Existe(Liste_C, Coach) THEN
         IF Liste_C = NULL THEN
            Liste_C:= NEW T_CellC'(Coach, NULL);
         ELSE
            Liste_C:= NEW T_CellC'(Coach, Liste_C);
         END IF;
      ELSE
         Put_Line ("un coach a ce nom existe deja...");
      END IF;

   END Insertion_ListeC;

   -- procedure de creation d'un nouveau coach --

   PROCEDURE NewCoach (
         Coach : IN OUT T_Coach) IS

      K,
      K2 : Integer;
   BEGIN

      Put_Line("Nom du coach: ");
      Get_Line(Coach.NomC,K);
      Put_Line("Nom de sa guilde: ");
      Get_Line(Coach.Guilde, K2);
      -- verifier que la guilde existe et actualiser son nombre de coachs, faire des procedures nouvelles pour verifier et changer ca?
      --ou juste mettre des conditions if, et ajouter en parametre in la liste de guildes
      Coach.Sansguilde := False;

      New_Line;
      Put("Felicitations! ");
      Put(Coach.NomC(1..K));
      Put(" est officiellement reconnu comme un coach!");
      New_Line;

      Put("il appartient a la guilde : ");
      Put(Coach.Guilde(1..K2)) ;
      New_Line;

      Put(Coach.NomC(1..K));
      Put(" est un coach de niveau d'expertise ");
      Put(T_Expertise'Image(Coach.Expertise));
      New_Line;
      Put("Il possede ");
      Put(Coach.Nb_Pokes);
      Put(" Pokes ");
      Put(" et ");
      Put(Coach.PointsC);
      Put(" points ");
      New_Line;


   END NewCoach;


   -- procedure de depart d'un coach (suppression de la liste) --

   PROCEDURE Depart_Coach (
         Liste_C : IN     T_PtC;
         Coach   : IN OUT T_Coach) IS
      K : Integer;
      P : T_PtC   := Liste_C;

   BEGIN

      Put ("Nom du coach : ");
      Get_Line (Coach.NomC, K);
      IF P = NULL THEN
         Put_Line ("il n'y a pas de coachs a ce moment");
      ELSE
         WHILE P/= NULL AND THEN P.SuivC/= NULL LOOP
            IF P.SuivC.Coach.NomC = Coach.NomC THEN
               P.SuivC := P.SuivC.SuivC ;
               EXIT;
            ELSE
               P:=P.SuivC;
            END IF;
            Put_Line ("le coach n'existe pas");
         END LOOP;
      END IF;

   END Depart_Coach;


   -- procedure de visualisation --

   PROCEDURE VisuCoach (
         Liste_C : IN     T_PtC) IS

      P : T_PtC := Liste_C;

   BEGIN

      IF Liste_C =NULL THEN
         Put_Line("Il n'y a pas de coachs a ce moment...");
      END IF;

      WHILE P/= NULL LOOP
         New_Line;
         Put("Nom du coach: ");
         Put(P.Coach.NomC);
         New_Line;
         Put("Nom de sa guilde :");
         IF P.Coach.Sansguilde THEN
            Put ("aucune");
         ELSE
            Put (P.Coach.Guilde); -- pbm afffichage nom guilde
         END IF;
         New_Line;
         Put("Niveau d'expertise :");
         Put(T_Expertise'Image(P.Coach.Expertise));
         New_Line;
         Put ("Nombre de Pokes : ");
         Put(P.Coach.Nb_Pokes);
         New_Line;
         Put("Nombre de Points : ");
         Put(P.Coach.PointsC);
         New_Line;
         New_Line;

         P:= P.SuivC;
      END LOOP;

   END VisuCoach;


   -- procedure de transfert de points entre coachs --
   -- ? revoir, ? tester car il y a des erreurs--

   PROCEDURE Transfert_Points (
         C1,
         C2      : IN OUT T_Coach;
         Liste_C : IN     T_PtC) IS

      K      : Integer;
      Points : Integer;
      P      : T_PtC   := Liste_C;

   BEGIN

      LOOP

         Put("quel coach donne ses points ?");
         Get_Line(C1.NomC, K);

         IF Liste_C = NULL THEN
            Put_Line ("il n'y a pas de coach a ce moment");
         END IF;

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
                        Put(C1.NomC) ;
                        Put(" ne possede que ");
                        Put(C1.PointsC);
                        Put (" points ");
                     ELSE
                        C1.PointsC := C1.PointsC - Points;
                        C2.PointsC := C2.PointsC + Points;
                        EXIT;
                     END IF;
                  END LOOP;

               ELSE
                  Put_Line (
                     "transfert impossible, les coachs n'appartiennent pas a la meme guilde");
               END IF;
            ELSE
               Put_Line ("le coach n'existe pas");
               EXIT;
            END IF;

         ELSE
            Put_Line ("le coach n'existe pas");
            EXIT;
         END IF;
      END LOOP;

   END Transfert_Points ;

   PROCEDURE Newguilde_Coach (
         Liste_G     : IN     T_PtG;
         Guilde      : IN OUT T_Guilde;
         Coach       : IN OUT T_Coach;
         Liste_C     : IN     T_PtC;
         Erreur      :    OUT Boolean;
         Exist_Error :    OUT Boolean) IS
      P  : T_PtG := Liste_G;
      PC : T_PtC := Liste_C;
   BEGIN
      Exist_Error:=False;
      IF Guilde_Existe (Liste_G,Guilde) AND Coach_Existe(Liste_C,Coach) THEN
         IF Coach.Sansguilde THEN
            WHILE P /= NULL LOOP
               IF P.Guilde.NomG = Guilde.NomG THEN
                  P.Guilde.Nb_Membres:=P.Guilde.Nb_Membres+1;
                  PC.Coach.Guilde:=P.Guilde.Nomg;
                  PC.Coach.SansGuilde:=False;
                  P.Guilde.Pointsg:=P.Guilde.Pointsg-1;
                  Put_Line("Felicitations pour le recrutement!");
               ELSE
                  P := P.SuivG ;

               END IF;
            END LOOP;

         ELSE
            Erreur:=True;
            Put_Line("Erreur, le coach n'est pas sansguilde");
         END IF;

      ELSE
         Put_Line("Erreur, la guilde ou le coach n'existent pas");
         Exist_Error:=True;
      END IF;
   END Newguilde_Coach;

   PROCEDURE Sansguilde (
         Liste_C : IN     T_PtC;
         Guilde  : IN     T_Guilde) IS
      P : T_PtC := Liste_C;

   BEGIN
      WHILE P /= NULL LOOP
         IF P.Coach.Guilde= Guilde.NomG THEN
            P.Coach.Guilde:= (OTHERS => ' ');
            P.Coach.Sansguilde:=True;
         END IF;
      END LOOP;

   END Sansguilde;


END Gestion_Coachs;
