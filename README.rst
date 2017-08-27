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


``openldap``
-----------

Includes all the states below.

``openldap.server``
------------------

Installs, configures and starts slapd.

``openldap.client``
------------------

Installs openldap-utils and python-openldap

``openldap.memberof``
------------------

Configures the memberOf overlay.

``openldap.users``
------------------

Manage a list of users.

``openldap.groups``
------------------

Manage a list of groups.
