select year, (1-(CAST(SUM(white_male)+SUM(white_female) as float)/SUM(total)))*100 AS minority_pct
from data
where age_group == 0 AND (year == 1 or year == 7) AND county LIKE 'St. Louis city'
group by year;
