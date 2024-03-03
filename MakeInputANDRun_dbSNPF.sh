#path=/media/LUN4/pratik/cervical/CervicalExome_23_07_2014/Exome/GATK_MUTECT_Merge_all;
#sed 's/_/\t/g' $path/Recurrence_output_Exome.out  > $path/Input_dbNSFP_all.input
#awk '{print $1,$2,$4,$5}' $path/Input_dbNSFP_all.input > $path/Input_dbNSFP_all.txt
#/opt/databases/dbNSFPv2.4/
java -Xmx5g search_dbNSFP24 -i /media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/dbNSFP/dbNSFPInput.txt -o /media/LUN4/pratik/cervical/CervicalExomechangeOrder_8_12/dbNSFP/dbNSFPOutput.txt

#java -Xmx5g search_dbNSFP24 -i tryhg19.in -o ~/tryhg19.out