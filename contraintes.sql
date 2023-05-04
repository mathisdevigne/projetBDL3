
/* Contrainte 1 : un lien vers une bande annonce doit commencer par http */

ALTER TABLE CONTENU ADD CONSTRAINT CHK_CONTENU_LIEN CHECK(INSTR(LIEN, 'http') = 1);


/* Contrainte 2 : l'evaluation sur un contenu doit être comprise entre 0 et 5 */

ALTER TABLE CONTENU ADD CONSTRAINT CHK_CONTENU_EVAL CHECK(EVALUATION >= 0 AND EVALUATION <=5);


/* Contrainte 3 : l'année de production doit être supérieure à 1900 */

ALTER TABLE CONTENU ADD CONSTRAINT CHK_CONTENU_ANNEEPROD CHECK(ANNEEPROD > 1900);


/* Contrainte 4 : les mots de passe doivent avoir au moins 8 caractères, contenir des lettres et des chiffres et inclure au moins une majuscule et un caractère spécial */

ALTER TABLE COMPTE ADD CONSTRAINT CHK_COMPTE_MDP CHECK(LENGTH(MDP) >= 8 
    AND REGEXP_LIKE(MDP, '.*[0-9].*')
    AND REGEXP_LIKE(MDP, '.*[^a-zA-Z0-9].*')
    AND REGEXP_LIKE(MDP, '.*[a-z].*')
    AND REGEXP_LIKE(MDP, '.*[A-Z].*'));
    
/* Contrainte 5 : . les contenus pour la jeunesse ne peuvent pas être des contenus moins de 16 ou moins de 18 ans */

CREATE OR REPLACE TRIGGER TRIG_CONTENU_AGECLAS
BEFORE UPDATE OR INSERT ON CONTENU
FOR EACH ROW
DECLARE 
    nomTypeContenu varchar2(20);
    nomClassficationContenu varchar2(12);
BEGIN
    SELECT nomType INTO nomTypeContenu FROM contenu_type WHERE idContenuType = :new.type;
    SELECT nomClassification INTO nomClassficationContenu FROM classification WHERE idClassification = :new.classification;
    IF (nomTypeContenu = 'Jeunesse' AND nomClassficationContenu IN ('-16', '-18')) THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRIG_CONTENU_AGECLAS: Un contenu Jeunesse ne peut pas être classé -16 ou -18.');
    END IF;
END;
/


/* Contrainte 6 : le nombre de locations des abonnés doit être inférieur ou égal à celui autorisé par leurs abonnements */

CREATE OR REPLACE TRIGGER TRIG_LOUE_ABO
BEFORE UPDATE OR INSERT ON LOUE
FOR EACH ROW
DECLARE 
    nombreMaxAbo integer;
    nombreLocEnCours integer;
BEGIN
    SELECT nombreContenu INTO nombreMaxAbo FROM type_abonnement WHERE id = (SELECT typeAbonnement FROM abonnement WHERE idCompte = :new.compte);
    SELECT count(*) INTO nombreLocEnCours FROM loue l WHERE l.compte = :new.compte AND l.dateFin > sysdate;
    IF (nombreLocEnCours >= nombreMaxAbo) THEN
        RAISE_APPLICATION_ERROR(-20002, 'TRIG_LOUE_ABO: Le nombre maximum de location est atteint.');
    END IF;
END;
/


/* Contrainte 7 : un client ne peut pas avoir deux abonnements en même temps ; */

CREATE OR REPLACE TRIGGER TRIG_DEUX_ABO
BEFORE UPDATE OR INSERT ON abonnement
FOR EACH ROW
DECLARE 
    nombreAboEnCours integer;
BEGIN
    SELECT count(*) INTO nombreAboEnCours FROM abonnement  WHERE idCompte = :new.idCompte AND 
    ((dateDeb between :new.dateDeb and :new.dateFin) OR (dateFin between :new.dateDeb and :new.dateFin));
    IF (nombreAboEnCours > 0) THEN
        RAISE_APPLICATION_ERROR(-20002, 'TRIG_DEUX_ABO: Le nombre maximum d''abonnement est atteint.');
    END IF;
END;
/


/* Contrainte 8 : un abonné ne peut pas louer un contenu si la date de location pour ce contenu est dépassée */

CREATE OR REPLACE TRIGGER TRIG_LOC_CONT
BEFORE UPDATE OR INSERT ON loue
FOR EACH ROW
DECLARE 
    typeAbo integer;
    typeCont integer;
    dureeLoc integer;
BEGIN
    select typeAbonnement into typeAbo from abonnement where idCompte = :new.compte and dateFin > sysdate;
    select type into typeCont from contenu where ref = :new.refContenu;
    select duree into dureeLoc from duree_location where idContenuType = typeCont and typeAbonnement = typeAbo;
    IF (EXTRACT(DAY FROM :new.dateFin) - EXTRACT(DAY FROM :new.dateDebut) > dureeLoc*7 ) THEN
        RAISE_APPLICATION_ERROR(-20003, 'TRIG_LOC_CONT: La duree de la location est trop grande.');
    END IF;
END;
/



select * from duree_location;







    
    
    
    
    