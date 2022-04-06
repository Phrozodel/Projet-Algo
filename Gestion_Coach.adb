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



---------------- nouvelle version sedna ---------



PACKAGE BODY Gestion_Poke IS

   -- fonction pour vérifier qu'un poke existe dans la liste (à partir de son nom donné) --

   FUNCTION Poke_Existe (Liste_P : IN T_PtP ; Poke : IN T_Poke) RETURN Boolean IS

      P : T_PtP := Liste_P;

   BEGIN

      while P /= NULL loop
         if p.poke.NomP = Poke.NomP THEN return true;
         ELSE p := p.suivP ;
         END IF;
      END loop;
      return false;

   END Poke_Existe;

-- procedure de creation d'un nouveau poke --

   PROCEDURE NewPoke (Poke : IN OUT T_Poke) IS

      K,k1 : Integer;
      cat : string(1..50);

   BEGIN
      Put_Line("Nom du poke: ");
      Get_Line(Poke.NomP,K);
      Put_Line("categorie: ");
      Get_Line(cat,K1);
      Poke.cat:=T_categorieP'value(cat(1..k1));
      new_line;
      Put("Felicitations! ");
      Put(Poke.NomP(1..K));
      Put(" est officiellement reconnu comme un poke!");
      New_Line;

      Put(Poke.NomP(1..K));
      Put(" est un Poke de categorie "); Put(T_categorieP'image(Poke.cat));
      Put (" et de force "); Put(Poke.Force); New_Line;
      Put ("il possede "); Put(poke.PV) ; put(" PV"); new_line;
      Put("il est orphelin et disponible a l'adoption");
      New_Line;

   END NewPoke;


  -- procedure d'insertion du nouveau poke crée dans la liste --

   PROCEDURE Insertion_ListeP (Liste_P : IN OUT T_PtP ; Poke : IN T_Poke) IS

   BEGIN
      IF NOT Poke_Existe(Liste_P, Poke) THEN
         IF Liste_P = NULL THEN
            Liste_P:= NEW T_CellP'(Poke, null);
         ELSE Liste_P:= NEW T_CellP'(Poke, Liste_P);
         END IF;
         Else put_line ("un poke a ce nom existe deja...");
      END IF;

   END Insertion_ListeP;

-- procedure de visualisation des pokes --

   PROCEDURE VisuPoke (Liste_P : IN T_PtP) IS

      P : T_PtP := Liste_P;

   BEGIN

      IF Liste_P =NULL THEN Put_Line("Il n'y a pas de pokes a ce moment...");
      end if;

    while p/= NULL loop
         New_Line;
         Put("Nom du poke: ");
         Put(p.poke.nomP);
         New_Line;
         If not p.poke.orphelin then Put("Nom de son coach :");
         Put (p.poke.coach);
         ELSE Put("ce poke est orphelin");
         END IF;
         New_Line;
         Put("Categorie :");
         Put(T_categorieP'Image(p.poke.cat));
         New_line;
         Put ("Force : ");
         Put(p.poke.force);
         New_Line;
         Put("Points de vie : ");
         Put(p.poke.PV);
         New_Line;
         New_Line;

         p:= p.suivP;
         end loop;

   END VisuPoke;

   -- procedure de diparition d'un poke --

   PROCEDURE Disparition_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C : IN T_PtC) IS

      K : Integer;
      P : T_PtP := Liste_P;
      c : T_PtC := Liste_C;

   BEGIN

      Put_Line ("donnez le nom du poke que vous voulez faire disparaitre :");
      Get_Line(Poke.NomP, K);
      IF Poke_Existe(Liste_P, Poke) THEN
         WHILE P/=NULL AND THEN p.suivP/=null LOOP
            IF P.suivP.Poke.NomP = Poke.NomP THEN
               P:= P.SuivP.SuivP;
            ELSE P:= P.SuivP;
            END IF;
         END LOOP;

         WHILE C/=NULL LOOP
            IF C.Coach.NomC = Poke.Coach THEN
               C.Coach.Nb_Pokes := C.Coach.Nb_Pokes - 1;
            ELSE C:= C.SuivC;
            END IF;
         END LOOP;

         Put("Malheur ! Le poke "); Put(P.Poke.NomP) ; Put(" a disparu ...");
         New_Line;
         Put(Poke.Coach); Put(", son coach, pert un poke."); New_line;
         Put("il a desormais "); Put(c.Coach.Nb_Pokes) ; Put(" pokes.");
         New_Line;

      ELSE Put_Line("ce poke n'existe pas");
      END IF;

   END Disparition_P;

   -- procedure pour soigner un poke --

   PROCEDURE Soin_P (Liste_P : IN T_PtP ; Poke : IN OUT T_Poke; Liste_C : IN T_PtC) IS

      P : T_PtP := Liste_P;
      C : T_PtC := Liste_C;
      K, Ent, B, n : Integer ;
      Trouve : Boolean := False;

   BEGIN

      Put_Line ("quel poke voulez-vous soigner ?" );
      Get_Line(Poke.NomP, K);

      WHILE P/=NULL LOOP
         IF P.Poke.NomP = Poke.NomP THEN
            IF P.Poke.Orphelin THEN Put_Line("impossible, ce poke n'a pas de coach"); exit;
            ELSIF P.Poke.PV /= 0 THEN Put_Line ("impossible, ce poke n'est pas KO"); exit;
            ELSE
               WHILE C/=NULL LOOP
                  IF C.Coach.NomC = Poke.Coach THEN
                     IF C.Coach.PointsC >= 2 THEN
                        B := Borne(C.coach.expertise);
                        Initialise (1,b); n:= random;
                        Put("choisissez un entier entre 0 et "); Put(b); Put(" Vous avez 5 essais.");
                        new_line;
                        Get (Ent);

                        FOR I IN 1..5 LOOP
                           IF Ent = b THEN Put_Line ("Bravo vous avez reussi ! ");
                              Put(Poke.NomP); Put(" est guéri"); New_Line;
                              Poke.PV := 6; trouve := true; exit;
                           ELSIF Ent > b THEN Put_Line("l'entier cherché est plus petit");
                           ELSE Put_Line("l'entier cherché est plus grand");
                           end if;
                        END LOOP;

                          If not trouve then Disparition_P (Liste_P, Poke, Liste_C);
                          end if;

                     ELSE Put_Line("le coach n'a pas assez de points");
                     END IF;
                  ELSE C:=C.SuivC;
                  END IF;
               END LOOP;


            END IF;
         ELSE P:= P.SuivP;
         END IF;
      END LOOP;



   END Soin_P ;


   -- adoption Poke --

   PROCEDURE Adoption_P (Liste_P : IN T_PtP ; Poke : IN OUT T_poke; Liste_C: IN T_PtC; coach : OUT T_coach) IS

   K : Integer ;
      P : T_PtP := Liste_P;
      pc: T_PtC := Liste_C;

   BEGIN

   Put("Nom du coach qui adopte : ");
   Get_Line (Coach.NomC, K);
   IF Coach_Existe(Liste_C,Coach) THEN

    If coach.Nb_Pokes/=MaxPokes(coach.expertise) then
      IF coach.PointsC /= 0 THEN
      Put("quel poke voulez vous adopter ?");
      Get_Line(Poke.NomP, K);
      IF NOT Poke_Existe(Liste_P, Poke) THEN Put_Line("ce poke n'existe pas");
      Elsif p = NULL THEN Put_Line ("il n'y a pas de pokes a ce moment");
      Elsif Poke_Existe(Liste_P, Poke) THEN 
         while p/=null loop
         IF P.Poke.NomP = Poke.NomP THEN
               p.Poke.Orphelin:= False;
               p.Poke.Coach:= Coach.NomC;
               p.Poke.Force := Force(Coach.Expertise);
               end if;
         p := p.suivP ;
                     END LOOP;
                  WHILE PC/=NULL LOOP
                  IF Pc.Coach.NomC=Coach.NomC THEN Pc.coach.Nb_Pokes :=Pc.coach.Nb_Pokes+1;
                  END IF;
                  pc:=pc.suivC;
               END LOOP;
               end if;
      else put_line ("le coach ne peut pas adopter de poke car son nombre de points est nul");
      END IF;
    else put_line("ce coach ne peut pas adopter de poke car son nombre max de pokes est atteint");
    end if;
   ELSE Put_Line ("ce coach n'existe pas");
   END IF;

   END Adoption_P ;

end Gestion_Poke;

