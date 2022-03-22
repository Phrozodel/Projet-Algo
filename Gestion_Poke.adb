PACKAGE BODY Gestion_Poke IS

   -- fonction pour v?rifier qu'un poke existe dans la liste (? partir de son nom donn?) --

   FUNCTION Poke_Existe (
         Liste_P : IN     T_PtP;
         Poke    : IN     T_Poke)
     RETURN Boolean IS

      P : T_PtP := Liste_P;

   BEGIN

      WHILE P /= NULL LOOP
         IF P.Poke.NomP = Poke.NomP THEN
            RETURN True;
         ELSE
            P := P.SuivP ;
         END IF;
      END LOOP;
      RETURN False;

   END Poke_Existe;

   -- procedure de creation d'un nouveau poke --

   PROCEDURE NewPoke (
         Poke : IN OUT T_Poke) IS

      K : Integer;

   BEGIN
      Put_Line("Nom du poke: ");
      Get_Line(Poke.NomP,K);

      New_Line;
      Put("Felicitations! ");
      Put(Poke.NomP(1..K));
      Put(" est officiellement reconnu comme un poke!");
      New_Line;

      Put(Poke.NomP(1..K));
      Put(" est un Poke de categorie ");
      Put(T_CategorieP'Image(Poke.Cat));
      Put (" et de force ");
      Put(Poke.Force);
      New_Line;
      Put ("il poss?de ");
      Put(Poke.PV) ;
      Put(" PV");
      New_Line;
      Put("il est orphelin et disponible a l'adoption");
      New_Line;

   END NewPoke;


   -- procedure d'insertion du nouveau poke cr?e dans la liste --

   PROCEDURE Insertion_ListeP (
         Liste_P : IN OUT T_PtP;
         Poke    : IN     T_Poke) IS

   BEGIN
      IF NOT Poke_Existe(Liste_P, Poke) THEN
         IF Liste_P = NULL THEN
            Liste_P:= NEW T_CellP'(Poke, NULL);
         ELSE
            Liste_P:= NEW T_CellP'(Poke, Liste_P);
         END IF;
      ELSE
         Put_Line ("un poke avec ce nom existe deja...");
      END IF;

   END Insertion_ListeP;

   -- procedure de visualisation des pokes --

   PROCEDURE VisuPoke (
         Liste_P : IN     T_PtP) IS

      P : T_PtP := Liste_P;

   BEGIN

      IF Liste_P =NULL THEN
         Put_Line("Il n'y a pas de pokes a ce moment...");
      END IF;

      WHILE P/= NULL LOOP
         New_Line;
         Put("Nom du poke: ");
         Put(P.Poke.NomP);
         New_Line;
         IF NOT P.Poke.Orphelin THEN
            Put("Nom de son coach :");
            Put (P.Poke.Coach);
         ELSE
            Put("ce poke est orphelin");
         END IF;
         New_Line;
         Put("Categorie :");
         Put(T_CategorieP'Image(P.Poke.Cat));
         New_Line;
         Put ("Force : ");
         Put(P.Poke.Force);
         New_Line;
         Put("Points de vie : ");
         Put(P.Poke.PV);
         New_Line;
         New_Line;

         P:= P.SuivP;
      END LOOP;

   END VisuPoke;

   -- procedure de diparition d'un poke --

   PROCEDURE Disparition_P (
         Liste_P : IN     T_PtP;
         Poke    : IN OUT T_Poke;
         Liste_C : IN     T_PtC) IS

      K : Integer;
      P : T_PtP   := Liste_P;
      C : T_PtC   := Liste_C;

   BEGIN

      Put_Line (
         "donnez le nom du poke que vous voulez faire disparaitre :");
      Get_Line(Poke.NomP, K);
      IF Poke_Existe(Liste_P, Poke) THEN
         WHILE P/=NULL AND THEN P.SuivP/=NULL LOOP
            IF P.SuivP.Poke.NomP = Poke.NomP THEN
               P:= P.SuivP.SuivP;
            ELSE
               P:= P.SuivP;
            END IF;
         END LOOP;

         WHILE C/=NULL LOOP
            IF C.Coach.NomC = Poke.Coach THEN
               C.Coach.Nb_Pokes := C.Coach.Nb_Pokes - 1;
            ELSE
               C:= C.SuivC;
            END IF;
         END LOOP;

         Put("Malheur ! Le poke ");
         Put(P.Poke.NomP) ;
         Put(" a disparu ...");
         New_Line;
         Put(Poke.Coach);
         Put(", son coach, pert un poke.");
         New_Line;
         Put("il a desormais ");
         Put(C.Coach.Nb_Pokes) ;
         Put(" pokes.");
         New_Line;

      ELSE
         Put_Line("ce poke n'existe pas");
      END IF;

   END Disparition_P;

   -- procedure pour soigner un poke --

   PROCEDURE Soin_P (
         Liste_P : IN     T_PtP;
         Poke    : IN OUT T_Poke;
         Liste_C : IN     T_PtC) IS

      P      : T_PtP   := Liste_P;
      C      : T_PtC   := Liste_C;
      K,
      Ent,
      B,
      N      : Integer;
      Trouve : Boolean := False;

   BEGIN

      Put_Line ("quel poke voulez-vous soigner ?" );
      Get_Line(Poke.NomP, K);

      WHILE P/=NULL LOOP
         IF P.Poke.NomP = Poke.NomP THEN
            IF P.Poke.Orphelin THEN
               Put_Line("impossible, ce poke n'a pas de coach");
            ELSIF P.Poke.PV /= 0 THEN
               Put_Line ("impossible, ce poke n'est pas KO");
            ELSE
               WHILE C/=NULL LOOP
                  IF C.Coach.NomC = Poke.Coach THEN
                     IF C.Coach.PointsC >= 2 THEN
                        B := Borne(C.Coach.Expertise);
                        Initialise (1,B);
                        N:= Random;
                        Put("choisissez un entier entre 0 et ");
                        Put(B);
                        Put(" Vous avez 5 essais.");
                        New_Line;
                        Get (Ent);

                        FOR I IN 1..5 LOOP
                           IF Ent = B THEN
                              Put_Line ("Bravo vous avez reussi ! ");
                              Put(Poke.NomP);
                              Put(" est gu?ri");
                              New_Line;
                              Poke.PV := 6;
                              Trouve := True;
                              EXIT;
                           ELSIF Ent > B THEN
                              Put_Line("l'entier cherch? est plus petit");
                           ELSE
                              Put_Line("l'entier cherch? est plus grand");
                           END IF;
                        END LOOP;

                        IF NOT Trouve THEN
                           Disparition_P (Liste_P, Poke, Liste_C);
                        END IF;

                     ELSE
                        Put_Line("le coach n'a pas assez de points");
                     END IF;
                  ELSE
                     C:=C.SuivC;
                  END IF;
               END LOOP;


            END IF;
         ELSE
            P:= P.SuivP;
         END IF;
      END LOOP;



   END Soin_P ;


   -- adoption Poke --

   PROCEDURE Adoption_P (
         Liste_P : IN     T_PtP;
         Poke    : IN OUT T_Poke;
         Liste_C : IN     T_PtC;
         Coach   : IN OUT T_Coach) IS

      K : Integer;
      P : T_PtP   := Liste_P;

   BEGIN

      Put("Nom du coach qui adopte : ");
      Get_Line (Coach.NomC, K);
      IF Coach_Existe(Liste_C,Coach) THEN

         IF Coach.Nb_Pokes/=MaxPokes(Coach.Expertise) THEN
            IF Coach.PointsC /= 0 THEN
               Put("quel poke voulez vous adopter ?");
               Get_Line(Poke.NomP, K);
               IF NOT Poke_Existe(Liste_P, Poke) THEN
                  Put_Line("ce poke n'existe pas");
               ELSIF P = NULL THEN
                  Put_Line ("il n'y a pas de pokes a ce moment");
               ELSIF P.Poke.NomP = Poke.NomP THEN
                  IF Poke.Orphelin THEN
                     Poke.Orphelin := False;
                     Poke.Coach:= Coach.NomC;
                     Poke.Force := Force(Coach.Expertise);
                  ELSE
                     Put_Line(
                        "ce poke ne peut pas ?tre adopte, il n'est pas orphelin");
                  END IF;
               ELSE
                  P := P.SuivP ;
               END IF;

            ELSE
               Put_Line (
                  "le coach ne peut pas adopter de poke car son nombre de points est nul");
            END IF;
         ELSE
            Put_Line(
               "ce coach ne peut pas adopter de poke car son nombre max de pokes est atteint");
         END IF;
      ELSE
         Put_Line ("ce coach n'existe pas");
      END IF;

   END Adoption_P ;

END Gestion_Poke;
