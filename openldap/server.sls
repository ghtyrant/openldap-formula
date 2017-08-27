{% set ldap = salt['pillar.get']('openldap') %}

slapd_debconf:
  debconf.set:
    - name: slapd
    - data:
        'slapd/password1': {'type': 'password', 'value': '{{ ldap.root_password }}' }
        'slapd/password2': {'type': 'password', 'value': '{{ ldap.root_password }}' }
        'slapd/adminpw': {'type': 'password', 'value': '{{ ldap.admin_password }}' }
        'slapd/generated_adminpw': {'type': 'password', 'value': '{{ ldap.admin_password }}' }
        'slapd/backend': {'type': 'select', 'value': 'MDB' }
        'slapd/move_old_database': {'type': 'boolean', 'value': true }
        'slapd/purge_database': {'type': 'boolean', 'value': true }
        'slapd/dump_database': {'type': 'select', 'value': 'when needed' }
        'slapd/domain': {'type': 'string', 'value': '{{ ldap.domain }}' }
        'slapd/invalid_config': {'type': 'boolean', 'value': true }
        'slapd/ppolicy_schema_needs_update': {'type': 'select', 'value': 'abort installation' }
        'slapd/dump_database_destdir': {'type': 'string', 'value': '/var/backup/slapd-VERSION' }
        'slapd/no_configuration': {'type': 'boolean', 'value': false }
        'shared/organization': {'type': 'string', 'value': '{{ ldap.organization }}' }

openldap_server:
  pkg.installed:
    - name: slapd
    - require:
      - debconf: slapd_debconf

slapd_service:
  service.running:
    - name: slapd
