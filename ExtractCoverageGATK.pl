use strict;
use warnings;
use Data::Dumper;
my $inDir = "INDEL";
opendir(DIR,$inDir)||die "Can not open DIR.\n";
my @file = grep{s/\.vcf$//}readdir(DIR);
close(DIR);
#print @file;
foreach(@file){
open(F1,"<"."$inDir/$_.vcf")||die "Can not open F1.\n";
open(FW1,">"."Coverage/$_.cov")||die "Can not open FW1.\n";
my @name=split(/_/,$_);
#$name[0]=~s/B|T//;
#print "$name[0]\n";
foreach(<F1>){
	chomp($_);
	if($_ =~ /^#/){
	}else{
	my @data=split(/\t/,$_);
	my @cov=split(/\:/,$data[9]);
	#print "@cov\n";
	if($data[4]=~/\,/){
		my @alt=split(/\,/,$data[4]);
		my @cov_s=split(/\,/,$cov[1]);
		print FW1 "$data[0]_$data[1]_$data[3]_$alt[0]+$name[0]\t$cov_s[0],$cov_s[1]\t$cov[2]\n";
		print FW1 "$data[0]_$data[1]_$data[3]_$alt[1]+$name[0]\t$cov_s[0],$cov_s[2]\t$cov[2]\n";
	}else{
		print FW1 "$data[0]_$data[1]_$data[3]_$data[4]+$name[0]\t$cov[1]\t$cov[2]\n";
	}
	}
}close(FW1);
}
