openldap-formula
===============

Formulas to set up and configure openldap, install the memberOf overlay and create users and groups.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:


``ldap``
-----------

Includes all the states below.

``ldap.server``
------------------

Installs, configures and starts slapd.

``ldap.client``
------------------

Installs ldap-utils and python-ldap

``ldap.memberof``
------------------

Configures the memberOf overlay.

``ldap.users``
------------------

Manage a list of users.

``postfix.groups``
------------------

Manage a list of groups.
