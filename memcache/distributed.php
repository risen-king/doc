<?php
$mem = new Memcache;
$mem->addServer('localhost',11213);
$mem->addServer('localhost',11214);
$mem->addServer('localhost',11215);

$memStats = $mem->getExtendedStats();
print_r($memStats);
