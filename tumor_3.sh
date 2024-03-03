#echo "Indexing for hg19_all.fasta started at $(date)">>BWAindexing.txt
#echo "Indexing for hg19_all.fasta started at $(date)">>BWAindexing.log
#/sapfs/actrec/users/prajish/gall-bladder/bwa-0.7.5a/bwa index -p hg19_all.fasta -a bwtsw /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta
#echo "Indexing for hg19_all.fasta ended at $(date)">>BWAindexing.txt
#echo "Indexing for hg19_all.fasta ended at $(date)">>BWAindexing.log

#echo "Sai generation started for R1 sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Sai generation started for R1 sample AD0723 at $(date)">>AD0723_variantcall.log
#/sapfs/actrec/users/pawan/cervical/bwa-0.7.5a/bwa aln -t 10 -f ./output/AD0723_R1.sai /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta /sapfs/actrec/users/pawan/trupti/raw_data/sample_3/tumor_3/AD0723_R1.fastq
#echo "Sai generation ended for R1 sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Sai generation ended for R1 sample AD0723 at $(date)">>AD0723_variantcall.log

#echo "Sai generation started for R2 sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Sai generation started for R2 sample AD0723 at $(date)">>AD0723_variantcall.log
#/sapfs/actrec/users/pawan/cervical/bwa-0.7.5a/bwa aln -t 10 -f ./output/AD0723_R2.sai /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta /sapfs/actrec/users/pawan/trupti/raw_data/sample_3/tumor_3/AD0723_R2.fastq
#echo "Sai generation ended for R2 sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Sai generation ended for R2 sample AD0723 at $(date)">>AD0723_variantcall.log

#echo "Sam generation started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Sam generation started for sample AD0723 at $(date)">>AD0723_variantcall.log
#/sapfs/actrec/users/pawan/cervical/bwa-0.7.5a/bwa sampe -f ./output/AD0723.sam -r "@RG\tID:-CSC-AD0723\tPL:ILLUMINA\tLB:LIB-EXO\tSM:UNKNOWN\tPI:200" /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta ./output/AD0723_R1.sai ./output/AD0723_R2.sai /sapfs/actrec/users/pawan/trupti/raw_data/sample_3/tumor_3/AD0723_R1.fastq /sapfs/actrec/users/pawan/trupti/raw_data/sample_3/tumor_3/AD0723_R2.fastq
#echo "Sam generation ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Sam generation ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "fxd mate generation started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "fxd mate generation started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/picard-tools-1.109/FixMateInformation.jar I= ./output/AD0723.sam o= ./output/AD0723_fxd.sam VALIDATION_STRINGENCY=SILENT TMP_DIR=tmp/
#echo "fxd mate generation ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "fxd mate ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "bame generation started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "bame generation started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/picard-tools-1.109/SamFormatConverter.jar I= ./output/AD0723.sam o= ./output/AD0723.bam VALIDATION_STRINGENCY=SILENT TMP_DIR=tmp/
#echo "bame generation ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "bame generation ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "bam generation started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "bam generation started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/picard-tools-1.109/SamFormatConverter.jar I= ./output/AD0723_fxd.sam o= ./output/AD0723_fxd.bam VALIDATION_STRINGENCY=SILENT
#echo "bam generation ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "bam generation ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Sorting bam started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Sorting bam started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -Djava.io.tmpdir=`pwd`/tmp -jar /sapfs/actrec/ngs_tools/picard-tools-1.109/SortSam.jar I= ./output/AD0723_fxd.bam o= ./output/AD0723_fxd_sorted.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT
#echo "Sorting bam ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Sorting bam ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Marking duplicate started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Marking duplicate started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -Djava.io.tmpdir=`pwd`/tmp -jar /sapfs/actrec/ngs_tools/picard-tools-1.109/MarkDuplicates.jar I= ./output/AD0723_fxd_sorted.bam o= ./output/AD0723_fxd_sorted_DupRm.bam METRICS_FILE= ./output/AD0723_fxd_sorted_DupRm_info.txt REMOVE_DUPLICATES=true ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT
#echo "Marking duplicate ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Marking duplicate ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Indexing bam started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Indexing bam started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -Djava.io.tmpdir=`pwd`/tmp -jar /sapfs/actrec/ngs_tools/picard-tools-1.109/BuildBamIndex.jar I= ./output/AD0723_fxd_sorted_DupRm.bam o= ./output/AD0723_fxd_sorted_DupRm.bai VALIDATION_STRINGENCY=SILENT
#echo "Indexing bam ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Indexing bam ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Target creator started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Target creator started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -I ./output/AD0723_fxd_sorted_DupRm.bam -o ./output/AD0723_fxd_sorted_DupRm_IndelRealigner.intervals
#echo "Target creator ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Target creator ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Indel realignment started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Indel realignment started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T IndelRealigner -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -I ./output/AD0723_fxd_sorted_DupRm.bam -targetIntervals ./output/AD0723_fxd_sorted_DupRm_IndelRealigner.intervals -o ./output/AD0723_fxd_sorted_DupRm_realn.bam -log ./output/AD0723_fxd_sorted_DupRm_realn.bam.log
#echo "Indel realignment ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Indel realignment ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "bamqc started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "bamqc started for sample AD0723 at $(date)">>AD0723_variantcall.log
#/sapfs/actrec/ngs_tools/qualimap_v2.0.2/qualimap bamqc -bam ./output/AD0723_fxd_sorted.bam -nt 10 ./output/AD0723_fxd_sorted 
#echo "bamqc ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "bamqc ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "movefile started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "movefile started for sample AD0723 at $(date)">>AD0723_variantcall.log
#mv ./output/AD0723_fxd_sorted.bam .././qualimap
#echo "movefile ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "movefile ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Base recalibration started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Base recalibration started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T BaseRecalibrator -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -knownSites:dbsnp,VCF /sapfs/actrec/users/pawan/cervical/references/dbsnp_137.hg19.vcf -I ./output/AD0723_fxd_sorted_DupRm_realn.bam -o ./output/AD0723_fxd_sorted_DupRm_realn_recal.grp -cov ReadGroupCovariate -cov QualityScoreCovariate -cov CycleCovariate -cov ContextCovariate
#echo "Base recalibration ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Base recalibration ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo "Print reads started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo "Print reads started for sample AD0723 at $(date)">>AD0723_variantcall.log
#java -Xmx10G -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T PrintReads -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -BQSR ./output/AD0723_fxd_sorted_DupRm_realn_recal.grp -I ./output/AD0723_fxd_sorted_DupRm_realn.bam -o ./output/AD0723_fxd_sorted_DupRm_realn_recal.bam -baq RECALCULATE
#echo "Print reads ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo "Print reads ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

echo "SNP Call started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
echo "SNP Call started for sample AD0723 at $(date)">>AD0723_variantcall.log
java -Djava.io.tmpdir=./tmp -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -I ./output/AD0723_fxd_sorted_DupRm_realn_recal.bam -o ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.vcf --genotype_likelihoods_model SNP --annotateNDA -l INFO -log ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.log
echo "SNP Call ended for sample AD0723 at $(date)">>AD0723_variantcall.log
echo "SNP Call ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

echo "INDEL Call started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
echo "INDEL Call started for sample AD0723 at $(date)">>AD0723_variantcall.log
java -Djava.io.tmpdir=./tmp -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta  -I ./output/AD0723_fxd_sorted_DupRm_realn_recal.bam -o ./output/AD0723_fxd_sorted_DupRm_realn_recal_INDEL.vcf --genotype_likelihoods_model INDEL --annotateNDA -l INFO -log ./output/AD0723_fxd_sorted_DupRm_realn_recal_INDEL.log
echo "INDEL Call ended for sample AD0723 at $(date)">>AD0723_variantcall.log
echo "INDEL Call ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

echo " recalibration for SNP started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
echo " recalibration for SNP started for sample AD0723 at $(date)">>AD0723_variantcall.log
java -Djava.io.tmpdir=./tmp -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T VariantRecalibrator -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta --input ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.vcf -resource:hapmap,known=false,training=true,truth=true,prior=15.0 /sapfs/actrec/users/pawan/cervical/references/hapmap_3.3.hg19.vcf -resource:omni,known=false,training=true,truth=false,prior=12.0 /sapfs/actrec/users/pawan/cervical/references/1000G_omni2.5.hg19.vcf -resource:dbsnp,known=true,training=false,truth=false,prior=6.0 /sapfs/actrec/users/pawan/cervical/references/dbsnp_137.hg19.vcf -an QD -an FS -an DP -an HaplotypeScore -an MQRankSum -an ReadPosRankSum -an MQ -mode SNP -recalFile ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.recal -tranchesFile ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.tranches -rscriptFile ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP_recal.plots.R
echo " recalibration for SNP ended for sample AD0723 at $(date)">>AD0723_variantcall.log
echo " recalibration for SNP ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

echo "Apply recalibration for SNP started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
echo "Apply recalibration for SNP started for sample AD0723 at $(date)">>AD0723_variantcall.log
java -Djava.io.tmpdir=./tmp -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T ApplyRecalibration -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta --input ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.vcf -tranchesFile ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.tranches -recalFile ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.recal -mode SNP -o ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP_recal.vcf
echo "Apply recalibration for SNP ended for sample AD0723 at $(date)">>AD0723_variantcall.log
echo "Apply recalibration for SNP ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

echo " Variantannotator started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
echo " Variantannotator started for sample AD0723 at $(date)">>AD0723_variantcall.log
java -Xmx10G -Djava.io.tmpdir=`pwd`/tmp -jar /sapfs/actrec/ngs_tools/GATK/GenomeAnalysisTK-2.5-2-gf57256b/GenomeAnalysisTK.jar -T VariantAnnotator -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -I ./output/AD0723_fxd_sorted_DupRm_realn_recal.bam --alwaysAppendDbsnpId -o ./output/AD0723_fxd_sorted_DupRm_realn_recal_variantannotator_SNP.vcf --variant ./output/AD0723_fxd_sorted_DupRm_realn_recal_SNP.vcf -A Coverage --dbsnp /sapfs/actrec/users/pawan/cervical/references/dbsnp_137.hg19.vcf
echo " Variantannotator ended for sample AD0723 at $(date)">>AD0723_variantcall.log
echo " Variantannotator ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt

#echo " Mutect started for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
#echo " Mutect started for sample AD0723 at $(date)">>AD0723_variantcall.log
#/usr/bin/java -jar /opt/ngs_softwares/muTect-1.0.27783.jar -T MuTect -nt 10 -R /sapfs/actrec/users/pawan/cervical/references/hg19_all.fasta -B:cosmic,VCF /sapfs/actrec/users/pawan/cervical/references/cosmicV65_coding_hg19.vcf -B:dbsnp,VCF /sapfs/actrec/users/pawan/cervical/references/dbsnp_137.hg19.vcf -I:normal ./output/AD0723_fxd_sorted_DupRm_realn_recal.bam -I:tumor /sapfs/actrec/users/prajish/gall-bladder/exome/AD0723/AD0723_fxd_sorted_DupRm_realn_recal.bam --out /sapfs/actrec/users/prajish/gall-bladder/exome/AD0723/AD0723_fxd_sorted_DupRm_realn_recal.mutect.txt --coverage_file /sapfs/actrec/users/prajish/gall-bladder/exome/AD0723/AD0723_fxd_sorted_DupRm_realn_recal.mutect.wig.txt
#echo " Mutect ended for sample AD0723 at $(date)">>AD0723_variantcall.log
#echo " Mutect ended for sample AD0723 at $(date)">>AD0723_variantcall_echo.txt
