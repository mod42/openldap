#!/bin/env bash

if [ -f /usr/local/etc/openldap/openldap_configured.txt ];
then
   echo "OpenLDAP was already configured, starting it."
   exec /usr/local/libexec/slapd -d 8
else
   echo "OpenLDAP was not yet configured. Doing it now and then starting it."
   /usr/local/libexec/slapd
   sleep 5
   ldapadd -x -w $LDAP_ROOT_PASSWORD -D $LDAP_ROOT_USER -f /usr/local/etc/openldap/ldap-init.ldif
   pkill slapd
   echo 'OpenLDAP' > /usr/local/etc/openldap/openldap_configured.txt
   exec /usr/local/libexec/slapd -d 8
fi
