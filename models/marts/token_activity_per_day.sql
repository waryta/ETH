--{{config(tags=['token'], alias=var('token_name_var'))}}
{{config(tags=['token'], alias=var('token_name_var')~'_activity_per_day')}} -- creer la table dans snow pour stocker cette requette

select
t.date,
t.token_address,
{{conversion2('t.value',var('token_decimals_var'))}} as total_value

from {{ source('eth', 'token_transfers')}} t

where lower(token_address) = '{{var("token_address_vars")}}'

group by 
t.date,
t.token_address