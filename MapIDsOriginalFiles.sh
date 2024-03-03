#awk '/^#/' cervical_tscc_normaldb_b37_concatID.vcf >> "cervical_tscc_filtered.vcf"

#join -a 1 -1 1 -2 1  <(sort -k1,1 cervical_tscc_normaldb_b37_concatID.vcf) <(sort CosmicFound.ID) >> "cervical_tscc_filtered.vcf"

#join -1 1 -2 1  <(sort -k1,1 cervical_tscc_normaldb_b37_concatID.vcf) <(sort CosmicFound.ID) >> "cervical_tscc_common.vcf"

awk 'NR==FNR {Ar[$1] ++ ; next} ! (($1) in Ar)' <(cat CosmicFound.ID) cervical_tscc_normaldb_b37_concatID.vcf >> "cervical_tscc_filtered.vcf"

#awk 'FNR==NR { a[$1,$2]=$3; next } { print $0, (a[$1,$2] ? a[$1,$2] : "0") | "column -t" }' file2 file1

egrep -v ^# "cervical_tscc_filtered.vcf" |cut -f2- > "cervical_tscc_final_db_25072014.vcf"