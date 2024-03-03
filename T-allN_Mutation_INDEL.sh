###Removal of Mutation that is present in Blood(Normal) file
path="/media/LUN4/pratik/cervical/CervicalExome_25_06_2014/INDEL/Split_comma_removal_INDEL/"   #Declare path of folder
Blood_all="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/Exome_normal_db_12_08_2014/cervical_tscc_db_12082014.vcf";
OutPath="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12";
mkdir $OutPath/INDEL;
mkdir $OutPath/INDEL/T-N_VCF_allNormal;

for file in $(find $path/* -type f -name "T*_fixed_sorted_realn_DupRm_recal_INDEL.vcf");
do
vcf_filename_with_extn=$(basename $file) ;
vcf_filename_without_extn="${vcf_filename_with_extn%_fixed_sorted_realn_DupRm_recal_INDEL*}" ;
vcf_filename_without_T_extn=$(echo $vcf_filename_without_extn | cut -d "T" -f 2);
awk 'NR==FNR {Ar[$1$2$4$5] ++ ; next} ! (($1$2$4$5) in Ar)' <(cat $Blood_all) $file >>  $OutPath/INDEL/T-N_VCF_allNormal/$vcf_filename_without_T_extn"_T-N.vcf" ;

done
echo "Done with T-N";

#### Removal of comma: perl script
##Perl Script :
perl Remove_comma_T-N_VCF_allNormal_INDEL.pl;

echo "Done comma Removal";

#### Coverage Filter
path2="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/INDEL/T-N_VCF_allNormal/corrected_INDEL";
mkdir $path2/coverage_3x_filter_VCF;
for file in $(find $path2/* -type f -name "*.vcf") ; 
do
vcf_filename_with_extn=$(basename $file) ;
vcf_filename=$(basename "$1")
vcf_base_name="${vcf_filename_with_extn%_T-N*}"
alt_base_depth=3


cat $file | while read LINE 
    do 
  if echo $LINE | grep -Eq '^#'
   then
         continue;
                  echo $LINE > $vcf_base_name"_"$alt_base_depth"x_filtered.vcf"
  else

      echo $LINE | awk -v alt_base_count="$alt_base_depth" -v line="$LINE" '{split($10,a,":|,");if(a[3]>=alt_base_count) print line;}' >> $path2/coverage_3x_filter_VCF/$vcf_base_name"_"$alt_base_depth"x_filtered.vcf"

fi
done
echo "Completed!!! Output File generated as $vcf_base_name"_T-N_"$alt_base_depth"x_filtered.vcf""
done;

##### Make maflite files from VCF
#
path3="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/INDEL/T-N_VCF_allNormal/corrected_INDEL/coverage_3x_filter_VCF"
mkdir $path3/oncotator_input_GATK/;
for file in $(find $path3* -type f -name "*.vcf") ; 
do
vcf_filename_with_extn=$(basename $file) ;
vcf_base_name="${vcf_filename_with_extn%_3x_filtered*}"
awk 'BEGIN { print "chr","\t","start","\t","end","\t","ref_allele","\t","alt_allele"} { print $1,"\t",$2,"\t",$3=length($4)+$2-1,"\t",$4,"\t",$5 }' $file | sed 's/ //g' > $path3/oncotator_input_GATK/$vcf_base_name".maflite" 
done;

echo "vcf to oncotator input (INDEL) conversion ended"


#### Recurrent analysis and Oncotator call
#
path4="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/INDEL/T-N_VCF_allNormal/corrected_INDEL/coverage_3x_filter_VCF/oncotator_input_GATK";
path5="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/Exome";
mkdir $path5/Recurrence_analysis_INDEL_all/;
for f in $(find $path4* -name "*.maflite" -type f ); 
do 
  sample=$(basename $f);
	sample_name="${sample%T_INDEL_T-N_3x_filtered.maflite}";
   #sample_name="${sample%_3x_filtered.vcf.maflite}";
  vcf_filename_without_extn="${vcf_filename_with_extn%.*}" ;
	sed 's/\t/_/g' $f > $path5/Recurrence_analysis_INDEL_all/$sample_name".txt"
done;

#
cat $path5/Recurrence_analysis_INDEL_all/*.txt | sed 's/allele$//g' | sort -u > $path5/Recurrence_analysis_INDEL_all/Recurrence_output_Exome.out
#
sed -i '/chr_/d' $path5/Recurrence_analysis_INDEL_all/Recurrence_output_Exome.out
#
while read line;  
do recurrent_pair=$(grep -Fx $line $path5/Recurrence_analysis_INDEL_all/*.txt| cut -f 9 -d '/'| cut -f 1 -d '.'| tr '\n' '.'| sed 's/.$//g'); echo -e $line'\t'$recurrent_pair >> $path5/Recurrence_analysis_INDEL_all/output_with_samples_Exome.txt ;
done < $path5/Recurrence_analysis_INDEL_all/Recurrence_output_Exome.out

sed -i 's/_/\t/g' $path5/Recurrence_analysis_INDEL_all/output_with_samples_Exome.txt
sed -i '1ichr\tstart\tend\tref_allele\talt_allele\tsource' $path5/Recurrence_analysis_INDEL_all/output_with_samples_Exome.txt

#oncotator -v --input_format MAFLITE --db-dir /home/adlab/ngs_data/databases/oncotator_ds_tmp --output_format=TCGAMAF $path5/Recurrence_analysis_INDEL_all/output_with_samples_Exome.txt $path5/Recurrence_analysis_INDEL_all/output_with_samples_Exome.maf hg19
