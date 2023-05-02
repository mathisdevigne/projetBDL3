------------------------------------------------------------
-- Script création des clients
------------------------------------------------------------

------------------------------------------------------------
-- Suppression des données
------------------------------------------------------------
delete from abonnement;
delete from type_abonnement;
delete from achat;
delete from loue;
delete from compte;
delete from adresse;

------------------------------------------------------------
-- Insertion des données
------------------------------------------------------------

------------------------------------------------------------
-- Type d'abonnement
------------------------------------------------------------
insert into type_abonnement (id, nom,coutParMois,nombreContenu)
values (1, 'Basique', 7.95,2);

insert into type_abonnement (id, nom,coutParMois,nombreContenu)
values (2, 'Premium', 14.95, 5);

insert into type_abonnement (id, nom,coutParMois,nombreContenu)
values (3, 'VIP', 19.99, 10);


------------------------------------------------------------
-- Client
------------------------------------------------------------

-- Client 1
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (1, 1, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (1, 'Dupont', 'Jean', 'dupontj@mail.com', '0606060606', 'mdp', 1);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (1, 1, to_date('05/05/2023', 'dd/mm/yyyy'), to_date('06/06/2023', 'dd/mm/yyyy'));

insert into achat (compte, refContenu)
values (1, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (1, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (1, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

-- Client 2
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (2, 2, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (2, 'Dupont', 'Charles', 'dupontc@mail.com', '0606060605', 'mdp', 2);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (2, 1, to_date('05/05/2023', 'dd/mm/yyyy'), to_date('06/06/2023', 'dd/mm/yyyy'));

insert into achat (compte, refContenu)
values (2, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (2, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (2, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

-- Client 3
------------------------------------------------------------
insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (3, 'Dupont', 'Marlaine', 'dupontm@mail.com', '0606060605', 'mdp', 2);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (3, 1, to_date('05/05/2023', 'dd/mm/yyyy'), to_date('06/06/2023', 'dd/mm/yyyy'));

insert into achat (compte, refContenu)
values (3, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (3, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (3, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );
    
-- Client 4
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (3, 3, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (4, 'Durant', 'Jean', 'durantj@mail.com', '0606060605', 'mdp', 3);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (4, 2, to_date('01/05/2023', 'dd/mm/yyyy'), to_date('02/08/2023', 'dd/mm/yyyy'));

insert into loue (compte, refContenu, dateFin)
values (4, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (4, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (4, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

-- Client 5
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (4, 4, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (5, 'Durant', 'Paul', 'durantp@mail.com', '0606060505', 'mdp', 4);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (5, 2, to_date('01/05/2023', 'dd/mm/yyyy'), to_date('02/06/2023', 'dd/mm/yyyy'));

insert into loue (compte, refContenu, dateFin)
values (5, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (5, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (5, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

-- Client 6
------------------------------------------------------------
insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (6, 'Durant', 'Jeanne', 'durantj@mail.com', '0606060505', 'mdp', 4);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (6, 1, to_date('01/05/2023', 'dd/mm/yyyy'), to_date('02/07/2023', 'dd/mm/yyyy'));

insert into loue (compte, refContenu, dateFin)
values (6, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (6, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (6, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

-- Client 7
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (5, 5, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (7, 'Smith', 'John', 'smithj@mail.com', '0606050505', 'mdp', 5);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (7, 1, to_date('01/06/2023', 'dd/mm/yyyy'), to_date('02/07/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (7, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );


insert into achat (compte, refContenu)
values (7, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (7, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/05/2023', 'dd/mm/yyyy')
        );

-- Client 8
insert into adresse (id, numero, ville, codePostal, rue) 
values (6, 6, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (8, 'Smith', 'John', 'smithj@mail.com', '0606050505', 'mdp', 6);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (8, 3, to_date('01/06/2023', 'dd/mm/yyyy'), to_date('02/10/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (8, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );


insert into achat (compte, refContenu)
values (8, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (8, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

-- Client 9
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (7, 7, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (9, 'Smith', 'Bertrant', 'smithb@mail.com', '0606050505', 'mdp', 7);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (9, 2, to_date('01/06/2023', 'dd/mm/yyyy'), to_date('02/09/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (9, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (9, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (9, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

-- Client 10
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (8, 8, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (10, 'Smith', 'Eleonore', 'smithe@mail.com', '0606050505', 'mdp', 8);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (10, 2, to_date('01/06/2023', 'dd/mm/yyyy'), to_date('02/09/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (10, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (10, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (10, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/06/2023', 'dd/mm/yyyy')
        );

-- Client 11
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (9, 9, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (11, 'Bernard', 'Anais', 'bernarda@mail.com', '0606050505', 'mdp', 9);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (11, 2, to_date('01/07/2023', 'dd/mm/yyyy'), to_date('02/09/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (11, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (11, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (11, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/08/2023', 'dd/mm/yyyy')
        );

-- Client 12
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (10, 10, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (12, 'Bernard', 'Lucas', 'bernardl@mail.com', '0605050505', 'mdp', 10);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (12, 1, to_date('01/06/2023', 'dd/mm/yyyy'), to_date('02/08/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (12, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (12, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('01/08/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (12, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/06/2023', 'dd/mm/yyyy')
        );

-- Client 13
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (11, 11, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (13, 'Moreau', 'Lucas', 'moreaul@mail.com', '0605050505', 'mdp', 11);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (13, 3, to_date('01/05/2023', 'dd/mm/yyyy'), to_date('02/09/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (13, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (13, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (13, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

-- Client 14
------------------------------------------------------------
insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (14, 'Moreau', 'Albert', 'moreaua@mail.com', '0605050505', 'mdp', 11);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (14, 2, to_date('01/08/2023', 'dd/mm/yyyy'), to_date('02/09/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (14, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (14, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into achat (compte, refContenu)
values (14, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

-- Client 15
------------------------------------------------------------
insert into adresse (id, numero, ville, codePostal, rue) 
values (12, 12, 'Poitiers', 86000, 'Avenue de la Paix');

insert into compte(id, nom, prenom, email, tel, mdp, adresse)
values (15, 'Dubois', 'Pierre', 'duboisp@mail.com', '0605050605', 'mdp', 12);

insert into abonnement (idCompte,typeAbonnement,dateDeb,dateFin)
values (15, 1, to_date('01/07/2023', 'dd/mm/yyyy'), to_date('02/08/2023', 'dd/mm/yyyy'));


insert into achat (compte, refContenu)
values (15, (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1)
        );

insert into loue (compte, refContenu, dateFin)
values (15, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('21/07/2023', 'dd/mm/yyyy')
        );

insert into loue (compte, refContenu, dateFin)
values (15, 
        (SELECT ref FROM
            (SELECT ref FROM contenu
            ORDER BY dbms_random.value)
            WHERE rownum = 1
        ),
        to_date('15/07/2023', 'dd/mm/yyyy')
        );