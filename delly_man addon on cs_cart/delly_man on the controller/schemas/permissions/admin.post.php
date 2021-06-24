<?php

$schema['delly_man'] = array(
'permissions' => array('GET' => 'view_delly_man', 'POST' =>
'manage_delly_man'),
'modes' => array(
'delete' => array(
'permissions' => 'manage_delly_man'
)
),
);
$schema['tools']['modes']['update_status']['param_permissions']['table']
['delly_man'] = 'manage_delly_man';

return $schema;

?>