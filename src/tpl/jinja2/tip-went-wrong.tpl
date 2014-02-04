{% set user_from = a.u_from.name %}
{% if a.u_to %}
{%   set user_to_fmt = "/u/%s" % a.u_to.name %}
{% else %}
{%   set user_to_fmt = a.addr_to %}
{% endif %}
{% set coin_amount = a.coinval %}
{% set coin_name = ctb.conf.coins[a.coin].name %}
{% set coin_amount_fmt = " %.3f %s(s)" % (coin_amount, coin_name) %}
Hey {{ user_from | replace('_', '\_') }}, something went wrong and your tip/withdraw of **{{ coin_amount_fmt }}** to **{{ user_to_fmt }}** may not have been processed. Developer (/u/dbsnurr) has been notified, and will look into the issue as soon as possible. Please feel free to contact him if you feel you can add more details of what happened. Click this [link](http://www.reddit.com/message/compose/?to=dbsnurr&subject=Bug details) to send a message to him. 

{% include 'footer.tpl' %}
