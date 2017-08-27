include:
  - openldap.client



openldap_schema_misc:
  ldap.managed:
    - name: ldapi:///
    - connect_spec:
        bind:
          method: sasl

    - entries:
      - cn={4}misc,cn=schema,cn=config:
        - delete_others: True
        - replace:
            objectClass: olcSchemaConfig
            cn: '{4}misc'
            olcAttributeTypes: 
              - ( 2.16.840.1.113730.3.1.13 NAME 'mailLocalAddress' DESC 'RFC822 email address of this recipient' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{256} )
              - ( 2.16.840.1.113730.3.1.18 NAME 'mailHost' DESC 'FQDN of the SMTP/MTA of this recipient' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{256} SINGLE-VALUE )
              - ( 2.16.840.1.113730.3.1.47 NAME 'mailRoutingAddress' DESC 'RFC822 routing address of this recipient' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{256} SINGLE-VALUE )
              - ( 1.3.6.1.4.1.42.2.27.2.1.15 NAME 'rfc822MailMember' DESC 'rfc822 mail address of group member(s)' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
            olcObjectClasses: 
              - ( 2.16.840.1.113730.3.2.147 NAME 'inetLocalMailRecipient' DESC 'Internet local mail recipient' SUP top AUXILIARY MAY ( mailLocalAddress $ mailHost $ mailRoutingAddress ) )
              - ( 1.3.6.1.4.1.42.2.27.1.2.5 NAME 'nisMailAlias' DESC 'NIS mail alias' SUP top STRUCTURAL MUST cn MAY rfc822MailMember )
