{% set ldap = salt['pillar.get']('ldap_data') %}

include:
  - ldap.server
  - ldap.client

ldap_memberof_overlay:
  ldap.managed:
    - require:
        - pkg: openldap_client

    - name: ldapi:///
    - connect_spec:
        bind:
          method: sasl

    - entries:
        # Make sure all needed modules are loaded

        - cn=module{0},cn=config:
            - default:
                cn: module{0}
                olcModuleLoad:
                  - back_mdb
                objectClass:
                  - olcModuleList

        - cn=module{1},cn=config:
            - default:
                cn: module{1}
                olcModuleLoad:
                  - memberof
                objectClass:
                  - olcModuleList

        - cn=module{2},cn=config:
            - default:
                cn: module{2}
                olcModuleLoad:
                  - refint
                objectClass:
                  - olcModuleList

        - 'olcOverlay={0}memberof,olcDatabase={1}mdb,cn=config':
            - delete_others: True
            - default:
                objectClass:
                  - olcConfig
                  - olcMemberOf
                  - olcOverlayConfig
                  - top
                olcOverlay: memberof
                olcMemberOfDangling: 'ignore'
                olcMemberOfRefInt: 'TRUE'
                olcMemberOfGroupOC: groupOfNames
                olcMemberOfMemberAD: member
                olcMemberOfMemberOfAD: memberOf

        - 'olcOverlay={1}refint,olcDatabase={1}mdb,cn=config':
            - replace:
                objectClass: 
                  - olcConfig
                  - olcOverlayConfig
                  - olcRefintConfig
                  - top
                olcOverlay: '{1}refint'
                olcRefintAttribute: memberof member manager owner
