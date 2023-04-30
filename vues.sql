create or replace view v_datanetflouze_aux as
select show_id, 
       replace (director, ', ', ',') as director, 
       replace (listed_in, ', ', ',') as listed_in,
	   replace (cast, ', ', ',') as casting, 
	   replace (country, ', ', ',') as country
from datanetflouze;

create or replace view v_director as
select show_id, regexp_substr (
         director,
         '[^,]+',
         1,
         level
       ) val,
	   level as pos
from   v_datanetflouze_aux 
where director is not null
connect by level <=   
  length ( director ) - length ( replace ( director, ',' ) ) + 1
and    prior director = director
and    prior show_id = show_id
and    prior sys_guid () is not null;

create or replace view v_thematic as
select show_id, regexp_substr (
         listed_in,
         '[^,]+',
         1,
         level
       ) val,
	   level as pos
from   v_datanetflouze_aux 
connect by level <=   
  length ( listed_in ) - length ( replace ( listed_in, ',' ) ) + 1
and    prior listed_in = listed_in
and    prior show_id = show_id
and    prior sys_guid () is not null;

create or replace view v_cast as
select show_id, regexp_substr (
         casting,
         '[^,]+',
         1,
         level
       ) val,
	   level as pos
from   v_datanetflouze_aux 
where casting is not null
connect by level <=   
  length ( casting ) - length ( replace ( casting, ',' ) ) + 1
and    prior casting = casting
and    prior show_id = show_id
and    prior sys_guid () is not null;

create or replace view v_country as
select show_id, regexp_substr (
         country,
         '[^,]+',
         1,
         level
       ) val,
	   level as pos
from   v_datanetflouze_aux 
where country is not null
connect by level <=   
  length ( country ) - length ( replace ( country, ',' ) ) + 1
and    prior country = country
and    prior show_id = show_id
and    prior sys_guid () is not null;