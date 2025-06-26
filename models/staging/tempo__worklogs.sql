
select 
    date(STARTDATE) as Date,
    timespentseconds/3600 as HoursWorked,
    parse_json(author):accountId::string as jiraAccountID,
    parse_json(issue):id::number as IssueID

from {{ source("jiraData", "TEMPO_WORKLOG") }}
