{#

{% set my_cool_string = 'wow!, cool!' %}
{% set my_second_cool_string = 'wow!, cool!' %}
{{ my_cool_string }}
{{ my_second_cool_string}}



{% set my_animals = ['lemur', 'wolf', 'panther', 'tardigrade'] %}

{{ my_animals[0]}}

{%  for animal in my_animals %}

My favorite animal is {{animal}}

{%endfor%}





{% set temperature = 45 %}

{% if temperature < 65 %}
time for a capuccino!
{% else%}
time for a coold brew!

{% endif%}#}