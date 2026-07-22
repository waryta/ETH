{{config(tags=['token'])}}

select
t.date,
t.token_address,
{{conversion2('t.value',var('token_decimals_var')) }} as total_value

from {{ source('eth', 'token_transfers')}} t

where lower(token_address) = {{var('token_address_var')}}

group by 
t.date,
t.token_address