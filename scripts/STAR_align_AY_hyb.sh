#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks 2
#SBATCH --mem 100G
#SBATCH -p normal
#SBATCH --mail-user=kbhuvan2@address
#SBATCH --mail-type=ALL
#SBATCH -J align-star
#SBATCH --array 1-9%3
#SBATCH -D /home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/slurm-out/alignment

# Load STAR module
module load STAR/2.7.10a-IGB-gcc-8.2.0

# Change directories to the one that contains my basenamesFULL.txt file.
cd /home/a-m/kbhuvan2/AY-rnaseq-2024-o/src

# Set $basename variable to be equal to a new basename (found in \
# basenamesFULL.txt) for each job array instance.
basename=$(sed -n -e "$SLURM_ARRAY_TASK_ID p" basenamesFULL_hyb.txt)

# My unfinished STAR alignment command
# If you edit this script for your own use, you'll need to consider changing all
# but the first two options listed below.
STAR --runThreadN $SLURM_NTASKS \
     --outTmpDir /scratch/${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID} \
     --readFilesCommand zcat \
     --readFilesIn /home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/raw-seq/${basename}_R1_001.fastq.gz /home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/raw-seq/${basename}_R2_001.fastq.gz \
     --genomeDir /home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/reference/STAR-2.7.10a_SACE_SAPA_cat_hyb_Index \
     --outFileNamePrefix /home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/star/${basename} \
     --outSAMtype BAM SortedByCoordinate \
     --limitBAMsortRAM 5284559638
