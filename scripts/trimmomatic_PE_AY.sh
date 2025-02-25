#!/bin/bash
# ----------------SLURM Parameters----------------
#SBATCH -p normal
#SBATCH -n 4
#SBATCH --mem=16g
#SBATCH -N 1
#SBATCH --mail-user=kbhuvan2@illinois.edu
#SBATCH --mail-type=ALL
#SBATCH -J trimmomatic
#SBATCH -D /home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/slurm-out/trimming
#SBATCH --array 1-54%3

# NOTE: If you use this script, make sure to change the array, partition, email, and -D lines above.
# The -D line should be set to somewhere in your home directory.
# The --array line should be the number of samples you have. For example, if you have 25 samples, the it should be set to 1-25%3

# ----------------Load Modules--------------------
module purge
module load Trimmomatic/0.39-Java-1.8.0_201

# ----------------Commands------------------------
# Make sure to have a file in src/ named basenamesFULL.txt which includes a list of base filenames without the extension.
line=$(sed -n -e "$SLURM_ARRAY_TASK_ID p" /home/a-m/kbhuvan2/AY-rnaseq-2024-o/src/basenamesFULL.txt)

# Make sure that the file extensions after "${line}" are correct below. Also check the paths to the files.
trimmomatic PE -phred33 -threads 4 \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/raw-seq/${line}_R1_001.fastq.gz \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/raw-seq/${line}_R2_001.fastq.gz \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/trimmomatic/${line}_R1_paired.fastq \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/trimmomatic/${line}_R1_unpaired.fastq \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/trimmomatic/${line}_R2_paired.fastq \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/trimmomatic/${line}_R2_unpaired.fastq \
ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE-2.fa:2:15:10 \
LEADING:28 TRAILING:28 MINLEN:30

