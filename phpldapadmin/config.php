<?php
$servers = new Datastore();
$servers->newServer('ldap_pla');
$servers->setValue('server','name','LDAP Server');
$servers->setValue('server','host',getenv('LDAP_HOST'));
$servers->setValue('server','port',(int)getenv('LDAP_PORT'));
$servers->setValue('server','base',array(getenv('LDAP_BASE')));
$servers->setValue('login','auth_type','cookie');
$servers->setValue('login','bind_id',getenv('LDAP_LOGIN_NAME'));
#kashuoldap!@#$%^&*()
$servers->setValue('login','bind_pass',getenv('LDAP_LOGIN_PASSWORD'));
#$servers->setValue('login','bind_pass','kashuoldap!@#$%^&*()');
$servers->setValue('server','tls',false);
