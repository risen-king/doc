# Yii2 上传文件解析 -- 表单上传 VS restful 上传

## 1 表单上传 和 restful 上传
### 1.1 建立一个模型 models/UploadForm.php
```
namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;


class UploadForm extends Model
{
    /**
     * @var  单个文件上传对应的属性
     */
    public $single;
    
    /**
     * @var  多个文件上传对应的属性
     */
    public $multiple

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
              [['single'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg'],
             [['multiple'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg','maxFiles' => 4],
        ];
    }
}
    //单个文件上传对应方法
    public function upload()
    {
        if ($this->validate()) {
            $newName = 'uploads/' . $this->single->baseName . '.' . $this->single->extension;
            $this->single->saveAs($newName);
            return true;
        } else {
            return false;
        }
    }
    
    //多个文件上传对应方法
    public function uploadMultiple()
    {
        if ($this->validate()) 
        { 
            foreach ($this->multiple as $file) {
            
                $newName = 'uploads/' . $file->baseName . '.' . $file->extension;
                $file->saveAs($newName);
            }
            return true;
        } else {
            return false;
        }
    }
```

### 1.2 建立一个视图文件 site/upload.php
```
<?php
use yii\widgets\ActiveForm;
?>

<?php $form = ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data']]) ?>
 
<div style="margin-bottom:  30px;">
         <!--   单个文件上传按钮,主要用于 restful       -->
        <input name="single-file"  type="file">
        <!--   多个文件上传按钮,主要用于 restful     -->
        <input name="multi-file[]"  type="file" multiple="true"> 
</div> 
 
 <!--   单个文件上传按钮     -->
 <?= $form->field($model, 'single')->fileInput() ?>
 
  <!--   多个文件上传按钮     -->
 <?= $form->field($model, 'multiple[]')->fileInput(['multiple' => true, 'accept' => 'image/*']) ?>

 <button>Submit</button>

<?php ActiveForm::end() ?>
```

### 1.3 建立控制器文件 SiteController
```
namespace app\controllers;

use Yii;
use yii\web\Controller;
use app\models\UploadForm;
use yii\web\UploadedFile;

class SiteController extends Controller
{
    public function actionUpload()
    {
        $model = new UploadForm();

        if (Yii::$app->request->isPost) {
            /**
            **  使用ActiveForm 上传 
            **/
            //获取单个文件用 getInstance
            $model->single = UploadedFile::getInstance($model, 'single');
            $model->upload();
            
            //获取多个文件用 getInstances
            $model->multiple = UploadedFile::getInstances($model, 'multiple');
            $model->uploadMultiple();
            
            unset($model->single,$model->multiple);
            
            /**
            **  使用原生文件上传控件，主要用于 restful 文件上传
            **/
            
            //获取单个文件用 getInstanceByName
            $model->single = UploadedFile::getInstanceByName('single-file');
            $model->upload();
            
            //获取多个文件用 getInstancesByName
            $model->multiple = UploadedFile::getInstancesByName('multi-file');
            $model->uploadMultiple();
            
            unset($model->single,$model->multiple);
            
            
        }

        return $this->render('upload', ['model' => $model]);
    }
}
```


## 2 原理解析

### 2.1 代码分析
> yii\web\UploadedFile::getInstance  最终调用 yii\web\UploadedFile::getInstanceByName
> yii\web\UploadedFile::getInstances    最终调用yii\web\UploadedFile::getInstancesByName
>
>yii\web\UploadedFile::getInstanceByName | yii\web\UploadedFile::getInstancesByName 都是查找 yii\web\UploadedFile::loadFiles() 生成的  $files 数组

```
public static function getInstance($model, $attribute)
{
    $name = Html::getInputName($model, $attribute);
    return static::getInstanceByName($name);
}
public static function getInstances($model, $attribute)
{
    $name = Html::getInputName($model, $attribute);
    return static::getInstancesByName($name);
}

public static function getInstanceByName($name)
{
    $files = self::loadFiles();
    return isset($files[$name]) ? new static($files[$name]) : null;
}

    
public static function getInstancesByName($name)
{
    $files = self::loadFiles();
    if (isset($files[$name])) {
        return [new static($files[$name])];
    }
    $results = [];
    foreach ($files as $key => $file) {
        if (strpos($key, "{$name}[") === 0) {
            $results[] = new static($file);
        }
    }
    return $results;
}
```
 

### 2.2 未经处理的 $_FILES 数组 
```
echo '<pre>';
print_r($_FILES);

Array
(
    [single-file] => Array
        (
            [name] => 2017-08-01 10-11-45 的屏幕截图.png
            [type] => image/png
            [tmp_name] => /tmp/php2yWOZU
            [error] => 0
            [size] => 203247
        )

    [multi-file] => Array
        (
            [name] => Array
                (
                    [0] => 2017-08-01 10-11-45 的屏幕截图.png
                    [1] => 2017-07-31 02-24-02 的屏幕截图.png
                )

            [type] => Array
                (
                    [0] => image/png
                    [1] => image/png
                )

            [tmp_name] => Array
                (
                    [0] => /tmp/php40QPDr
                    [1] => /tmp/phpPRAVhY
                )

            [error] => Array
                (
                    [0] => 0
                    [1] => 0
                )

            [size] => Array
                (
                    [0] => 203247
                    [1] => 182599
                )

        )

    [UploadForm] => Array
        (
            [name] => Array
                (
                    [single] => 2017-07-30 21-35-10 的屏幕截图.png
                    [multiple] => Array
                        (
                            [0] => 2017-07-28 22-20-00 的屏幕截图.png
                            [1] => 2017-07-25 22-04-50 的屏幕截图.png
                        )

                )

            [type] => Array
                (
                    [single] => image/png
                    [multiple] => Array
                        (
                            [0] => image/png
                            [1] => image/png
                        )

                )

            [tmp_name] => Array
                (
                    [single] => /tmp/phpCfL5Vu
                    [multiple] => Array
                        (
                            [0] => /tmp/phpNTGjA1
                            [1] => /tmp/php7EbKey
                        )

                )

            [error] => Array
                (
                    [single] => 0
                    [multiple] => Array
                        (
                            [0] => 0
                            [1] => 0
                        )

                )

            [size] => Array
                (
                    [single] => 150132
                    [multiple] => Array
                        (
                            [0] => 588277
                            [1] => 658391
                        )

                )

        )

)

```
### 2.3 处理过后的数组
yii\web\UploadedFile::loadFiles() 处理过后的 yii\web\UploadedFile::$_files 数组
```
Array
(
    [single-file] => Array
        (
            [name] => 2017-08-01 10-11-45 的屏幕截图.png
            [tempName] => /tmp/php2yWOZU
            [type] => image/png
            [size] => 203247
            [error] => 0
        )

    [multi-file[0]] => Array
        (
            [name] => 2017-08-01 10-11-45 的屏幕截图.png
            [tempName] => /tmp/php40QPDr
            [type] => image/png
            [size] => 203247
            [error] => 0
        )

    [multi-file[1]] => Array
        (
            [name] => 2017-07-31 02-24-02 的屏幕截图.png
            [tempName] => /tmp/phpPRAVhY
            [type] => image/png
            [size] => 182599
            [error] => 0
        )

    [UploadForm[single]] => Array
        (
            [name] => 2017-07-30 21-35-10 的屏幕截图.png
            [tempName] => /tmp/phpCfL5Vu
            [type] => image/png
            [size] => 150132
            [error] => 0
        )

    [UploadForm[multiple][0]] => Array
        (
            [name] => 2017-07-28 22-20-00 的屏幕截图.png
            [tempName] => /tmp/phpNTGjA1
            [type] => image/png
            [size] => 588277
            [error] => 0
        )

    [UploadForm[multiple][1]] => Array
        (
            [name] => 2017-07-25 22-04-50 的屏幕截图.png
            [tempName] => /tmp/php7EbKey
            [type] => image/png
            [size] => 658391
            [error] => 0
        )

)
```

> 可见 ：
对于未使用ActiveForm 的 single-file， 要 获取文件实例 使用 yii\web\UploadedFile::getInstanceByName('single-file')，
对于未使用ActiveForm 的 multiple-file， 要 获取文件实例 使用 yii\web\UploadedFile::getInstancesByName('multi-file')。
> 
> 对于使用ActiveForm 的 single， 要 获取文件实例，使用yii\web\UploadedFile::getInstance($model, 'single');
> 
> 对于使用ActiveForm 的 multiple-file， 要 获取文件实例， 使用 yii\web\UploadedFile::getInstances('multiple')

### 2.4 修改 actionUpload() 输出 文件实例子
```
public function actionUpload()
{
   
    $model = new UploadForm();

    if (Yii::$app->request->isPost) 
    {
            
        echo '<pre>';
        
        //使用 ActiveForm 
        $model->single = UploadedFile::getInstance($model, 'single');
        $model->multiple = UploadedFile::getInstances($model, 'multiple');
        print_r($model->single);
        print_r($model->multiple);
        
        echo  "\r\n--------------------------------------------\r\n";
        
        //未使用 ActiveForm 
        $singleFile = UploadedFile::getInstanceByName('single-file');
        $multipleFiles = UploadedFile::getInstancesByName('multi-file');
     
        print_r($singleFile);
        print_r($multipleFiles);
        
        echo '</pre>';
        die;
    }

    return $this->render('upload', ['model' => $model]);
}
```

### 2.5 获取结果
```
yii\web\UploadedFile Object
(
    [name] => 2017-07-30 21-35-10 的屏幕截图.png
    [tempName] => /tmp/phpwfOx2M
    [type] => image/png
    [size] => 150132
    [error] => 0
)
Array
(
    [0] => yii\web\UploadedFile Object
        (
            [name] => 2017-07-28 22-20-00 的屏幕截图.png
            [tempName] => /tmp/phpmkO8qv
            [type] => image/png
            [size] => 588277
            [error] => 0
        )

    [1] => yii\web\UploadedFile Object
        (
            [name] => 2017-07-25 22-04-50 的屏幕截图.png
            [tempName] => /tmp/phpIyCVPd
            [type] => image/png
            [size] => 658391
            [error] => 0
        )

)

---------------------------------------------------------------------------------------
yii\web\UploadedFile Object
(
    [name] => 2017-08-01 10-11-45 的屏幕截图.png
    [tempName] => /tmp/phpiUvdRD
    [type] => image/png
    [size] => 203247
    [error] => 0
)
Array
(
    [0] => yii\web\UploadedFile Object
        (
            [name] => 2017-08-01 10-11-45 的屏幕截图.png
            [tempName] => /tmp/phpUtMzfm
            [type] => image/png
            [size] => 203247
            [error] => 0
        )

    [1] => yii\web\UploadedFile Object
        (
            [name] => 2017-07-31 02-24-02 的屏幕截图.png
            [tempName] => /tmp/phpYdi1D4
            [type] => image/png
            [size] => 182599
            [error] => 0
        )

)
```
