### 1 新建 UploadForm
```
<?php

namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;

class UploadForm extends Model
{
    /**
     * @var UploadedFile
     */
    public $file;

    public function rules()
    {
        return [
            [['file'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg'],
        ];
    }
    
    public function upload()
    {
        if ($this->validate()) {
            
                    $new_name = 'uploads/' . $this->file->baseName . '-' .time(). '.' . $this->file->extension;
                    
                    $this->file->saveAs($new_name);
                 
                   return $new_name;
                
        } else {
                   return false;
        }
    }
}
```

### 2  在  UserController.php 中 引入 文件上传类
```
//文件上传相关类
use yii\web\UploadedFile;
use app\models\UploadForm;


public function actionUpload()
{
    $model = new UploadForm();

    if (Yii::$app->request->isPost) 
    {

              $model->file = UploadedFile::getInstanceByName('file');

             $fileName = $model->upload() ;

             if ( $fileName ) {
                        // 文件上传成功
                        return Util::success(  $fileName );  
             }else{
                         return Util::error( '文件无法保存');
             }
    }else{
              return Util::error( '非法访问');
    }


 }
```

### 3 在 web.conf 配置文件中 新增  'OPTIONS,POST    upload' => 'upload'
```
'urlManager' =>[
      'enablePrettyUrl' => true,
      'enableStrictParsing' => true,
      'showScriptName' => false,
      
      'rules' => [
              ....
              [
                  'class' => 'yii\rest\UrlRule', 
                  'controller' => 'user',
                  'extraPatterns' => [
                       'OPTIONS,POST    upload' => 'upload',
                    ]
              ],
              ...
        ]
        
       

]


```

### 4 在 web 目录下新建 uploads 文件夹

### 5 使用 postman 上传文件
  url:  http://localhost:8080/users/upload 
  方法选择 post, Body 选择 form-data
  key 填写 file，选择要上传的文件
  
  提交后可以发现 uploads 文件夹中有新的文件了 
  
  参见  http://www.jianshu.com/p/658679dadeb0
  
  
