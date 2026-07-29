select
t.date,
s.type,
{{conversion2('t.value','s.decimals')}} as total_usd_value

from {{ source('eth', 'token_transfers')}} t
left join {{ref('stablecoins')}} s
on t.token_address = s.Contract_Address

where s.Contract_Address is not null
--lower(token_address) in ('0xdac17f958d2ee523a2206206994597c13d831ec7', '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48')

group by 
t.date,
s.type