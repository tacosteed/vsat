#!/usr/bin/perl
package GetHistogram;
$|=1;

use strict;
use Data::Dumper;
use Histogram;


my $img_file = $ARGV[0];

my $h = Histogram->new;
$h->setImg($img_file);

$h->readImg();
$h->getLazyHistgram();
my $hist = $h->getHist();

my $hist_value = join(',', @$hist);
print $hist_value;

