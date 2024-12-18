#! /usr/bin/perl
use strict; use warnings;
use 5.10.0;
use File::Spec;

my ($prefix, $stripfix); 

my $dir = File::Spec->rel2abs($0); $dir =~ s/\/[^\/]+$//;

open OUT, ">job";
for (glob "Isles/*"){
 next unless /(\S+)/;
 $prefix = $1;
 $prefix =~ s/Isles\///; 
 $stripfix = $prefix; $stripfix =~ s/\.x$//;
 next if ($prefix eq "phage.txt" or $prefix eq "ICE.txt");
 my $head = substr($prefix, 0, 15); 
 print OUT "cd Isles/$prefix; perl $dir/ice.pl genome.fa; cd ../../;\n"; 
 print OUT "cd Isles/$prefix; perl $dir/phage.pl genome.fa; cd ../../;\n"; 
 if ($prefix =~ /\.x$/) {next} else {system "perl -pi -e 's/>\\S+/>$head/' Isles/$prefix/genome.fa; \n";}
}
close OUT; 
