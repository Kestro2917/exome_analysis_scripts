HC="/media/LUN4/pratik/cervical/HC/Bam_editSampleName/AllSample.raw.HC.ID"   #Declare path of folder
GATK="/media/LUN4/pratik/cervical/CervicalExome_25_06_2014/Exome/GATK_MUTECT_Merge/Recurrence_output_Exome.out";

mkdir Common_Mutation;

for file in $(find $path/* -type f -name "T*_fixed_sorted_realn_DupRm_recal_INDEL.vcf");
do
vcf_filename_with_extn=$(basename $file) ;
vcf_filename_without_extn="${vcf_filename_with_extn%_fixed_sorted_realn_DupRm_recal_INDEL*}" ;
#vcf_filename_without_T_extn=$(echo $vcf_filename_without_extn | cut -d "T" -f 2);


done
echo "Done with T-N";


