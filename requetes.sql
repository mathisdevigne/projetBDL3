-----------------------------------------------------------
-- Script requetes
-----------------------------------------------------------

-- 1. Liste par ordre alphabétique des titres de contenu dont le thème principal comprend le mot Anime ou Fantasy.
----------------------------------------------------------------------------------------------------------------------
SELECT distinct titre
FROM Contenu c, Theme t
WHERE t.nomTheme LIKE '%Anime%' OR t.nomTheme LIKE '%Fantasy%' AND
	c.themePrincipal = t.idTheme
ORDER BY titre ASC;

-- 2. Liste (titre et thème) des contenus empruntés par Dupont entre janvier et mars 2022.
----------------------------------------------------------------------------------------------------------------------
SELECT c.titre, t.nomTheme
FROM Contenu c, Theme t, Loue l, Compte com
WHERE com.nom = 'Dupont' AND
	c.ref = l.refContenu AND
	com.id = l.compte AND
	l.dateDebut >= to_date('2022-01-01', 'yyyy-mm-dd') AND 
	l.dateDebut <= to_date('2022-03-31', 'yyyy-mm-dd');

-- 3. Pour chaque abonné, son nombre de contenus empruntés et le nombre qu’il peut encore emprunter compte tenu de son abonnement.
----------------------------------------------------------------------------------------------------------------------
SELECT c.id, COUNT(l.refContenu) AS nb_contenus_empruntés,
	  (abo.nombrecontenu - COUNT(l.refContenu)) AS nb_contenus_restants
FROM Compte c, loue l, type_abonnement abo, abonnement a
WHERE c.id = a.idcompte AND
	  c.id = l.compte AND (l.datefin > sysdate) and
	  a.typeAbonnement = abo.id
GROUP BY (c.id, abo.nombrecontenu)
union
SELECT c.id, 0 AS nb_contenus_empruntés,
	  (abo.nombrecontenu) AS nb_contenus_restants
FROM Compte c, type_abonnement abo, abonnement a
WHERE c.id = a.idcompte ANd
	  a.typeAbonnement = abo.id and
	  c.id not in (SELECT c.id
					FROM Compte c, loue l
					WHERE c.id = l.compte AND 
					(l.datefin > sysdate)
					GROUP BY (c.id))
GROUP BY (c.id, abo.nombrecontenu);

-- 4. Liste (sans doublon) des acteurs ayant tourné un film réalisé par David Fincher; pour chaque acteur vous indiquerez le nombre de films tournés avec ce réalisateur.
----------------------------------------------------------------------------------------------------------------------
SELECT p2.nom, COUNT(DISTINCT j.refContenu) AS nb_films_tournés
FROM Personne p1, Personne p2, joue j, scenarise s
WHERE s.idPers = p1.idPers AND
	s.refContenu = j.refContenu AND
	p1.prenom||' '||p1.nom = 'David Fincher' and
	j.idpers = p2.idpers
GROUP BY p2.nom;

-- 5. Le ou les réalisateurs ayant réalisé le plus de contenus.
----------------------------------------------------------------------------------------------------------------------
SELECT p.nom, COUNT(*) as nb_contenus_realisés 
FROM Personne p, realise r, Contenu c
WHERE p.idPers = r.idPers AND
	r.refContenu = c.ref 
GROUP BY p.nom
ORDER BY nb_contenus_realisés DESC
FETCH FIRST 1 ROWS ONLY;

-- 6. Liste des acteurs ayant joué dans plus de 5 films.
----------------------------------------------------------------------------------------------------------------------
SELECT p.nom, COUNT(j.idPers) as nb_films_joués
FROM Personne p, joue j
WHERE p.idPers = j.idPers
GROUP BY p.nom
HAVING COUNT(j.idPers) > 5;

-- 7. Pour chaque contenu, nombre de fois où il a été loué.
----------------------------------------------------------------------------------------------------------------------
SELECT c.titre, COUNT(l.refContenu) as nb_locations
FROM Contenu c, loue l
WHERE c.ref = l.refContenu
GROUP BY c.titre;

-- 8. Liste des réalisateurs ayant réalisé plus de deux contenus moins de 16 ou moins de 18 ans.
----------------------------------------------------------------------------------------------------------------------
SELECT p.nom, COUNT(distinct c.ref) as nb_contenus
FROM Personne p, Contenu c, classification cla, scenarise s
WHERE p.idPers = s.idPers AND
	  s.refcontenu = c.ref and
	c.classification = cla.idClassification AND
	(cla.nomClassification = '-16' OR cla.nomClassification = '-18')
GROUP BY p.nom
HAVING COUNT(distinct c.ref) > 2;

-- 9. Liste des clients habitant la même ville que Dupont.
----------------------------------------------------------------------------------------------------------------------
SELECT distinct c2.id, c2.nom, c2.prenom
FROM adresse a1, adresse a2, compte c1, compte c2
WHERE  c1.adresse = a1.id AND	
	   upper(c1.nom) = 'DUPONT' and 
	   c2.adresse = a2.id and
	   a2.ville = a1.ville
;

-- 10. Nombre de réalisateurs n’ayant pas réalisé de contenus sur le thème Comedies.
----------------------------------------------------------------------------------------------------------------------
SELECT COUNT(distinct s.idpers) AS nb_realisateurs
FROM scenarise s
WHERE s.idPers NOT IN (
	SELECT DISTINCT s.idPers
	FROM scenarise s, theme t, personne p, contenu c
	WHERE t.nomTheme = 'Comedies' AND 
		p.idPers = s.idPers AND
		c.ref = s.refContenu AND
		c.themePrincipal = t.idTheme
);

-- 11. Liste des clients n’ayant jamais loué de contenus.
----------------------------------------------------------------------------------------------------------------------
SELECT c.nom, c.prenom
FROM compte c, loue l
WHERE c.id not in (select c.id
				   from compte c, loue l
				   where l.compte = c.id)
group by (c.nom, c.prenom);

-- 12. Liste des contenus français pour la jeunesse n’ayant jamais été empruntés.
----------------------------------------------------------------------------------------------------------------------
SELECT c.titre
FROM contenu c, contenu_type ct
WHERE c.pays = 'France' AND
	ct.idcontenutype = c.type AND
	ct.nomtype =  'Jeunesse' AND
	c.ref not in (select c.ref
				  from contenu c, loue l
				  where c.ref = l.refcontenu)
;

-- 13. Liste des abonnés VIP ayant loué au moins une fois un divertissement au cours des 3 derniers mois.
----------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT c.nom, c.prenom
FROM compte c, abonnement a, type_abonnement t, contenu con, loue l, theme th
WHERE a.idCompte = c.id AND
	a.typeAbonnement = t.id AND
	t.nom = 'VIP' AND
	l.compte = c.id AND
	con.themePrincipal = th.idTheme AND
	th.nomTheme = 'Divertissement' AND
	l.dateDebut >= add_months(sysdate, -3);

-- 14. Liste des réalisateurs dont le nombre de réalisation est supérieur au nombre moyen de réalisations.
----------------------------------------------------------------------------------------------------------------------
SELECT p.nom, p.prenom, COUNT(c.ref) AS nb_realisations
FROM personne p, contenu c, realise r
WHERE r.refContenu = c.ref AND
	p.idPers = r.idPers
GROUP BY (p.nom, p.prenom)
HAVING COUNT(c.ref) > (SELECT AVG(COUNT(c.ref)) FROM contenu c GROUP BY c.ref);

-- 15. Liste des réalisateurs ayant réalisé des contenu de thèmes "Sci-Fi & Fantasy" et "TV Action & Adventure".
----------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT p.nom, p.prenom
FROM personne p, scenarise r, contenu c, theme t, mot_clef mc
WHERE mc.idtheme = t.idTheme AND
	t.nomTheme IN ('Sci-Fi & Fantasy', 'TV Action & Adventure') and 
	mc.refcontenu = c.ref and 
	p.idPers = r.idPers AND
	c.ref = r.refContenu
GROUP BY p.nom, p.prenom
HAVING COUNT(distinct t.nomtheme) = 2;

-- 16. Le ou les réalisateurs ayant réalisé le ou les films les plus loués
----------------------------------------------------------------------------------------------------------------------

SELECT p.nom, c.titre, count(l.refContenu) as nb_locations
FROM scenarise s, contenu c, loue l, personne p
WHERE c.ref = s.refContenu AND 
	  l.refContenu = c.ref and 
	  p.idpers = s.idpers
GROUP BY p.nom, c.titre, l.refcontenu
HAVING count(l.refContenu) = (SELECT MAX(count(l.refContenu)) 
							FROM scenarise s, contenu c, loue l, personne p
							WHERE c.ref = s.refContenu AND 
								l.refContenu = c.ref and 
								p.idpers = s.idpers
							GROUP BY p.nom, c.titre, l.refcontenu);

-- 17. Liste des films n'ayant aucun mot clé en commun avec le film The Founder
----------------------------------------------------------------------------------------------------------------------

SELECT c.titre
FROM contenu c
WHERE c.titre not in (SELECT distinct c.titre
						FROM contenu c, mot_clef m, theme t
						WHERE ((m.refContenu = c.ref AND t.idTheme = m.idTheme) or c.themeprincipal = t.idtheme) and 
							t.nomtheme = (SELECT distinct t.nomtheme
											FROM contenu c, mot_clef m, theme t
											WHERE c.titre = 'The Founder' and 
											((m.refContenu = c.ref AND t.idTheme = m.idTheme) or c.themeprincipal = t.idtheme))
					  );

-- 18. Liste des films ayant au moins un mot clé en commun avec le film The Founder
----------------------------------------------------------------------------------------------------------------------

SELECT distinct c.titre
FROM contenu c, mot_clef m, theme t
WHERE ((m.refContenu = c.ref AND t.idTheme = m.idTheme) or c.themeprincipal = t.idtheme) and 
	t.nomtheme = (SELECT distinct t.nomtheme
					FROM contenu c, mot_clef m, theme t
					WHERE c.titre = 'The Founder' and 
					((m.refContenu = c.ref AND t.idTheme = m.idTheme) or c.themeprincipal = t.idtheme))
;

-- 19. Liste des films ayant au moins les mêmes mots clés que le film The Founder
----------------------------------------------------------------------------------------------------------------------

SELECT c.titre
FROM contenu c, mot_clef mc, theme t
WHERE c.ref <> (SELECT c2.ref FROM contenu c2 WHERE c2.titre = 'The Founder')
	AND mc.refContenu = c.ref AND t.idTheme = mc.idTheme
	AND t.nomTheme IN (SELECT t.nomTheme
					  FROM contenu c, mot_clef mc, theme t
					  WHERE mc.refContenu = c.ref AND t.idTheme = mc.idTheme
							AND c.titre = 'The Founder');

-- 20. Liste des films ayant exactement les mêmes mots clés que le film The Founder
----------------------------------------------------------------------------------------------------------------------

SELECT c.titre
FROM contenu c, mot_clef mc, theme t
WHERE c.ref <> (SELECT c2.ref FROM contenu c2 WHERE c2.titre = 'The Founder')
	AND mc.refContenu = c.ref AND t.idTheme = mc.idTheme
	AND t.nomTheme = (SELECT t.nomTheme
					  FROM contenu c, mot_clef mc, theme t
					  WHERE mc.refContenu = c.ref AND t.idTheme = mc.idTheme
							AND c.titre = 'The Founder');




