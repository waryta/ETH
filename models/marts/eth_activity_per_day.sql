select
date,
transaction_category,
count(*) as tx_count,
--sum(value)/1e18 as sum_eth_value

{{ethereum_conversion('value')}} as sum_eth_value
from {{ ref('int_transactions_enriched') }}

group by 
date,
transaction_category


