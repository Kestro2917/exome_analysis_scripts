path="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/Mutect/"   #Declare path of folder
mkdir $path/T-N_Mutect;
for file in $(find $path/* -type f -name "T*_fixed_sorted_realn_DupRm_recal.mutect.txt");
do
mutect_filename_with_extn=$(basename $file) ;
mutect_filename_without_extn="${mutect_filename_with_extn%_fixed_sorted_realn_DupRm_recal.mutect*}" ;
mutect_filename_without_T_extn=$(echo $mutect_filename_without_extn | cut -d "T" -f 2);
#Blood_File=$path/"B"$mutect_filename_without_T_extn"_fixed_sorted_realn_DupRm_recal_Mutect.mutect";
awk 'NR==FNR {Ar[$1$2$4$5] ++ ; next} ! (($1$2$4$5) in Ar)' <(cat "/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/Exome_normal_db_12_08_2014/cervical_tscc_db_12082014.vcf") $file |awk 'BEGIN { print "chr","\t","start","\t","end","\t","ref_allele","\t","alt_allele"} {if ($22 >='3') print $0 }'| sed 's/ //g' | egrep -v ^# | egrep -v ^contig  >  $path/T-N_Mutect/$mutect_filename_without_T_extn"_T-N.mutect" ;

done
echo "Done with T-N";

#$21+$22 >'3' ||