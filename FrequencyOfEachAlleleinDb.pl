use strict;
use warnings;
use Data::Dumper;
open FH, "<db.vcf" || die $!;
open FW, ">frequencyAllele.tab" || die $!;
open FW1, ">FreqVar.tab" || die $!;
open FW2, ">db_removeFreqAllele.vcf" || die $!;
my @vcf=<FH>;
my %data=();
my %head=();
my %freq=();
my %data_1=();
my %coverage=();
foreach my $line (@vcf){
	chomp($line);
	#print $_;
	if($line =~ /#/){
		my @line=split(/\t/,$line);
		for(my $i=9;$i<37;$i++){
			$head{$i}=$line[$i];
		}
	}else{
		chomp($line);
		my @line=split(/\t/,$line);
		my $key="$line[0]"."_"."$line[1]"."_"."$line[3]"."_"."$line[4]";
		for(my $i=9;$i<36;$i++){
			if($line[$i] ne "\."){
			push(@{$data{$key}}, $head{$i});
			$data_1{$key}{$head{$i}}=$line[8]."_".$line[$i];
			}
		}
	}
}

#print Dumper(%data_1);
foreach my $key(sort {$a cmp $b} keys(%data)){
	my $len=scalar(@{$data{$key}});
	print FW "$key\t$len\t@{$data{$key}}\n";
	push(@{$freq{$len}},$key);
}
print "Frequency of Allele Occur once:\n";
foreach my $key(sort keys(%freq)){
	print FW1 "$key\t\t@{$freq{$key}}\n";
	if($key == 1){
		foreach(@{$freq{$key}}){
			my $key1=$_;
			print "$key1\n";
			my @key2=@{$data{$_}};
			foreach(@key2){
				my $key2=$_;
				my $val=$data_1{$key1}{$key2};
				my @val =split(/_/,$val);
				my @dp=split(/:/,$val[0]);
				my @dp_val=split(/:/,$val[1]);
				my $cnt=0;
				foreach(@dp){
					if($_=~/DP/){
						if($dp_val[$cnt]<=3){
							#print "$key1\t$key2\t$dp[$cnt]\t$dp_val[$cnt]\n";
							$coverage{$key1}=$dp_val[$cnt];
						}
					}
					else{$cnt++;}
				}
			}
		}
	}
}
print "\nCoverage:\n\n";
print Dumper(%coverage);
print "\n\nRemoved Lines\n";
foreach my $line(@vcf){
if($line =~ /#/){
	print FW2 "$line\n";
	}else{
	my @line=split(/\t/,$line);
	my $key="$line[0]"."_"."$line[1]"."_"."$line[3]"."_"."$line[4]";
	if(defined $coverage{$key}){
		print "$line\n";
	}else{
	print FW2 "$line\n";
	}
	}
}