#!/bin/bash

#SBATCH -N 1
#SBATCH -n 4
#SBATCH --mail-user=kbhuvan2@illinois.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --mem 10G
#SBATCH --job-name=counts
#SBATCH -p normal
#SBATCH -D /home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/slurm-out/counting

# STEP 1: Remember to replace question marks above with the resources you need.
#         1 node, 4 CPUs, and 7 Gb of memory. Replace email as well and fix the starting directory.

# Load the appropriate module
module purge
module load Subread/2.0.4-IGB-gcc-8.2.0

# The basename variable is already written for you, but make sure that the path to 
# "basenamesFULL.txt" is correct if you'ved changed directories above.


# STEP 2: Finish the featureCounts command. 

featureCounts -p --countReadPairs -t exon -g gene_id -s 2 \
-T $SLURM_NTASKS -F GTF \
-a /home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/reference/SACE_SAPA_gtf-agat_cat_hyb.gtf \
-o /home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/featureCounts/hybrid_counts.txt \
/home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/star/YMX502B07*.bam

