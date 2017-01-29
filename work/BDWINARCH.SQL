-- -----------------------------------------------------------------------------
--             génération d'une base de données pour
--                           postgresql
--                        (26/1/2017 14:02:50)
-- -----------------------------------------------------------------------------
--      nom de la base : bdwinarch
--      projet : 
--      auteur : foko
--      date de dernière modification : 26/1/2017 14:00:50
-- -----------------------------------------------------------------------------

--drop database bdwinarch;
-- -----------------------------------------------------------------------------
--       creation de la base 
-- -----------------------------------------------------------------------------

--create database bdwinarch;

-- -----------------------------------------------------------------------------
--       table : user
-- -----------------------------------------------------------------------------

create table "user"
   (
    userid serial not null  ,
    agenceid int not null  ,
    adminid int not null  ,
    username varchar null  ,
    userlogin varchar null  ,
    userpassword varchar null  ,
    usermail varchar null  ,
type integer,
   constraint pk_user primary key (userid),
   CONSTRAINT user_userlogin_key UNIQUE (userlogin )
   );

-- -----------------------------------------------------------------------------
--       index de la table user
-- -----------------------------------------------------------------------------

create  index i_fk_user_agence
     on "user" (agenceid)
    ;

create  index i_fk_user_administrateur
     on "user" (adminid)
    ;

-- -----------------------------------------------------------------------------
--       table : administrateur
-- -----------------------------------------------------------------------------

create table "administrateur"
   (
   adminid serial NOT NULL,
  adminname character varying,
  password character varying,
  adminlogin character varying NOT NULL,
  CONSTRAINT pk_administrateur PRIMARY KEY (adminid ),
  CONSTRAINT administrateur_adminlogin_key UNIQUE (adminlogin )
   );

-- -----------------------------------------------------------------------------
--       table : boites
-- -----------------------------------------------------------------------------

create table "boites"
   (
    boiteid serial not null  ,
    userid int not null  ,
    guichet varchar null  ,
    naturedocuments varchar null  ,
    debutperiode timestamp null  ,
    finperiode timestamp null  ,
    dateexpiration timestamp null,
     recu boolean,
   constraint pk_boites primary key (boiteid)
   );

-- -----------------------------------------------------------------------------
--       index de la table boites
-- -----------------------------------------------------------------------------

create  index i_fk_boites_user
     on "boites" (userid)
    ;

-- -----------------------------------------------------------------------------
--       table : correspondantarchiviste
-- -----------------------------------------------------------------------------

create table "correspondantarchiviste"
   (
    userid serial not null  ,
    username varchar null  ,
    userlogin varchar null  ,
    userpassword varchar null  ,
    usermail varchar null  
,   constraint pk_correspondantarchiviste primary key (userid)
   );

-- -----------------------------------------------------------------------------
--       table : correspondantmetier
-- -----------------------------------------------------------------------------

create table "correspondantmetier"
   (
    userid serial not null  ,
    username varchar null  ,
    userlogin varchar null  ,
    userpassword varchar null  ,
    usermail varchar null  
,   constraint pk_correspondantmetier primary key (userid)
   );

-- -----------------------------------------------------------------------------
--       table : agence
-- -----------------------------------------------------------------------------

create table "agence"
   (
    agenceid int not null  ,
    agencename varchar null  
,   constraint pk_agence primary key (agenceid)
   );

-- -----------------------------------------------------------------------------
--       table : correspondance
-- -----------------------------------------------------------------------------

create table "correspondance"
   (
    userid int not null  ,
    userid_1 int not null  ,
    typecorrespondance varchar null  ,
    datecorrespondance timestamp null  ,
    scandocument varchar null  ,
    descriptiondetailleecorrespondan varchar null  ,
    idcorrespondance int null  
,   constraint pk_correspondance primary key (userid, userid_1)
   );

-- -----------------------------------------------------------------------------
--       index de la table correspondance
-- -----------------------------------------------------------------------------

create  index i_fk_correspondance_correspond
     on "correspondance" (userid)
    ;

create  index i_fk_correspondance_correspon1
     on "correspondance" (userid_1)
    ;

-- -----------------------------------------------------------------------------
--       table : asso_5
-- -----------------------------------------------------------------------------

create table asso_5
   (
    userid int not null  ,
    userid_1 int not null  
,   constraint pk_asso_5 primary key (userid, userid_1)
   );

-- -----------------------------------------------------------------------------
--       index de la table asso_5
-- -----------------------------------------------------------------------------

create  index i_fk_asso_5_user
     on "asso_5" (userid)
    ;

create  index i_fk_asso_5_user1
     on "asso_5" (userid_1)
    ;


-- -----------------------------------------------------------------------------
--       creation des references de table
-- -----------------------------------------------------------------------------


alter table "user" add 
     constraint fk_user_agence
          foreign key (agenceid)
               references "agence" (agenceid);

alter table "user" add 
     constraint fk_user_administrateur
          foreign key (adminid)
               references "administrateur" (adminid);

alter table "boites" add 
     constraint fk_boites_user
          foreign key (userid)
               references "user" (userid);

alter table "correspondantarchiviste" add 
     constraint fk_correspondantarchiviste_user
          foreign key (userid)
               references "user" (userid);

alter table "correspondantmetier" add 
     constraint fk_correspondantmetier_user
          foreign key (userid)
               references "user" (userid);

alter table "correspondance" add 
     constraint fk_correspondance_correspondantm
          foreign key (userid)
               references "correspondantmetier" (userid);

alter table "correspondance" add 
     constraint fk_correspondance_correspondanta
          foreign key (userid_1)
               references "correspondantarchiviste" (userid);

alter table "asso_5" add 
     constraint fk_asso_5_user
          foreign key (userid)
               references "user" (userid);

alter table "asso_5" add 
     constraint fk_asso_5_user1
          foreign key (userid_1)
               references "user" (userid);


-- -----------------------------------------------------------------------------
--                fin de generation
-- -----------------------------------------------------------------------------
