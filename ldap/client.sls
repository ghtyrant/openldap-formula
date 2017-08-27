{% set ldap = salt['pillar.get']('ldap_data') %}

openldap_client:
  pkg.installed:
    - pkgs:
        - ldap-utils
        - python-ldap
