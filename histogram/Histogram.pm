package Histogram;
$|=1;
 
use strict;
use Data::Dumper;
use Imager;
use List::Util qw(min sum);
use List::MoreUtils qw/each_array/;

sub new
{
	my $pkg = shift;
	bless{
		#比較対象画像ファイル名1
		'img' => undef,
		#比較対象画像ファイル1のバイナリデータ
		'img_obj' => undef,
		#比較対象画像ファイル1のヒストグラムデータ
		'hist' => undef,
	},$pkg;
}

#イメージファイルの読み込み
sub readImg
{

	my $pkg = shift;

	$pkg->{img_obj} = Imager->new or die;
	$pkg->{img_obj}->read(file => $pkg->{img}) or die $pkg->{img_obj}->errstr;

}

#イメージファイルのヒストグラム化
sub getLazyHistgram
{

	my $pkg = shift;

	$pkg->{hist} = getLazyHistgram64($pkg->{img_obj});

}

#64色まで減色
sub getLazyHistgram64 
{
	my $img = shift;
	my @rgb = ();

	my $lazy_histgram = [ map { 0 } 0..64 ];
	my $colors = $img->getcolorusagehash;

	foreach my $k (keys %{$colors||{}}) {
		#画像のバイナリーデータを10進整数へ変換
		@rgb = unpack("C*", $k);
		$lazy_histgram->[rgbToBin64(equalizeRgb64(@rgb))]++;
	}

	return $lazy_histgram;
}

sub equalizeRgb64 
{
	my ($cr, $cg, $cb) = @_;
	return _equalize64($cr), _equalize64($cg), _equalize64($cb);
}

sub _equalize64 {
	my $cc = shift;
	return 32  if ($cc < 64);
	return 96  if ($cc < 128);
	return 160 if ($cc < 196);
	return 224;
}

sub rgbToBin64 
{
	my ($red, $green, $blue) = @_;
	return 16 * int($red / 64) + 4 * int($green / 64) + int($blue / 64);
}

#Histogram Intersectionロジックを使って類似性を算出
sub calcHistIntersection
{

	my $pkg = shift;
	my ($histogram1, $histogram2) = @_;

	my $total = undef;
	my $ea = each_array( @$histogram1, @$histogram2 );
	while(my ($histogram1, $histogram2) = $ea->()) {
		$total += min($histogram1, $histogram2);
	}
	return $total / sum(@$histogram1);

}

#セッター群
sub setImg
{
	my $pkg = shift;
	$pkg->{img} = shift;
}
 
sub setImgObj
{
	my $pkg = shift;
	$pkg->{img_obj} = shift;
}
 
sub setHist
{
	my $pkg = shift;
	$pkg->{hist} = shift;
}
 
#ゲッター群
sub getImg
{
	my $pkg = shift;
	return $pkg->{img};
}
 
sub getImgObj
{
	my $pkg = shift;
	return $pkg->{img_obj};
}
 
sub getHist
{
	my $pkg = shift;
	return $pkg->{hist};
}
 
