path="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/Mutect/T-N_Mutect"   #Declare path of folder
path2="/media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/Exome"
mkdir "$path2/Recurrence_analysis_MUTECT";
for file in $(find $path/* -type f -name "*.mutect");
do
mutect_filename_with_extn=$(basename $file) ;
mutect_filename_without_extn="${mutect_filename_with_extn%_T-N.mutect*}" ;
awk ' { print $1,"_",$2,"_",$3=length($4)+$2-1,"_",$4,"_",$5 }' $file | sed 's/ //g' > $path2/Recurrence_analysis_MUTECT/$mutect_filename_without_extn".maflite.txt" 
done;


cat $path2/Recurrence_analysis_MUTECT/*.txt | sed 's/allele$//g' | sort -u > $path2/Recurrence_analysis_MUTECT/Recurrence_output_Exome.out
#
sed -i '/chr_/d' $path2/Recurrence_analysis_MUTECT/Recurrence_output_Exome.out
#
while read line;  
do recurrent_pair=$(grep -Fx $line $path2/Recurrence_analysis_MUTECT/*.txt| cut -f 9 -d '/'| cut -f 1 -d '.'| tr '\n' '.'| sed 's/.$//g'); echo -e $line'\t'$recurrent_pair >> $path2/Recurrence_analysis_MUTECT/output_with_samples_Exome.txt ;
done < $path2/Recurrence_analysis_MUTECT/Recurrence_output_Exome.out

sed -i 's/_/\t/g' $path2/Recurrence_analysis_MUTECT/output_with_samples_Exome.txt
sed -i '1ichr\tstart\tend\tref_allele\talt_allele\tsource' $path2/Recurrence_analysis_MUTECT/output_with_samples_Exome.txt
