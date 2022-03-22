PACKAGE BODY Gestion_Guildes IS



   PROCEDURE Newguilde (
         G :    OUT T_Guilde) IS

      K : Integer;
   BEGIN
      Put_Line("Nom: ");
      Get_Line(G.Nomg,K);
      Put("Felicitations! ");
      Put(G.Nomg(1..K));
      Put(
         " est officielement reconnue comme une guilde Poke, devenez les meilleurs!");
      New_Line;
      Put(G.Nomg(1..K));
      Put(" possede");
      Put(G.Nb_Membres,3);
      Put(" membres");
      Put(" et ");
      Put(G.Pointsg,3);
      Put(" points ");
      New_Line;

   END Newguilde;

   FUNCTION Guilde_Existe (
         Liste_G : IN     T_PtG;
         Guilde  : IN     T_Guilde)
     RETURN Boolean IS

      P : T_PtG := Liste_G;

   BEGIN

      IF P /= NULL THEN
         IF P.Guilde.NomG = Guilde.NomG THEN
            RETURN True;
         ELSE
            P := P.SuivG ;
         END IF;
      END IF;
      RETURN False;

   END Guilde_Existe;



   PROCEDURE Insertion_ListeG (
         Liste_G : IN OUT T_PtG;
         Guilde  : IN     T_Guilde) IS

   BEGIN
      IF NOT Guilde_Existe(Liste_G, Guilde) THEN
         IF Liste_G = NULL THEN
            Liste_G:= NEW T_CellG'(Guilde, NULL);
         ELSE
            Liste_G:= NEW T_CellG'(Guilde, Liste_G);
         END IF;
      ELSE
         Put_Line ("une guilde a ce nom existe deja...");
      END IF;

   END Insertion_ListeG;





   PROCEDURE Dissolution (
         Liste_G : IN     T_PtG;
         Guilde  : IN     T_Guilde) IS
      P : T_PtG := Liste_G;

   BEGIN
      IF Guilde_Existe (Liste_G,Guilde) THEN
         WHILE P /= NULL LOOP
            IF P.Guilde.NomG = Guilde.NomG THEN
               IF P.Suivg/=NULL THEN
                  P:=P.Suivg;
               ELSE
                  P:=NULL;
               END IF;
               Put_Line(
                  "La guilde a ete dissoute, mais ne desesperez pas! Aprenez de vos erreurs, et le futur brillera pour vous ");
            ELSE
               P := P.SuivG ;

            END IF;
         END LOOP;

      ELSE
         Put_Line(
            "La guilde n'a pas ete trouvee dans la liste, elle ne peut donc pas etre supprimee");

      END IF;

   END Dissolution;



   PROCEDURE VisuG (
         F : IN     T_Ptg) IS

   BEGIN
      IF F/=NULL  THEN
         IF F.Guilde.Dissoute=False THEN
            Put("Nom de la guilde: ");
            Put(F.Guilde.Nomg);
            New_Line;
            Put("Nombre de membres: ");
            Put(F.Guilde.Nb_Membres,3);
            New_Line;
            Put("Points de la guilde:");
            Put(F.Guilde.Pointsg,3);
            New_Line;
         ELSE
            Visug(F.Suivg);
         END IF;
      ELSE
         Put_Line("Il n'y a pas de guildes a ce moment...");
      END IF;

   END Visug;

END Gestion_Guildes;
