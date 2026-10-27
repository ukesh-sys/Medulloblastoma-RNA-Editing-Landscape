#!/bin/bash
#SBATCH --job-name=ICGC_MB2.align
#SBATCH --output=ICGC_MB2.align.out
#SBATCH --error=ICGC_MB2.align.err
#SBATCH --time=72:0:0
#SBATCH --ntasks-per-node=48
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=END
#SBATCH --mail-user=ukark001@fiu.edu

module load anaconda
conda activate Ukesh_env
module load cutadapt
module load STAR
module load gatk

/home/kandarpj/tools/TrimGalore-0.6.7/trim_galore -j 8 --paired -o 02_trimmed --path_to_cutadapt '/data/apps/extern/singularity/samtools.bwa-mem/samtools.bwa-mem.sif cutadapt' EGAF00001590573/RNA_paired_ICGC_MB2_HWUSI-EAS451_00018_FC_62YJ4AAXX_5_1.fastq.gz EGAF00001590574/RNA_paired_ICGC_MB2_HWUSI-EAS451_00018_FC_62YJ4AAXX_5_2.fastq.gz
/home/kandarpj/tools/TrimGalore-0.6.7/trim_galore -j 8 --paired -o 02_trimmed --path_to_cutadapt '/data/apps/extern/singularity/samtools.bwa-mem/samtools.bwa-mem.sif cutadapt' EGAF00001590575/RNA_paired_ICGC_MB2_HWUSI-EAS453_00010_FC62JNWAAXX_1_1.fastq.gz EGAF00001590576/RNA_paired_ICGC_MB2_HWUSI-EAS453_00010_FC62JNWAAXX_1_2.fastq.gz
/home/kandarpj/tools/TrimGalore-0.6.7/trim_galore -j 8 --paired -o 02_trimmed --path_to_cutadapt '/data/apps/extern/singularity/samtools.bwa-mem/samtools.bwa-mem.sif cutadapt' EGAF00001590577/RNA_paired_ICGC_MB2_SN546_0130_A_C02YYABXX_3_1Sequence.txt.gz EGAF00001590578/RNA_paired_ICGC_MB2_SN546_0130_A_C02YYABXX_3_2Sequence.txt.gz
/home/kandarpj/tools/TrimGalore-0.6.7/trim_galore -j 8 --paired -o 02_trimmed --path_to_cutadapt '/data/apps/extern/singularity/samtools.bwa-mem/samtools.bwa-mem.sif cutadapt' EGAF00001590579/RNA_paired_ICGC_MB2_SN546_0218_A_C2L5AACXX_1_1Sequence.txt.gz EGAF00001590580/RNA_paired_ICGC_MB2_SN546_0218_A_C2L5AACXX_1_2Sequence.txt.gz
/home/kandarpj/tools/TrimGalore-0.6.7/trim_galore -j 8 --paired -o 02_trimmed --path_to_cutadapt '/data/apps/extern/singularity/samtools.bwa-mem/samtools.bwa-mem.sif cutadapt' EGAF00001590581/RNA_paired_ICGC_MB2_SN935_0096_B_D0BT6ABXX_1_1Sequence.txt.gz EGAF00001590582/RNA_paired_ICGC_MB2_SN935_0096_B_D0BT6ABXX_1_2Sequence.txt.gz
STAR --genomeDir ../../../ref/STARindex --runThreadN 40 --twopassMode Basic --outSAMtype BAM SortedByCoordinate --outFilterType BySJout --outSAMattributes All --outFilterMultimapNmax 20 --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 --sjdbOverhang 100 --outSAMunmapped Within --outFileNamePrefix 03_align_star/ICGC_MB2/ICGC_MB2.nonUniq. --readFilesCommand zcat --outSAMattrRGline ID:ICGC_MB2 LB:lib1 SM:ICGC_MB2 PL:Illumina --readFilesIn 02_trimmed/RNA_paired_ICGC_MB2_HWUSI-EAS451_00018_FC_62YJ4AAXX_5_1_val_1.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_HWUSI-EAS451_00018_FC_62YJ4AAXX_5_2_val_2.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_HWUSI-EAS453_00010_FC62JNWAAXX_1_1_val_1.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_HWUSI-EAS453_00010_FC62JNWAAXX_1_2_val_2.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_SN546_0130_A_C02YYABXX_3_1Sequence.txt.gz_val_1.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_SN546_0130_A_C02YYABXX_3_2Sequence.txt.gz_val_2.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_SN546_0218_A_C2L5AACXX_1_1Sequence.txt.gz_val_1.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_SN546_0218_A_C2L5AACXX_1_2Sequence.txt.gz_val_2.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_SN935_0096_B_D0BT6ABXX_1_1Sequence.txt.gz_val_1.fq.gz,02_trimmed/RNA_paired_ICGC_MB2_SN935_0096_B_D0BT6ABXX_1_2Sequence.txt.gz_val_2.fq.gz
gatk --java-options -Xmx24G MarkDuplicates -I 03_align_star/ICGC_MB2/ICGC_MB2.nonUniq.Aligned.sortedByCoord.out.bam -O 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.bam -M 03_align_star/ICGC_MB2/ICGC_MB2.metrices.txt --REMOVE_DUPLICATES false
gatk --java-options -Xmx24G BaseRecalibrator -I 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.bam -R ../../../ref/hg38.fa --known-sites ../../../ref/00-common_all.bg.vcf.gz -O 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.recal_data.table -DF MappingQualityAvailableReadFilter
gatk --java-options -Xmx24G ApplyBQSR -I 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.bam -R ../../../ref/hg38.fa --bqsr-recal-file 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.recal_data.table -O 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.BQSR.bam
bam clipOverlap --in 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.BQSR.bam --out 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.BQSR.clipol.bam
singularity exec /home/kandarpj/reditools.sif REDItoolDenovo.py -i 03_align_star/ICGC_MB2/ICGC_MB2.mkdup.BQSR.clipol.bam -f /home/kandarpj/scratch4-jperera2/kandarp/data/ref/hg38.fa -k skipchr.txt -t 25 -o 04_editing -F ICGC_MB2 -s 2 -g 2 -e -d -l -u -W -v 5 -n 0.01 -E
