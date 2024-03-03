#comm -3 <(sort cervical_tscc_normal_db_b37.vcf.ID) <(sort CosmicFound.ID)  > cervical_tscc_normal_db_filteredCosmic.ID

comm -1 -2  <(sort cervical_tscc_normal_db_b37.vcf.ID) <(sort CosmicFound.ID)  > Common_cosmic.ID

#comm <(sort file1) <(sort file2) > outputfile