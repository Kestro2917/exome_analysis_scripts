use strict;
opendir DIR,"/media/LUN2/breast_analysis/20151124/all_files/";
open F3,">/media/LUN2/breast_analysis/20151124/all_files/recurrence_output";
#mkdir("/media/LUN1/NIlesh_analysis/Exome/MuTECT/filtered");
my @files = grep(/\.txt/,readdir(DIR));
my %hash1=();
map{
my $code=$_;
open F1,"/media/LUN2/breast_analysis/20151124/all_files/$code";
my @arr=<F1>; close(F1);
foreach my $line(@arr){
        chomp($line);
        my @array=split("\t",$line);
        push(@{$hash1{$array[0]}},$array[1]);
          }
}@files;

foreach(keys(%hash1)){
                      local $"=",";
      print F3 "$_\t@{$hash1{$_}}\n";
}