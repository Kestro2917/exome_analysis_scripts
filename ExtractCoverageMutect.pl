use strict;
use warnings;
use Data::Dumper;

my $inDir = "Mutect";
opendir(DIR,$inDir)||die "Can not open DIR.\n";
my @file = grep{s/\.mutect.txt$//}readdir(DIR);
foreach(@file){
	open(F1,"<"."$inDir/$_.mutect.txt")||die "Can not open F1.\n";
	my @data=<F1>;shift(@data);
	open(FW1,">"."Coverage/MUTECT/$_.mutect.cov")||die "Can not open FW1.\n";
	my @name=split(/_/,$_);
	$name[0]=~s/BT/T/;
 print "$name[0]\n";
	foreach(@data){
 chomp($_);
		my @array=split(/\t/,$_);
		print FW1 "$array[0]_$array[1]_$array[3]_$array[4]+$name[0]\t$array[20]\t$array[21]\t$array[34]\n";
	}
	close FW1;
}
