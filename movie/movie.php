<?php
/**
 * @file
 * @brief WEBスクレイピングクラス
 * @author yano-tatsuya
 * @date 2014-05-20
 */

require_once ini_get('include_path') . '/lib/Data.php';

class movie extends Data
{

    private $_cut_time = 10;
    private $_movie = null;
    private $_out_file_path = null;
    private $_frame_rate = null;
    private $_duration = null;

    public function readMovie()
    {
        // 動画の読み込み
        $this->_movie = new ffmpeg_movie($this->getFilePath());
        // フレームレート取得
        $this->_frame_rate = $this->_movie->getFrameRate();
        // 動画秒数
        $this->_duration = $this->_movie->getDuration();

    }

    public function cutThumbnail()
    {

        // 3 秒目のフレームを計算
        $target_frame = $this->_frame_rate * $this->_cut_time;
        // 該当する箇所のフレームオブジェクト取得
        $frame = $this->_movie->getFrame($target_frame);
        // GD イメージオブジェクト生成
        $image = $frame->toGDImage();
        ImageJPEG($image, $this->_out_file_path);

    }

    public function setCutTime($time)
    {
        $this->_cut_time = $time;
        return;
    }

    public function setOutFilePath($path)
    {
        $this->_out_file_path = $path;
        return;
    }

    public function getFrameRate()
    {
        return $this->_frame_rate;
    }

    public function getDuration()
    {
        return $this->_duration;
    }
}
