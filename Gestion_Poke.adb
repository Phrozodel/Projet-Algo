
PACKAGE BODY Gestion_Poke IS
   
   -- fonction pour vérifier qu'un poke existe dans la liste (à partir de son nom donné) --

   FUNCTION Poke_Existe (Liste_P : IN T_PtP ; Poke : IN T_Poke) RETURN Boolean IS

      P : T_PtP := Liste_P;

   BEGIN

      IF P /= NULL THEN
         if p.poke.NomP = Poke.NomP THEN return true;
         ELSE p := p.suivP ;
         END IF;
      END IF;
      return false;

   END Poke_Existe;

-- procedure de creation d'un nouveau poke --

   PROCEDURE NewPoke (Poke : IN OUT T_Poke) IS

      K : Integer;

   BEGIN
      Put_Line("Nom du poke: ");
      Get_Line(Poke.NomP,K);

      new_line;
      Put("Felicitations! ");
      Put(Poke.NomP(1..K));
      Put(" est officiellement reconnu comme un poke!");
      New_Line;

      Put(Poke.NomP(1..K));
      Put(" est un Poke de categorie "); Put(T_categorieP'image(Poke.cat));
      Put (" et de force "); Put(Poke.Force); New_Line;
      Put ("il possède "); Put(poke.PV) ; put(" PV"); new_line;
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
            IF P.Poke.Orphelin THEN Put_Line("impossible, ce poke n'a pas de coach");
            ELSIF P.Poke.PV /= 0 THEN Put_Line ("impossible, ce poke n'est pas KO");
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
   
   PROCEDURE Adoption_P (Liste_P : IN T_PtP ; Poke : IN OUT T_poke; Liste_C: IN T_PtC; coach : IN OUT T_coach) IS

   K : Integer ;
   P : T_PtP := Liste_P;
   
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
         ELSIF P.Poke.NomP = Poke.NomP THEN
               IF Poke.Orphelin THEN Poke.Orphelin := False;
               Poke.Coach:= Coach.NomC;
               Poke.force := Force(Coach.expertise);     
               ELSE Put_Line("ce poke ne peut pas être adopte, il n'est pas orphelin");
               end if;
         ELSE p := p.suivP ;
         END IF;

      else put_line ("le coach ne peut pas adopter de poke car son nombre de points est nul");
      END IF;
    else put_line("ce coach ne peut pas adopter de poke car son nombre max de pokes est atteint");        
    end if;   
   ELSE Put_Line ("ce coach n'existe pas");
   END IF;

   END Adoption_P ;

end Gestion_Poke;

