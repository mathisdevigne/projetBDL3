--------------------------------------------------------------------------------
-- Contenus
--------------------------------------------------------------------------------
-- Table Theme
drop table theme cascade constraints;
create table theme (
    idTheme integer generated by default on null as identity,
    nomTheme varchar2(50) not null,
    constraint PK_THEME primary key (idTheme)
);

-- Table MotClef
drop table mot_clef cascade constraints;
create table mot_clef (
    refContenu integer not null,
    idTheme integer not null,
    constraint PK_MOT_CLEF primary key (refContenu, idTheme),
    constraint FK_MOT_CLEF_CONTENU foreign key (refContenu) references contenu(ref),
    constraint FK_MOT_CLEF_THEME foreign key (idTheme) references theme(idTheme)
);

-- Table Classification
drop table classification cascade constraints;
create table classification (
    idClassification integer generated by default on null as identity,
    nomClassification varchar2(12) not null,
    constraint PK_CLASSIFICATION primary key (idClassification)
);

-- Table Contenu_Type
drop table contenu_type cascade constraints;
create table contenu_type (
    idContenuType integer generated by default on null as identity,
    nomType varchar2(20) not null,
    constraint PK_CONTENU_TYPE primary key (idContenuType)
);

-- Table Contenu
drop table contenu cascade constraints;
create table contenu (
    ref integer generated by default on null as identity,
    titre varchar2(150) not null,
    description varchar2(500) not null,
    duree integer,
    lien varchar2(100),
    evaluation float(2),
    pays varchar2(20),
    anneeProd date not null,
    classification integer not null,
    themePrincipal integer not null,
    type integer not null,
    constraint PK_CONTENU primary key (ref),
    constraint CHK_CONTENU_EVAL check (evaluation >= 0 and evaluation <= 5),
    constraint FK_CLASSIFICATION_CONTENU foreign key (classification) references classification(idClassification),
    constraint FK_THEME_CONTENU foreign key (themePrincipal) references theme(idTheme),
    constraint FK_CONTENU_TYPE_CONTENU foreign key (type) references contenu_type(idContenuType)
);

-- Table Saison
drop table saison cascade constraints;
create table saison (
    serie integer not null,
    saison integer not null,
    constraint PK_SAISON primary key (serie, saison),
    constraint FK_SAISON_SERIE foreign key (serie) references contenu(ref),
    constraint FK_SAISON_SAISON foreign key (saison) references contenu(ref)
); 

--------------------------------------------------------------------------------
-- Tables pour les formats
--------------------------------------------------------------------------------
-- Table TypeMIME 
drop table type_mime cascade constraints;
create table type_mime (
    nomType varchar2(50),
    constraint PK_TYPE_MIME primary key (nomType)
);

-- Table Extension
drop table extension cascade constraints;
create table extension (
    nomExt varchar2(50) not null,
    constraint PK_EXTENSION primary key (nomExt)
);

-- Table Logiciel 
drop table logiciel cascade constraints;
create table logiciel (
    nomLog varchar2(50) not null,
    constraint PK_LOGICIEL primary key (nomLog)
);

-- Table Format 
drop table format cascade constraints;
create table format (
    nomFormat varchar2(50) not null,
    constraint PK_FORMAT primary key (nomFormat)
);

-- Table Format_TypeMIME
drop table format_type_mime cascade constraints;
create table format_type_mime (
    nomFormat varchar2(50) not null,
    nomType varchar2(50) not null,
    constraint PK_FORMAT_TYPE_MIME primary key (nomFormat, nomType),
    constraint FK_FORMAT_FORMAT_TYPE_MIME foreign key (nomFormat) references format(nomFormat),
    constraint FK_TYPE_MIME_FORMAT_TYPE_MIME foreign key (nomType) references type_mime(nomType)
);

-- Table Format_Extension
drop table format_extension cascade constraints;
create table format_extension (
    nomFormat varchar2(50) not null,
    nomExt varchar2(50) not null,
    constraint PK_FORMAT_EXTENSION primary key (nomFormat, nomExt),
    constraint FK_FORMAT_FORMAT_EXTENSION foreign key (nomFormat) references format(nomFormat),
    constraint FK_EXTENSION_FORMAT_EXTENSION foreign key (nomExt) references extension(nomExt)
);

-- Table Format_Logiciel
drop table format_logiciel cascade constraints;
create table format_logiciel (
    nomFormat varchar2(50) not null,
    nomLog varchar2(50) not null,
    constraint PK_FORMAT_LOGICIEL primary key (nomFormat, nomlog),
    constraint FK_FORMAT_FORMAT_LOGICIEL foreign key (nomFormat) references format(nomFormat),
    constraint FK_LOGICIEL_FORMAT_LOGICIEL foreign key (nomLog) references logiciel(nomLog)
);

-- Table Contenu_Format
drop table contenu_format cascade constraints;
create table contenu_format (
    refContenu integer generated by default on null as identity,
    nomFormat varchar2(50) not null,
    constraint PK_CONTENU_FORMAT primary key (nomFormat, refContenu),
    constraint FK_FORMAT_CONTENU_FORMAT foreign key (nomFormat) references format(nomFormat),
    constraint FK_CONTENU_CONTENU_FORMAT foreign key (refContenu) references contenu(ref)
);

--------------------------------------------------------------------------------
-- Personne
--------------------------------------------------------------------------------
-- Table Personne 
drop table personne cascade constraints;
create table personne (
    idPers integer generated by default on null as identity,
    nom varchar2(100) not null,
    prenom varchar2(100),
    dateNaissance date,
    constraint PK_PERSONNE primary key (idPers)
);

-- Table Realise
drop table realise cascade constraints;
create table realise (
    idPers integer not null,
    refContenu integer not null,
    constraint PK_REALISE primary key (idPers, refContenu),
    constraint FK_PERSONNE_REALISE foreign key (idPers) references personne(idPers),
    constraint FK_CONTENU_REALISE foreign key (refContenu) references contenu(ref)
);

-- Table Scenarise
drop table scenarise cascade constraints;
create table scenarise (
    idPers integer not null,
    refContenu integer not null,
    constraint PK_SCENARISE primary key (idPers, refContenu),
    constraint FK_PERSONNE_SCENARISE foreign key (idPers) references personne(idPers),
    constraint FK_CONTENU_SCENARISE foreign key (refContenu) references contenu(ref)
);

-- Table Compose
drop table compose cascade constraints;
create table compose (
    idPers integer not null,
    refContenu integer not null,
    constraint PK_COMPOSE primary key (idPers, refContenu),
    constraint FK_PERSONNE_COMPOSE foreign key (idPers) references personne(idPers),
    constraint FK_CONTENU_COMPOSE foreign key (refContenu) references contenu(ref)
);

-- Table MisEnScene
drop table mis_en_scene cascade constraints;
create table mis_en_scene (
    idPers integer not null,
    refContenu integer not null,
    constraint PK_MIS_EN_SCENE primary key (idPers, refContenu),
    constraint FK_PERSONNE_MIS_EN_SCENE foreign key (idPers) references personne(idPers),
    constraint FK_CONTENU_MIS_EN_SCENE foreign key (refContenu) references contenu(ref)
);

-- Table Interprete
drop table interprete cascade constraints;
create table interprete (
    idPers integer not null,
    refContenu integer not null,
    constraint PK_INTERPRETE primary key (idPers, refContenu),
    constraint FK_PERSONNE_INTERPRETE foreign key (idPers) references personne(idPers),
    constraint FK_CONTENU_INTERPRETE foreign key (refContenu) references contenu(ref)
);

-- Table Joue
drop table joue cascade constraints;
create table joue (
    idPers integer not null,
    refContenu integer not null,
    constraint PK_JOUE primary key (idPers, refContenu),
    constraint FK_PERSONNE_JOUE foreign key (idPers) references personne(idPers),
    constraint FK_CONTENU_JOUE foreign key (refContenu) references contenu(ref)
);

--------------------------------------------------------------------------------
-- Tables pour les comptes
--------------------------------------------------------------------------------
-- Table Adresse
drop table adresse cascade constraints;
create table adresse (
    id integer generated by default on null as identity,
    numero integer not null,
    ville varchar2(150) not null,
    codePostal varchar2(5) not null,
    rue varchar2(150) not null,
    constraint PK_ADRESSE primary key (id)
);

-- Table TypeAbonnement
drop table type_abonnement cascade constraints;
create table type_abonnement (
    id integer generated by default on null as identity,
    nom varchar2(50) not null,
    coutParMois float(2) not null,
    nombreContenu integer not null,
    constraint PK_TYPE_ABONNEMENT primary key (id)
);

-- Table Compte
drop table compte cascade constraints;
create table compte (
    id integer generated by default on null as identity,
    nom varchar2(50) not null,
    prenom varchar2(50) not null,
    email varchar2(100) not null,
    tel varchar2(10) not null,
    mdp varchar2(50) not null,
    adresse integer not null,
    constraint PK_COMPTE primary key (id),
    constraint FK_ADRESSE_COMPTE foreign key (adresse) references adresse(id)
);

-- Table Abonnement
drop table abonnement cascade constraints;
create table abonnement (
    idCompte integer not null,
    typeAbonnement integer not null,
    dateDeb date not null,
    dateFin date not null,
    constraint PK_ABONNEMENT primary key (idCompte, typeAbonnement),
    constraint FK_COMPTE_ABONEMENT foreign key (idCompte) references compte(id),
    constraint FK_TYPE_ABONNEMENT_ABONEMENT foreign key (typeAbonnement) references type_abonnement(id)
);

-- Table Achat
drop table achat cascade constraints;
create table achat (
    compte integer not null,
    refContenu integer not null,
    constraint PK_ACHAT primary key (compte, refContenu),
    constraint FK_COMPTE_ACHAT foreign key (compte) references compte(id),
    constraint FK_CONTENU_ACHAT foreign key (refContenu) references contenu(ref)
);

-- Table Evalue
drop table evalue cascade constraints;
create table evalue (
    compte integer not null,
    refContenu integer not null,
    note float(2) not null,
    constraint PK_EVALUE primary key (compte, refContenu),
    constraint FK_COMPTE_EVALUE foreign key (compte) references compte(id),
    constraint FK_CONTENU_EVALUE foreign key (refContenu) references contenu(ref)
);

-- Table Loue
drop table loue cascade constraints;
create table loue (
    compte integer not null,
    refContenu integer not null,
    dateFin date not null,
    constraint PK_LOUE primary key (compte, refContenu),
    constraint FK_COMPTE_LOUE foreign key (compte) references compte(id),
    constraint FK_CONTENU_LOUE foreign key (refContenu) references contenu(ref)
);

-- Table DureeLocation
drop table duree_location cascade constraints;
create table duree_location (
    idContenuType integer not null,
    typeAbonnement integer not null,
    duree integer not null,
    constraint PK_DUREE_LOCATION primary key (idContenuType, typeAbonnement),
    constraint FK_CONTENU_TYPE_DUREE_LOCATION foreign key (idContenuType) references contenu_type(idContenuType),
    constraint FK_TYPE_ABONNEMENT_DUREE_LOCATION foreign key (typeAbonnement) references type_abonnement(id)
)