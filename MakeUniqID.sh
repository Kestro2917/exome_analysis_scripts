#Database key
egrep -v ^# cervical_tscc_normal_db_b37.vcf | awk '{ print $1"_"$2"_"(length($4)+$2-1)"_"$4"_"$5 }' > cervical_tscc_normal_db_b37.vcf.ID


## Cosmic key
#sed 's/chr//g' CosmicFound.txt |  awk '{ print $5"_"$6"_"$7"_"$11"_"$13 }' | uniq -u > "CosmicFound.ID"