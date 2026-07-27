select 
address,
block_hash,
block_number,
block_timestamp,
bytecode,
date,
last_modified
from {{source('eth','contracts')}}