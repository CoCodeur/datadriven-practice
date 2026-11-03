SELECT
  mdl_name,
  round( cast (PERCENTILE_CONT(0.5) 
WITHIN GROUP ( ORDER BY accuracy) OVER (partition by mdl_name) as float),3)

FROM ml_models
WHERE accuracy IS NOT NULL
GROUP BY mdl_name
order by mdl_name asc
