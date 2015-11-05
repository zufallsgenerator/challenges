#! /usr/bin/perl

use warnings;
use strict;

use Digest::SHA1;

sub Cfdata
{
my $ehead="n19";
my $etail="\@gmail\.com";
my $ebel=join'', map +(0..9,'a'..'z')[rand(10+26)], 1..8;
my $data=$ehead.$ebel.$etail;
return $data;
}

sub ShDig
{
my $data = Cfdata();
#print $data."\n";
my $sha = Digest::SHA1->new;
$sha->add($data);
my $digest = $sha->hexdigest;
if ($digest =~ /^c0ffee/)
  {
    print "#############################\n";
    print "Email ID     : ".$data."\n";
    print "Coffee Digest: ".$digest."\n";
    print "#############################\n";
  }
}

##########################################
#Main Script starts here ...
my $counter = 100000000;
while ($counter > 0)
{
ShDig();
$counter -= 1;
}
##########################################
