<?php
/**
 * @file
 * @brief WEBスクレイピングクラス
 * @author yano-tatsuya
 * @date 2014-05-20
 */

require_once '../lib/include.php';
require_once ini_get('include_path') . '/movie/movie.php';

class getMovie
{

    public function run()
    {

        // 動画の読み込み
        $movie = new movie;
        $movie->setFilePath('Wildlife.wmv');
        $movie->readMovie();
        $rate = $movie->getFrameRate();
        $time = $movie->getDuration();
print $time;
        $movie->setOutFilePath('a.jpg');
        $movie->cutThumbnail();

    }

}

$movie = new getMovie;
$movie->run();
