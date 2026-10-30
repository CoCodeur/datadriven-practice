with user_with_query as (
    
    select 
        u.age_bucket,
        u.user_id,
        count(sq.query_id) as total_user_searches,
        count(sq.query_id) filter (where sq.clicked_result >= 1) as successful_user_searches
        
    from users u
    join search_queries sq on u.user_id = sq.user_id
    where u.age_bucket is not null
    
    group by u.user_id, u.age_bucket
)

SELECT 
   age_bucket, 
   sum(total_user_searches) total_searches,
   sum(successful_user_searches) successful_searches,
   cast(sum(successful_user_searches) as float)  / cast( sum(total_user_searches) as float)  as success_rate
from 
    user_with_query

group by age_bucket
