select
    sum(value) as total_amount
from {{source('eth','transactions')}}

having total_amount < 0

