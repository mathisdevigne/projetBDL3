
/* Contrainte 1 : un lien vers une bande annonce doit commencer par http */

ALTER TABLE CONTENU ADD CONSTRAINT C_CONTENU_LIEN CHECK(INSTR(LIEN, 'http') = 1);


/* Contrainte 2 : l'evaluation sur un contenu doit être comprise entre 0 et 5 */

ALTER TABLE CONTENU ADD CONSTRAINT C_CONTENU_EVAL CHECK(EVALUATION >= 0 AND EVALUATION <=5);


/* Contrainte 3 : l'année de production doit être supérieure à 1900 */

ALTER TABLE CONTENU ADD CONSTRAINT C_CONTENU_ANNEEPROD CHECK(ANNEEPROD > 1900);


/* Contrainte 4 : les mots de passe doivent avoir au moins 8 caractères, contenir des lettres et des chiffres et inclure au moins une majuscule et un caractère spécial */

ALTER TABLE COMPTE ADD CONSTRAINT C_COMPTE_MDPte2sata CHECK(LENGTH(MDP) >= 8 
    AND REGEXP_LIKE(MDP, '.*[0-9].*')
    AND REGEXP_LIKE(MDP, '.*[^a-zA-Z0-9].*')
    AND REGEXP_LIKE(MDP, '.*[a-z].*')
    AND REGEXP_LIKE(MDP, '.*[A-Z].*'));
    
/* Contrainte 5 : . les contenus pour la jeunesse ne peuvent pas être des contenus moins de 16 ou moins de 18 ans */

CREATE OR REPLACE TRIGGER T_CONTENU_AGECLAS
BEFORE UPDATE OR INSERT ON CONTENU
FOR EACH ROW
DECLARE
    idClassInterdite INTEGER;
    idClassInterdite = (SELECT age FROM users WHERE name = 'Bill'); 
BEGIN
    IF (:new.type = 'Jeunesse' AND (:new.rating = '-18' OR :new.rating = '-16')) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Un contenu Jeunesse ne peut pas être -16 ou -18');
    END IF;
END;
/