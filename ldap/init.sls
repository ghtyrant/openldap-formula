{% set ldap = salt['pillar.get']('ldap_data') %}

include:
  - ldap.server
  - ldap.client
  - ldap.memberof
  - ldap.users
  - ldap.groups
