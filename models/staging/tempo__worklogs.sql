
select 
    date(STARTDATE) as Date,
    tempoworklogid as worklogId,
    timespentseconds/3600 as HoursWorked,
    parse_json(author):accountId::string as jiraAccountID,
    parse_json(issue):id::number as issueID

from {{ source("jiraData", "TEMPO_WORKLOG") }}
