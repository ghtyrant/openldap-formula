openldap_client:
  pkg.installed:
    - pkgs:
        - ldap-utils
        - python-ldap
