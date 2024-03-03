path="/media/LUN4/pratik/cervical/new_gatk"
mkdir "/media/LUN4/pratik/cervical/VCF_03_06_14";
#mkdir "/media/LUN4/pratik/cervical/VCF_03_06_14/INDEL";
mkdir "/media/LUN4/pratik/cervical/VCF_03_06_14/SNP";
#B1023_fixed_sorted_realn_DupRm_recal_INDEL.vcf
#B1023_fixed_sorted_realn_DupRm_recal_SNP_recal.vcf
for file in $(find $path/* -type f -name "*_fixed_sorted_realn_DupRm_recal_SNP.vcf");
do
#cp $file  /media/LUN4/pratik/cervical/VCF_03_06_14/INDEL/;
cp $file  /media/LUN4/pratik/cervical/VCF_03_06_14/SNP/;
#echo $file;
done
