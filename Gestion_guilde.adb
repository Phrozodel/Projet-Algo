PACKAGE BODY Gestion_Guildes IS

   PROCEDURE Enfiler_Guilde (
         F : IN OUT T_Fileg;
         G : IN     T_Guilde) IS

   BEGIN
      IF F.Teteg=NULL THEN
         F.Teteg:= NEW T_Cellg'(G,NULL);
         F.Fing:=F.Teteg;
      ELSE
         F.Fing.Suiv:= NEW T_Cellg'(G,NULL);
         F.Fing:= F.Fing.Suiv;
      END IF;

   END Enfiler_Guilde;

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


   PROCEDURE Dissolution (
         F :        T_Ptg;
         G : IN OUT T_Guilde) IS
      --rendre les coach sansguilde necessite parcourir la liste des coach, comment faire pour eviter dependance ciculaire? mettre dissolution des guildes ds package coach?

   BEGIN
      IF F/=NULL THEN
         IF F.Guilde=G THEN
            F.Guilde.Dissoute:= True;
            Put("La guilde ");
            Put(G.Nomg);
            Put(
               " a ete dissoute, mais ne desesperez pas! Aprenez de vos erreurs, et le futur brillera pour vous ");
         ELSIF F.Suiv/=NULL THEN
            Dissolution(F.Suiv,G);
         ELSE
            Put_Line("Cette guilde n'existe pas");
         END IF;
      END IF;
   END Dissolution;

   PROCEDURE Newguilde_Coach (
         G      : IN OUT T_Guilde;
         C      : IN OUT T_Coach;
         Erreur :    OUT Boolean) IS

   BEGIN
      IF C.Sansguilde THEN
         G.Nb_Membres:=G.Nb_Membres+1;
         C.Guilde:=G;
         G.Pointsg:=G.Pointsg-1;
         Put_Line("Felicitations pour le recrutement!");
      ELSE
         Erreur:=True;
      END IF;
   END Newguilde_Coach;

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
            Visug(F.Suiv);
         END IF;
      ELSE
         Put_Line("Il n'y a pas de guildes a ce moment...");
      END IF;

   END Visug;

END Gestion_Guildes;
