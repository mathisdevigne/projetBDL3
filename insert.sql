------------------------------------------------------------
-- Suppression des données
------------------------------------------------------------
delete from contenu;
delete from theme;
delete from classification;
delete from personne;

------------------------------------------------------------
-- Insertion des données
------------------------------------------------------------
insert into classification (nomclassification)
    select distinct case rating
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
            when 'NR' then 'Null'
            when 'UR' then 'Null'
        end
    from datanetflouze d
;

insert into theme(nomtheme)
    select distinct val 
    from V_THEMATIC
    where pos = 1
;

insert into contenu (titre, description, duree, pays, anneeProd, classification, themeprincipal) 
    select d.title, d.description, (case d.type when 'TV Show' then null else to_number(substr(d.duration, 1, 3)) end), d.country, to_date(d.release_year, 'yyyy'), c.idclassification, t.idtheme
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
                                    when 'NR' then 'Null'
                                    when 'UR' then 'Null'
                                end) and 
          t.nomtheme = vt.val and 
          vt.pos = 1 and
          vt.show_id = d.show_id              
;

insert into personne (nom, prenom)
    (select SUBSTR(vc.val, INSTR(vc.val, ' ')+1) as nom, (case INSTR(vc.val, ' ') when 0 then '' else SUBSTR(vc.val, 1, INSTR(vc.val, ' ')-1) end) as prenom
    from v_cast vc
    UNION
    select SUBSTR(vd.val, INSTR(vd.val, ' ')+1) as nom, (case INSTR(vd.val, ' ') when 0 then '' else SUBSTR(vd.val, 1, INSTR(vd.val, ' ')-1) end) as prenom
    from v_director vd)
;