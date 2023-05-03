# projetBDL3

création d’un compte par un client et prise d’un abonnement :
(nom, prenom, email, tel, mdp, addr, typeAbonnement)
debut 
    lecture dans compte de l'id du compte avec les même infos
    si compte existe alors
        annulation
    sinon
        insertion dans compte de (nom, prenom, email, tel, mdp, addr), (recuperation num_compte)
    fin si;
    lecture dans type_abonnement de l'id du typeAbonnement
    si typeAbonnement existe alors
        insertion dans abonnement (nouveau_num_compte, num_type_abonnement)
    sinon
        annulation 
    fin si;
fin;

résiliation d’un abonnement par un client (ce qui met fin à toutes ses locations en cours) :

location d’un contenu par un abonné :
(compte, nomContenu)
debut
    lecture dans contenu de l'id_contenu du contenu avec le nom nomContenu
    si contenu existe alors
        lecture dans type_abonnement du nbMax de location du compte
        lecture dans loue du nombre de location courante du compte
        si nb_location < nbMax alors
            insertion dans location (id_compte, id_contenu, date_courante, date_courante + )
        sinon
            nombre de location insuffisant
        fin si;
    sinon
        contenu innexistant
    fin si;
fin;

suppression d’un contenu par un administrateur sur la plateforme (ce qui met fin à toutes les
locations en cours de ce contenu) :
debut
    lecture dans contenu
    si contenu existe alors
        lecture dans loue
        si  alors
            insertion dans location
        sinon
            nombre de location insuffisant
        fin si;
    sinon
        contenu innexistant
    fin si;
fin;