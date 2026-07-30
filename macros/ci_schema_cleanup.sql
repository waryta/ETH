*** Managing data pipelines - Cleanup Pipeline - Part 1 ***


- Link to the dbt blog on ci/cd pipelines and Schema cleanups:

			https://docs.getdbt.com/guides/custom-cicd-pipelines?step=3#3-handle-those-extra-schemas-in-your-database


- If you're still on the feature/cd branch locally, that's fine, otherwise switch to it:

		git checkout feature/cd
		

- Under the macros folder , create a file ci_schema_cleanup.sql, and paste the following code:


{# 
    This macro finds PR schemas older than a set date and drops them 
    The macro defaults to 10 days old, but can be configured with the input argument age_in_days
    Sample usage with different date:
        dbt run-operation pr_schema_cleanup --args "{'database_to_clean': 'analytics','age_in_days':'15'}"
#}
{% macro pr_schema_cleanup(database_to_clean, age_in_days=-1) %}

    {% set find_old_schemas %}
        select 
            'drop schema {{ database_to_clean }}.'||schema_name||';'
        from {{ database_to_clean }}.information_schema.schemata
        where
            catalog_name = '{{ database_to_clean | upper }}'
            and schema_name ilike 'PR%'
            and last_altered <= (current_date() - interval '{{ age_in_days }} days')
    {% endset %}

    {% if execute %}

        {{ log('Schema drop statements:' ,True) }}

        {% set schema_drop_list = run_query(find_old_schemas).columns[0].values() %}

        {% for schema_to_drop in schema_drop_list %}
            {% do run_query(schema_to_drop) %}
            {{ log(schema_to_drop ,True) }}
        {% endfor %}

    {% endif %}

{% endmacro %}




- Test your macro with:

		dbt run-operation pr_schema_cleanup --args "{database_to_clean: CI}"