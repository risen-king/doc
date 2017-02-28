<?php
// 连接
$mem = new Memcache;
$mem->connect("127.0.0.1",11211);

// 保存数据
$mem->set('key1','This is first value',0,60);
$val = $mem->get('key1');
echo "Get key1 value: ".$val."\n\n";

// 替换数据
$mem->replace('key1','This is replcae value',0,60);
$val = $mem->get('key1');
echo "Get key1 value: ".$val ."\n\n";


// 保存数组
$arr = array('aa','bb','cc');
$mem->set('key2',$arr,0,60);
$val2 = $mem->get('key2');
echo "Get key2 value: ";
print_r($val2);
echo "\n\n";

echo "********* 华丽的分割线 *******************";
echo "\n\n";

// 删除数据
$mem->delete('key1');
$val = $mem->get('key1');
echo "Get key1 value: " .$val ."\n\n";

// 清除所有数据
$mem->flush();
$val2 = $mem->get('key2');
echo "Get key2 value : ";
print_r($val2);
echo "\n\n\n";

// 关闭连接
$mem->close();


