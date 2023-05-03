------------------------------------------------------------
-- Suppression des données
------------------------------------------------------------
delete from realise;
delete from joue;
delete from compose;
delete from interprete;
delete from scenarise;
delete from contenu_type;
delete from mot_clef;
delete from achat;
delete from loue;
delete from saison;
delete from contenu;
delete from theme;
delete from classification;
delete from personne;

------------------------------------------------------------
-- Insertion des données
------------------------------------------------------------
insert into classification (nomclassification)
    select distinct case d.rating
            when 'TV-Y' then 'Tous publics'
            when 'TV-G' then 'Tous publics'
            when 'G' then 'Tous publics'
            when 'TV-Y7' then '-10'
            when 'PG' then '-10'
            when 'TV-Y7-FV' then '-10'
            when 'TV-PG' then '-12'
            when 'TV-14' then '-16'
            when 'PG-13' then '-16'
            when 'TV-MA' then '-18'
            when 'R' then '-18'
            when 'NC-17' then '-18'
            else 'Null'
        end
    from datanetflouze d
;

insert into theme(nomtheme)
    select distinct val 
    from V_THEMATIC
;

insert into contenu (titre, description, duree, pays, anneeProd, classification, themeprincipal) 
    select d.title, 
           d.description, 
           to_number(substr(d.duration, 1, instr(d.duration, ' ')-1)) , 
           (case  
                when INSTR(d.country, ', ') < 1 then d.country 
                else SUBSTR(d.country, 1, INSTR(d.country, ', ')-1) 
            end), 
           to_date(d.release_year, 'yyyy'), 
           c.idclassification, 
           t.idtheme
    from datanetflouze d, classification c, theme t, v_thematic vt
    where c.nomclassification = (case d.rating
                                    when 'TV-Y' then 'Tous publics'
                                    when 'TV-G' then 'Tous publics'
                                    when 'G' then 'Tous publics'
                                    when 'TV-Y7' then '-10'
                                    when 'PG' then '-10'
                                    when 'TV-Y7-FV' then '-10'
                                    when 'TV-PG' then '-12'
                                    when 'TV-14' then '-16'
                                    when 'PG-13' then '-16'
                                    when 'TV-MA' then '-18'
                                    when 'R' then '-18'
                                    when 'NC-17' then '-18'
                                    else 'Null'
                                end) and 
          t.nomtheme = vt.val and 
          vt.pos = 1 and
          vt.show_id = d.show_id              
;

insert into contenu_type (refContenu, nomType)
    select distinct c.ref, (case 
                    when ((d.type = 'TV Show' and (d.listed_in like '%Kid%' or d.listed_in like '%Teen%')) or (d.type = 'Movie' and (d.listed_in like '%Children%' or d.listed_in like '%Family%'))) then 'Jeunesse' 
                    when (d.type = 'TV Show' ) then 'Series'
                    when (d.type = 'Movie' and (d.listed_in like '%Stand-Up Comedy%' or d.listed_in like '%Stand-Up Comedy & Talk Shows%')) then 'Divertissement'
                    else 'Cinéma'
                  end)
    from contenu c, datanetflouze d
    where c.titre = d.title
;

begin
    for serie in (select * 
                from contenu c, contenu_type ct
                where ct.refContenu = c.ref and 
                    ct.nomtype = 'Series') 
    loop
        for nb_saison in 1..(serie.duree)
        loop
            insert into contenu (titre, description, duree, pays, anneeProd, classification, themeprincipal)
            values (serie.titre||' - Saison '||nb_saison, serie.description, null, serie.pays, serie.anneeProd, serie.classification, serie.themeprincipal);
            insert into saison (serie, saison)
            values (serie.ref, (select ref from contenu where titre = serie.titre||' - Saison '||nb_saison));
        end loop;
    end loop;
end;
/

insert into mot_clef (refContenu, idTheme)
    select c.ref, t.idtheme
    from datanetflouze d, contenu c, theme t, v_thematic vt
    where t.nomtheme = vt.val and 
          vt.pos > 1 and
          vt.show_id = d.show_id and 
          c.titre = d.title           
;
    
insert into personne (nom, prenom)
    (select SUBSTR(vc.val, INSTR(vc.val, ' ')+1) as nom, 
            SUBSTR(vc.val, 1, INSTR(vc.val, ' ')-1) as prenom
    from v_cast vc
    UNION
    select SUBSTR(vd.val, INSTR(vd.val, ' ')+1) as nom, 
           SUBSTR(vd.val, 1, INSTR(vd.val, ' ')-1) as prenom
    from v_director vd)
;

insert into realise (idPers, refContenu)
    select p.idPers, c.ref
    from contenu c, personne p, datanetflouze d, v_director vd
    where d.title = SUBSTR(c.titre, 1, INSTR(c.titre, ' - Saison')-1) and
          d.show_id = vd.show_id and 
          SUBSTR(vd.val, INSTR(vd.val, ' ')+1) = p.nom and  
          SUBSTR(vd.val, 1, INSTR(vd.val, ' ')-1) = p.prenom         
;

insert into scenarise (idPers, refContenu)
    select distinct p.idPers, c.ref
    from contenu c, personne p, datanetflouze d, v_director vd, contenu_type ct
    where c.titre = d.title and
          ct.nomtype != 'Series' and
          d.show_id = vd.show_id and 
          SUBSTR(vd.val, INSTR(vd.val, ' ')+1) = p.nom and  
          SUBSTR(vd.val, 1, INSTR(vd.val, ' ')-1) = p.prenom         
;

insert into joue (idPers, refContenu)
    select distinct p.idPers, c.ref
    from contenu_type ct, contenu c, personne p, datanetflouze d, v_cast vc
    where d.show_id = vc.show_id and
          ((c.titre = d.title and ct.nomType = 'Cinéma') or (d.title = SUBSTR(c.titre, 1, INSTR(c.titre, ' - Saison')-1) and ct.nomType = 'Series')) and
          ct.refContenu = c.ref and 
          SUBSTR(vc.val, INSTR(vc.val, ' ')+1) = p.nom and  
          SUBSTR(vc.val, 1, INSTR(vc.val, ' ')-1) = p.prenom         
;

insert into compose (idPers, refContenu)
select p.idPers, c.ref
    from contenu c, personne p, datanetflouze d, v_cast vc, contenu_type ct
    where ct.refContenu = c.ref and 
          d.show_id = vc.show_id and 
          c.titre = d.title and
          SUBSTR(vc.val, INSTR(vc.val, ' ')+1) = p.nom and  
          SUBSTR(vc.val, 1, INSTR(vc.val, ' ')-1) = p.prenom and
          ct.nomType = 'Jeunesse'
          
;

insert into interprete (idPers, refContenu)
select p.idPers, c.ref
    from contenu c, personne p, datanetflouze d, v_cast vc, contenu_type ct
    where ct.refContenu = c.ref and 
          d.show_id = vc.show_id and 
          c.titre = d.title and
          SUBSTR(vc.val, INSTR(vc.val, ' ')+1) = p.nom and  
          SUBSTR(vc.val, 1, INSTR(vc.val, ' ')-1) = p.prenom and
          ct.nomType = 'Divertissement'
          
;