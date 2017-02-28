 $b_time = microtime(true);  
 echo '<p>'.$b_time.'</p>';  
 $key = "张三";  
 $index = "myorder";  
 //========================================分词  
  
 $so = scws_new();  
 $so->set_charset('utf-8');  
 //默认词库  
 $so->add_dict(ini_get('scws.default.fpath') . '/dict.utf8.xdb');  
 //自定义词库  
// $so->add_dict('./dd.txt',SCWS_XDICT_TXT);  
 //默认规则  
 $so->set_rule(ini_get('scws.default.fpath') . '/rules.utf8.ini');  
  
 //设定分词返回结果时是否去除一些特殊的标点符号  
 $so->set_ignore(true);  
  
 //设定分词返回结果时是否复式分割，如“中国人”返回“中国＋人＋中国人”三个词。  
 // 按位异或的 1 | 2 | 4 | 8 分别表示: 短词 | 二元 | 主要单字 | 所有单字  
 //1,2,4,8 分别对应常量 SCWS_MULTI_SHORT SCWS_MULTI_DUALITY SCWS_MULTI_ZMAIN SCWS_MULTI_ZALL  
 $so->set_multi(false);  
  
 //设定是否将闲散文字自动以二字分词法聚合  
 $so->set_duality(false);  
  
 //设定搜索词  
 $so->send_text($key);  
 $words_array = $so->get_result();  
 $words = "";  
 foreach($words_array as $v)  
 {  
 $words = $words.'|('.$v['word'].')';  
 }  
  
 //加入全词  
 #$words = '('.$key.')'.$words;  
 $words = trim($words,'|');  
 $so->close();  
 echo '<p>输入：'.$key.'</p>';  
 echo '<p>分词：'.$words.'</p>';  
