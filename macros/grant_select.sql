{% macro grant_select (schema,role)%}
    {% set query%}

        grant usage om schema {{schema}} to role {{role}};
        grant select on all tables in schema {{schema}} to role {{role}};
        grant select on all views in schema {{schema}} to role {{role}};

    {% endset%}




{% endmacro%}