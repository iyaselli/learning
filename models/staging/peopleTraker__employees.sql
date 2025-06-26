select 
    id as issueId,
    key as issueKey,
    parse_json(fields) as fields,
    parse_json(fields):issuetype:name::string as issueType,
    parse_json(fields):summary::string as employeeName,
    parse_json(fields):customfield_10232::string as jiraAccountId,
    parse_json(fields):customfield_10162::string as emailAddress,
    parse_json(fields):customfield_10194::number as employeeNumber,
    parse_json(fields):customfield_10200::date as startDate,
    parse_json(fields):customfield_10201::date as leaveDate,
    parse_json(fields):customfield_10202:value::string as leaveReason,
    parse_json(fields):status:name::string as emplyeeStatus

from DATAOPS_MPHASIS_PROD.INGESTION.JIRA_ISSUE
where key like 'MDLXINTPT%' and issueType like 'Employee'