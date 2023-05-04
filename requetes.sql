SELECT titre
FROM Contenu c, Theme t
WHERE t.nomTheme LIKE '%Anime%' OR t.nomTheme LIKE '%Fantasy%' AND
	c.themePrincipal = t.idTheme
ORDER BY titre ASC;

SELECT c.titre t.nomTheme
FROM Contenu c, Theme t, Loue l, Compte com
WHERE com.nom = 'Dupont' AND
	c.ref = l.refContenu AND
	com.id = l.compte AND
	l.dateDebut >= '2022-01-01' AND l.dateDebut <= '2022-03-31';

SELECT c.id, COUNT(l.refContenu) AS nb_contenus_empruntés
CASE abo.nom
	WHEN 'Basique' THEN 2 - COUNT(l.refContenu)
	WHEN 'Premium' THEN 5 - COUNT(l.refContenu)
	WHEN 'VIP'     THEN 10 - COUNT(l.refContenu)
END AS nb_contenus_restants
FROM Compte c, loue l, type_abonnement abo, abonnement a
WHERE c.id = l.compte AND
	c.id = a.idCompte AND
	a.typeAbonnement = abo.id
GROUP BY c.id;

SELECT p.nom, COUNT(DISTINCT j.refContenu) AS nb_films_tournés
FROM Personne p, joue j, realise r
WHERE r.idPers = p.idPers AND
	r.refContenu = j.refContenu AND
	p.nom = 'David Fincher'
GROUP BY p.nom;

SELECT p.nom, COUNT(*) as nb_contenus_realisés 
FROM Personne p, realise r, Contenu c
WHERE p.idPers = r.idPers AND
	r.refContenu = c.ref 
GROUP BY p.nom
ORDER BY nb_contenus_realisés DESC
LIMIT 1;

SELECT p.nom, COUNT(j.idPers) as nb_films_joués
FROM Personne p, joue j
WHERE p.idPers = j.idPers
GROUP BY p.nom
HAVING COUNT(j.idPers) > 5;

SELECT c.titre, COUNT(l.refContenu) as nb_locations
FROM Contenu c, loue l
WHERE c.ref = l.refContenu
GROUP BY c.titre;

SELECT p.nom, COUNT(*) as nb_contenus
FROM Personne p, realise r, Contenu c, classification cla
WHERE p.id = r.idPers AND
	c.classification = cla.idClassification AND
	cla.nomClassification = -16 OR cla.nomClassification = -18
GROUP BY p.nom
HAVING COUNT(*) > 2;

SELECT *
FROM Personne p, adresse a, compte c
WHERE a.adresse = (SELECT a.adresse FROM adresse a, compte c 
					WHERE c.adresse = a.id AND	
						c.nom = 'DUPONT');

SELECT COUNT(*) AS nb_realisateurs
FROM realise
WHERE realise.idPers NOT IN (
	SELECT DISTINCT r.idPers
	FROM realise r, theme t, personne p, contenu c
	WHERE t.nomTheme = 'Comedies' AND 
		p.idPers = r.idPers AND
		c.ref = r.refContenu AND
		c.themePrincipal = t.idTheme
)

SELECT c.nom, c.prenom
FROM compte c, loue l, contenu con
WHERE l.compte = c.id AND
	l.refContenu = con.ref AND
	l.refContenu IS NULL;

SELECT c.titre
FROM contenu c, loue l, compte con, classification cla
WHERE c.pays = 'France' AND
	cla.nomClassification = 'Tout publics' AND
	c.classification = cla.idClassification AND
	l.compte = con.id AND
	l.refContenu = c.ref AND
	l.refContenu IS NULL;

SELECT DISTINCT c.nom, c.prenom
FROM compte c, abonnement a, type_abonnement t, contenu con, loue l, theme th
WHERE a.idCompte = c.id AND
	a.typeAbonnement = t.id AND
	t.nom = 'VIP' AND
	l.compte = con.id AND
	con.themePrincipal = th.idTheme AND
	th.nomTheme = 'Divertissement' AND
	l.dateDebut >= DATEADD(month, -3, GETDATE());

SELECT p.nom, p.prenom, COUNT(c.ref) AS nb_realisations
FROM personne p, contenu c, realise r
WHERE r.refContenu = c.ref AND
	p.idPers = r.idPers
GROUP BY p.nom
HAVING COUNT(c.ref) > (SELECT AVG(nb) FROM (COUNT(c.ref) AS nb FROM contenu c GROUP BY c.ref) AS subquery);

/* REQUETE 15 */

/* REQUETE 16 */

/* REQUETE 17, j'ai un doute sur comment marche les mots cle */

/* REQUETE 18, meme pb */

/* REQUETE 19, t'as compris */

/* REQUETE 20, bon ok c'est tj la meme */




