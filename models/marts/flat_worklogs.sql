select     
    date,
    hoursworked,
    employeename,
    tempo__worklogs.jiraaccountid 
from {{ ref('tempo__worklogs') }}
left join {{ref("peopleTraker__employees")}} on tempo__worklogs.jiraaccountid= peopleTraker__employees.jiraaccountid