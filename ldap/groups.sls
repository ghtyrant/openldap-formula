{% set ldap = salt['pillar.get']('ldap_data') %}

include:
  - ldap.server
  - ldap.client

ldapi:///:
  ldap.managed:
    - connect_spec:
        bind:
          method: simple
          dn: cn=admin,{{ ldap.base_dn }}
          password: {{ ldap.root_password }}

    - entries:
        - ou={{ ldap.groups_ou }},{{ ldap.base_dn }}:
            - delete_others: True
            - replace:
                objectClass:
                  - organizationalUnit
                ou: {{ ldap.groups_ou }}

{% for group, options in ldap.groups.iteritems() %}
        - cn={{ group }},ou={{ ldap.groups_ou }},{{ ldap.base_dn }}:
            - delete_others: True
            - replace:
                cn: {{ group }}
                objectClass:
                  - groupOfNames 

                member:
                {% for user in options.users %}
                  - uid={{ user }},ou={{ ldap.users_ou }},{{ ldap.base_dn }}
                {% endfor %}
{% endfor %}

