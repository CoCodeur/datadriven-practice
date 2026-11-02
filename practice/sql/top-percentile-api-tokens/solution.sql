/* 

Considérez comme présentant un risque élevé les jetons (tokens) qui se situent 
au niveau ou au-dessus du 95e percentile en termes de nombre total de requêtes 
au sein de chaque périmètre (scope). Affichez l'identifiant du jeton, le périmètre, 
le nombre de requêtes et le rang percentile, arrondi à deux décimales. 
Présentez les résultats par ordre alphabétique de périmètre, en plaçant en premier les jetons 
les plus sollicités pour chaque périmètre ; en cas d'égalité sur le nombre de requêtes, le jeton dont 
l'identifiant est le plus faible doit apparaître en premier.

*/

with token_qualifiyed as (
SELECT
  token_id,
  scope,
  SUM(requests) AS requests,
  ROUND(
    PERCENT_RANK() OVER (
      PARTITION BY scope
      ORDER BY SUM(requests)
    ),
    2
  ) AS percentile_rank
FROM api_tokens
GROUP BY token_id, scope)



select * from token_qualifiyed

where percentile_rank >= 0.95
--order by percentile_rank desc, scope, token_id asc
order by scope asc, percentile_rank desc, token_id asc
