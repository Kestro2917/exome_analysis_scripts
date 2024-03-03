awk '{if($81!~/^rs/) print $0}' OncotatorOutput_final_all_addSnpCosmic.txt > OncotatorOutput_db_filteredSNP.txt 

#|| $81~/^rs/ && $82~/^COSM/