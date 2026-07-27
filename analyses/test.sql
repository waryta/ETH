--{{codegen.generate_source(schema_name='eth_schema',database_name='eth', generate_columns= true)}} 
-- permet de gerener ds le terminal les sources et on copie dans source.yml
--select
--{{dbt_utils.star(from =ref('int_transactions_enriched'),except=['hash'], quote_identifiers= false, prefix='stg_')}}
--from {{ref('int_transactions_enriched')}}

--{{audit_helper.compare_relations(source('eth','contracts'), source('eth','contracts_clone'))}}
{{codegen.generate_model_yaml(['stablecoin_activity_per_day'])}}
