select 
    state,
    county,
    CAST((year_2011-year_2010) as float)/year_2010*100 as chg_2011,
    CAST((year_2012-year_2010) as float)/year_2010*100 as chg_2012,
    CAST((year_2013-year_2010) as float)/year_2010*100 as chg_2013,
    CAST((year_2014-year_2010) as float)/year_2010*100 as chg_2014
from (select 
    state,
    county,
    sum(case when year == 1 then total end) year_2010,
    sum(case when year == 4 then total end) year_2011,
    sum(case when year == 5 then total end) year_2012,
    sum(case when year == 6 then total end) year_2013,
    sum(case when year == 7 then total end) year_2014
from data
where age_group == 0
group by county)
;