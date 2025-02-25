#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks 2
#SBATCH --mem 100G
#SBATCH -p normal
#SBATCH --mail-user=kbhuvan2@address
#SBATCH --mail-type=ALL
#SBATCH -J align-star
#SBATCH --array 1-9%3
#SBATCH -D /home/a-m/kbhuvan2/AY_rnaseq_2024/results/slurm-out

# Load STAR module
module load STAR/2.7.10a-IGB-gcc-8.2.0

# Change directories to the one that contains my basenamesFULL.txt file.
cd /home/a-m/kbhuvan2/AY_rnaseq_2024/src

# Set $basename variable to be equal to a new basename (found in \
# basenamesFULL.txt) for each job array instance.
basename=$(sed -n -e "$SLURM_ARRAY_TASK_ID p" basenamesFULL_SC.txt)

# My unfinished STAR alignment command
# If you edit this script for your own use, you'll need to consider changing all
# but the first two options listed below.
STAR --runThreadN $SLURM_NTASKS \
     --outTmpDir /scratch/${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID} \
     --readFilesCommand zcat \
     --readFilesIn /home/a-m/kbhuvan2/AY_rnaseq_2024/data/raw-seq/${basename}_R1_001.fastq.gz /home/a-m/kbhuvan2/AY_rnaseq_2024/data/raw-seq/${basename}_R2_001.fastq.gz \
     --genomeDir /home/a-m/kbhuvan2/AY_rnaseq_2024/data/reference/STAR-2.7.10a_SACE_S288C_v1_allChr_Index \
     --outFileNamePrefix /home/a-m/kbhuvan2/AY_rnaseq_2024/results/star_SC/${basename} \
     --outSAMtype BAM SortedByCoordinate \
     --limitBAMsortRAM 4284559638
