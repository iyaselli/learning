
{{
    config(
        materialized='table'
    )


}}
select 
    date(STARTDATE) as Date,
    timespentseconds/3600 as HoursWorked,
    parse_json(author):accountId::string as USER_ID,
    parse_json(issue):id::number as IssueID

from DATAOPS_MPHASIS_PROD.INGESTION.TEMPO_WORKLOG
