<?php
/**
 * @file
 * @author yano-tatsuya
 * @date 2014-05-20
 */

require_once '../lib/include.php';
require_once ini_get('include_path') . '/lib/Data.php';

class histogram extends Data
{

    private $_img_file = null;
    private $_img_obj = null;
    private $_img_hist = null;

    public function readImage()
    {

        $img = imagecreatefrompng($this->_img_file);
print_r($img);
        $imagex = imagesx($img);
        $imagey = imagesy($img);

    }

    public function setImgFile($file)
    {
        $this->_img_file = $file;
        return;
    }

    public function setImgObj($obj)
    {
        $this->_img_obj = $obj;
        return;
    }

    public function setImgHist($hist)
    {
        $this->_img_hist = $hist;
        return;
    }

    public function getImgFile()
    {
        return $this->_img_file;
    }

    public function getImgObj()
    {
        return $this->_img_obj;
    }

    public function getImgHist()
    {
        return $this->_img_hist;
    }

}

$img = new histogram;
$img->setImgFile('a.jpg');
$img->readImage();
