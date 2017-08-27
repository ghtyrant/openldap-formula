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
        - ou={{ ldap.users_ou }},{{ ldap.base_dn }}:
            - delete_others: True
            - replace:
                objectClass:
                  - organizationalUnit
                ou: {{ ldap.users_ou }}

{% for user, options in ldap.users.items() %}
        - uid={{ user }},ou={{ ldap.users_ou }},{{ ldap.base_dn }}:
            - delete_others: True
            - replace:
                cn: {{ options.get('name', '') }}
                uid: {{ user }}
                objectClass:
                    - person
                    - inetOrgPerson
                    - extensibleObject
                mail: {{ options.get('mail', '') }}
                displayName: {{ options.get('name', '') }}
                sn: {{ options.get('surname', '') }}
                otherMailBox:
                  {% for alias in options.get('mail_aliases', []) %}
                    - {{ alias }}
                  {% endfor %}
{% endfor %}
