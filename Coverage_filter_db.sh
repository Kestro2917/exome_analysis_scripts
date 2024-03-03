#mkdir $path2/coverage_3x_filter_VCF;
#for file in $(find $path2/* -type f -name "*.vcf") ; 
#do
#vcf_filename_with_extn=$(basename $file) ;
#vcf_filename=$(basename "$1")
#vcf_base_name="${vcf_filename_with_extn%_T-N*}"
alt_base_depth=3

file="/media/LUN4/pratik/cervical/CervicalExome_23_07_2014/Exome_normal_db/cervical_tscc_final_db_25072014.vcf";
cat $file | while read LINE 
    do 
  if echo $LINE | grep -Eq '^#'
   then
         continue;
                  echo $LINE > /media/LUN4/pratik/cervical/CervicalExome_23_07_2014/Exome_normal_db/"cervical_tscc_final_db_filtered_coverage.vcf"
  else

      echo $LINE | awk -v alt_base_count="$alt_base_depth" -v line="$LINE" '{split($10,a,":|,");if(a[3]>=alt_base_count) print line;}' >> /media/LUN4/pratik/cervical/CervicalExome_23_07_2014/Exome_normal_db/"cervical_tscc_final_db_filtered_coverage.vcf"

fi
#done
#echo "Completed!!! Output File generated as $vcf_base_name"_T-N_"$alt_base_depth"x_filtered.vcf""
done;