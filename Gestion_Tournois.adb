

PACKAGE BODY gestion_tournois IS
   
   -- procedure qui verifie qu'un coach a au moins 1 poke non KO
   
   FUNCTION Non_KO (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) RETURN Boolean IS
      PC : T_PtC := ListeC;
      pP : T_PtP := ListeP;
   
   BEGIN
      
      WHILE pC/=NULL LOOP
         IF PC.Coach.NomC = C.NomC THEN 
            WHILE PP/=NULL LOOP
               IF Pp.Poke.Coach = C.NomC AND THEN Pp.poke.KO = false THEN RETURN True;
               ELSE PP:= PP.SuivP;
               END IF;
               return false;
            END LOOP;
         ELSE PC:=PC.SuivC;
         END IF;
         return false;
      END LOOP;
      
   END Non_KO;
   
   -- procedure qui choisi aléatoirement 1 poke non KO chez un coach
   
   FUNCTION Poke_Aleatoire (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) return T_PtP IS
   P : T_PtP := ListeP;
      NumP : Integer; -- Numero Du Poke Aleatoire
      aux : integer := 0;
   BEGIN
      
      IF Non_KO(ListeC, ListeP, C) THEN
         Initialise (1,C.Nb_Pokes); NumP:= Random;
         WHILE P/=NULL LOOP
            IF P.poke.Coach=C.NomC THEN Aux := Aux+1;
            END IF;
            IF Aux = NumP THEN return p ; exit;
            end if;
            p:=p.suivP;
         END LOOP; 
      ELSE Put_Line ("ce coach n'a que des pokes KO");
      END IF;
   END Poke_Aleatoire ; 
   

-- actualisation points coach --
   
   PROCEDURE Actua_PtsC (C_Vainqueur,C_perdant : IN T_Coach ; ListeC : IN OUT T_PtC) IS 
      P : T_PtC := ListeC;
      PtsVainq, PtsPerd : Integer;
      Gain : T_Tabl_Expertise;
      
   BEGIN
      
      PtsVainq:= Gain(C_Vainqueur.Expertise);
      
      If C_vainqueur.expertise > C_perdant.expertise then PtsPerd:= 3;
      elsif C_vainqueur.expertise = C_perdant.expertise then PtsPerd:= 2;
      ELSE PtsPerd := 1;
      end if;
      
      WHILE P/=NULL LOOP
         IF P.Coach.NomC = C_Vainqueur.NomC THEN
            P.Coach.PointsC := P.Coach.PointsC + PtsVainq;
            IF P.Coach.PointsC >= 24 THEN P.Coach.expertise := Maitre;
            ELSIF P.Coach.PointsC >= 14 THEN P.Coach.expertise := Expert;
            ELSIF P.Coach.PointsC >= 8 THEN P.Coach.expertise := Confirme;
            ELSE P.Coach.Expertise := Novice;
            end if;
         ELSIF P.Coach.NomC = C_perdant.NomC THEN
            P.Coach.PointsC := P.Coach.PointsC - PtsPerd;
         ELSE P:=P.SuivC;
         END IF;
      END LOOP;
      
   END Actua_PtsC;
      

-- actualisation points guilde --

PROCEDURE Actua_PtsG (C_Vainqueur,C_perdant : IN T_Coach ; ListeG : IN OUT T_PtG ; ListeC : IN T_PtC) IS 
      P : T_PtG := ListeG;
BEGIN
   
      WHILE P/=NULL LOOP
         IF P.guilde.NomG = C_Vainqueur.guilde THEN
            P.guilde.PointsG := P.guilde.PointsG  + 2;
         ELSIF P.guilde.NomG = C_perdant.guilde THEN
         P.Guilde.PointsG := P.Guilde.PointsG  - 2;
         IF P.Guilde.PointsG <=0 THEN Dissolution(ListeG,P.Guilde);
         Sansguilde (ListeC,P.Guilde);
         ELSE P:=P.SuivG;
         end if;
         END IF;
   END LOOP;
   
   END Actua_PtsG;
   
   -- lancer un tournoi --
   

   
   PROCEDURE Lance_Tournoi (C1, C2 : OUT T_coach; P1,P2 : IN OUT T_PtP ; ListeP : IN T_PtP ; ListeC : IN OUT T_PtC; ListeG : IN OUT T_PtG ; stat : IN OUT T_Stats) IS
      E1, E2 : Integer ;
      Max1, Max2 : Integer ;
      BM : T_BM;
      Bonus_Malus : integer;
      K1, K2 : Integer;
      Vainq, Perd : T_PtP;
      C_Vainqueur, C_perdant : T_coach;

   BEGIN

 --eau
BM(Eau,Eau):=0;
BM(Eau,Feu):=4;
BM(Eau,Terre):=-2;
BM(Eau,Air):=-2;

--Feu
BM(Feu,Eau):=-4;
BM(Feu,Feu):=0;
BM(Feu,Terre):=6;
BM(Feu,Air):=-2;

--Terre
BM(Terre,Eau):=2;
BM(Terre,Feu):=-6;
BM(Terre,Terre):=0;
BM(Terre,Air):=4;

--Air
BM(Air,Eau):=2;
BM(Air,Feu):=2;
BM(Air,Terre):=-4;
BM(Air,Air):=0;



      Put_Line("nom du coach : "); get_line(C1.NomC, k1);
      Put_Line("nom de son avdersaire : ");get(C2.NomC);
      

      IF Coach_Existe(ListeC, C1) THEN 
         IF Coach_Existe(ListeC, C2)THEN
            IF C1.NomC/=C2.NomC THEN
               IF C1.Sansguilde OR C2.Sansguilde THEN Put_Line("erreur : l'un des coach n'a pas de guilde");
               else 
               IF C1.PointsC/=0 AND THEN C2.PointsC/= 0 THEN
                  IF Non_KO (ListeC,ListeP,C1)
                   AND THEN Non_KO (ListeC,ListeP,C2)then
               
                 
                   P1 := Poke_Aleatoire(ListeC,ListeP,C1);    
                   P2 := Poke_Aleatoire(ListeC,ListeP,C2);             


                  Bonus_Malus := BM(P1.poke.cat, P2.poke.cat);
                  Max1:= Force(C1.Expertise)+Bonus_Malus;
                  Max2:= Force(C2.Expertise)+Bonus_Malus;

                  Initialise (0,Max1); E1:= Random;
                  Initialise (0,Max2); E2:= Random;
                  
                  IF E1 = E2 THEN Put_Line ("match nul ! "); Stat.Nb_Match_Nul := Stat.Nb_Match_Nul+1;
                     ELSIF E1 > E2 THEN Vainq := P1; Perd := P2; 
                     C_Vainqueur := C1 ; C_perdant := C2;
                     Put(P1.Poke.NomP);  Put(" a gagné ! "); new_line;
                     ELSE Vainq := P2; Perd := P1;
                     C_Vainqueur := C2 ; C_perdant := C1;
                     Put(P2.Poke.NomP);  Put(" a gagné ! "); new_line;
                  END IF;

                     IF Perd.poke.PV <=0 THEN P1.poke.PV:=0; P1.poke.KO := True;
                       END IF;
                     
                        Actua_PtsC (C_Vainqueur,C_perdant,ListeC);
                        Actua_PtsG (C_Vainqueur,C_Perdant,ListeG, ListeC) ; 
                        
                        Stat.Nb_Tournois := Stat.Nb_Tournois+1;

                      else put_line("erreur : les coachs doivent avoir au moins 1 poke non KO");
                      end if;
               ELSE Put_Line("erreur : les coachs doivent avoir un nombre de points non nuls");
                  END IF;
                  end if;
            ELSE put_line ("erreur :les deux coachs sont les mêmes");
         end if;
         ELSE Put_Line("erreur : ce coach n'existe pas ...");
         END IF;
     ELSE Put_Line("erreur : ce coach n'existe pas ...");
     END IF;

   END Lance_Tournoi ;
   
   


END gestion_tournois;

-------------- nouvelle version sedna ------------



PACKAGE BODY gestion_tournois IS

   -- procedure qui verifie qu'un coach a au moins 1 poke non KO

   FUNCTION Non_KO (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) RETURN Boolean IS
      PC : T_PtC := ListeC;
      pP : T_PtP := ListeP;

   BEGIN

            WHILE PP/=NULL LOOP
               IF Pp.Poke.Coach = C.NomC AND THEN Pp.poke.KO = false THEN RETURN True;
         END IF;
         PP:= PP.SuivP;

      END LOOP;
      return false;

   END Non_KO;

   -- procedure qui choisi aléatoirement 1 poke non KO chez un coach

   FUNCTION Poke_Aleatoire (ListeC : IN T_PtC ; ListeP : IN T_PtP; C : IN T_Coach) return T_PtP IS
   P : T_PtP := ListeP;
      NumP : Integer; -- Numero Du Poke Aleatoire
      aux : integer := 0;
   BEGIN

      IF Non_KO(ListeC, ListeP, C) THEN
         Initialise (1,C.Nb_Pokes); NumP:= Random;
         WHILE P/=NULL LOOP
            IF P.poke.Coach=C.NomC THEN Aux := Aux+1;
            END IF;
            IF Aux = NumP THEN return p ; exit;
            end if;
            p:=p.suivP;
         END LOOP;
      ELSE Put_Line ("ce coach n'a que des pokes KO");
      END IF;
   END Poke_Aleatoire ;


-- actualisation points coach --

   PROCEDURE Actua_PtsC (C_Vainqueur,C_perdant : IN T_Coach ; ListeC : IN OUT T_PtC) IS
      P : T_PtC := ListeC;
      PtsVainq, PtsPerd : Integer;

   BEGIN

      PtsVainq:= Gain(C_Vainqueur.Expertise);

      If T_expertise'pos(C_vainqueur.expertise) > T_expertise'pos(C_perdant.expertise) then PtsPerd:= 3;
      elsif T_expertise'pos(C_vainqueur.expertise) = T_expertise'pos(C_perdant.expertise) then PtsPerd:= 2;
      ELSE PtsPerd := 1;
      end if;

      WHILE P/=NULL LOOP
         IF P.Coach.NomC = C_Vainqueur.NomC THEN
            P.Coach.PointsC := P.Coach.PointsC + PtsVainq;
            IF P.Coach.PointsC >= 24 THEN P.Coach.expertise := Maitre;
            ELSIF P.Coach.PointsC >= 14 THEN P.Coach.expertise := Expert;
            ELSIF P.Coach.PointsC >= 8 THEN P.Coach.expertise := Confirme;
            ELSE P.Coach.Expertise := Novice;
            end if;
         END IF;
         IF P.Coach.NomC = C_perdant.NomC THEN
            P.Coach.PointsC := P.Coach.PointsC - PtsPerd;
         End if;
          P:=P.SuivC;
      END LOOP;

   END Actua_PtsC;


-- actualisation points guilde --

PROCEDURE Actua_PtsG (C_Vainqueur,C_perdant : IN T_Coach ; ListeG : IN OUT T_PtG ; ListeC : IN T_PtC) IS
      P : T_PtG := ListeG;
BEGIN

      WHILE P/=NULL LOOP
         IF P.Guilde.NomG = C_Vainqueur.Guilde THEN
         P.Guilde.PointsG := P.Guilde.PointsG  + 2;
         ELSIF P.guilde.NomG = C_perdant.guilde THEN
         P.Guilde.PointsG := P.Guilde.PointsG  - 2;
         IF P.Guilde.PointsG <=0 THEN Dissolution(ListeG,P.Guilde);
         Sansguilde (ListeC,P.Guilde);
         END IF;
         END IF;
      P:=P.SuivG;
   END LOOP;

   END Actua_PtsG;

   -- lancer un tournoi --



   PROCEDURE Lance_Tournoi (C1, C2,C_vainqueur, C_perdant : OUT T_coach; P1,P2 : IN OUT T_PtP ; ListeP : IN T_PtP ; ListeC : IN OUT T_PtC; ListeG : IN OUT T_PtG ; stat : IN OUT T_Stats) IS
      E1, E2 : Integer ;
      Max1, Max2 : Integer ;
      BM : T_BM;
      Bonus_Malus : integer;
      K1, K2 : Integer;
      Vainq, Perd : T_PtP;

   BEGIN

 --eau
BM(Eau,Eau):=0;
BM(Eau,Feu):=4;
BM(Eau,Terre):=-2;
BM(Eau,Air):=-2;

--Feu
BM(Feu,Eau):=-4;
BM(Feu,Feu):=0;
BM(Feu,Terre):=6;
BM(Feu,Air):=-2;

--Terre
BM(Terre,Eau):=2;
BM(Terre,Feu):=-6;
BM(Terre,Terre):=0;
BM(Terre,Air):=4;

--Air
BM(Air,Eau):=2;
BM(Air,Feu):=2;
BM(Air,Terre):=-4;
BM(Air,Air):=0;



      Put_Line("nom du coach : "); get_line(C1.NomC, k1);


      IF Coach_Existe(ListeC, C1) THEN
               Put_Line("nom de son avdersaire : ");get_line(C2.NomC, k2);
         IF Coach_Existe(ListeC, C2)THEN
            IF C1.NomC/=C2.NomC THEN
               IF C1.Sansguilde OR C2.Sansguilde THEN Put_Line("erreur : l'un des coach n'a pas de guilde");
               else
               IF C1.PointsC/=0 AND THEN C2.PointsC/= 0 THEN
                  IF Non_KO (ListeC,ListeP,C1)
                   AND Non_KO (ListeC,ListeP,C2)then


                   P1 := Poke_Aleatoire(ListeC,ListeP,C1);
                   P2 := Poke_Aleatoire(ListeC,ListeP,C2);


                  Bonus_Malus := BM(P1.poke.cat, P2.poke.cat);
                  Max1:= Force(C1.Expertise)+Bonus_Malus;
                  Max2:= Force(C2.Expertise)+Bonus_Malus;

                  Initialise (0,Max1); E1:= Random;
                  Initialise (0,Max2); E2:= Random;

                  IF E1 = E2 THEN Put_Line ("match nul ! "); Stat.Nb_Match_Nul := Stat.Nb_Match_Nul+1;
                     ELSIF E1 > E2 THEN Vainq := P1; Perd := P2;
                     C_Vainqueur := C1 ; C_perdant := C2;
                     Put(P1.Poke.NomP);  Put(" a gagne ! "); new_line;
                     ELSE Vainq := P2; Perd := P1;
                     C_Vainqueur := C2 ; C_perdant := C1;
                     Put(P2.Poke.NomP);  Put(" a gagne ! "); new_line;
                  END IF;

--                     IF Perd.poke.PV <=0 THEN P1.poke.PV:=0; P1.poke.KO := True;
--                       END IF;

                        Stat.Nb_Tournois := Stat.Nb_Tournois+1;
                       Actua_PtsG (C_Vainqueur,C_perdant,ListeG,ListeC);
                          Actua_PtsC (C_Vainqueur,C_perdant,ListeC);

                      else put_line("erreur : les coachs doivent avoir au moins 1 poke non KO");
                      end if;
               ELSE Put_Line("erreur : les coachs doivent avoir un nombre de points non nuls");
                  END IF;
                  end if;
            ELSE put_line ("erreur :les deux coachs sont les mêmes");
         end if;
         ELSE Put_Line("erreur : ce coach n'existe pas ...");
         END IF;
     ELSE Put_Line("erreur : ce coach n'existe pas ...");
     END IF;

   END Lance_Tournoi ;




END gestion_tournois;








