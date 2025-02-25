#!/bin/bash

#SBATCH -N 1
#SBATCH -n 4
#SBATCH --mail-user=kbhuvan2@illinois.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --mem 10G
#SBATCH --job-name=counts
#SBATCH --array=1-9%3
#SBATCH -p normal
#SBATCH -D /home/a-m/kbhuvan2/AY_rnaseq_2024/results/slurm-out

# STEP 1: Remember to replace question marks above with the resources you need.
#         1 node, 4 CPUs, and 7 Gb of memory. Replace email as well and fix the starting directory.

# Load the appropriate module
module purge
module load Subread/2.0.4-IGB-gcc-8.2.0

# The basename variable is already written for you, but make sure that the path to 
# "basenamesFULL.txt" is correct if you'ved changed directories above.
basename=$(sed -n -e "$SLURM_ARRAY_TASK_ID p" /home/a-m/kbhuvan2/AY_rnaseq_2024/src/basenamesFULL_SC.txt)


# STEP 2: Finish the featureCounts command. See PowerPoint for hints.

featureCounts -p --countReadPairs -t exon -g gene_id -s 2 \
-T $SLURM_NTASKS -F GTF \
-a /home/a-m/kbhuvan2/AY_rnaseq_2024/data/reference/SACE_S288C_v1_allChr_agat.gtf \
-o /home/a-m/kbhuvan2/AY_rnaseq_2024/results/featureCounts/SC/${basename}_counts \
/home/a-m/kbhuvan2/AY_rnaseq_2024/results/star_SC/${basename}Aligned.sortedByCoord.out.bam

