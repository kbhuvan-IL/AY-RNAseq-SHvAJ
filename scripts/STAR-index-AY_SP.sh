#!/bin/bash
#SBATCH -N 1 
#SBATCH --ntasks 8
#SBATCH --mem 30G
#SBATCH -p normal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=kbhuvan2@illinois.edu
#SBATCH -J make.index
#SBATCH -D /home/a-m/kbhuvan2/AY-rnaseq-2024-o/results/slurm-out/indexing

# NOTE: If you use this script, make sure to change the email and -D lines above.
# Also consider increasing the memory for larger genomes.

# Change directories
cd /home/a-m/kbhuvan2/AY-rnaseq-2024-o/data/reference

# Load module
module purge #It's good to purge just in case you had module loaded already
module load STAR/2.7.10a-IGB-gcc-8.2.0

# Create a STAR index w/o annotation
# If you edit this script for your own use, you'll need to consider changing all
# but the first two options listed below.
STAR --outTmpDir /scratch/$SLURM_JOB_ID \
     --runThreadN $SLURM_NTASKS \
     --runMode genomeGenerate \
     --genomeDir STAR-2.7.10a_SAPA_YPS138_v1_allChr_Index \
     --genomeFastaFiles SAPA_YPS138_v1_allChr.fasta \
     --genomeSAindexNbases 12 \
     --sjdbGTFfile SAPA_YPS138_v1_agat.gtf \
     --sjdbOverhang 99 \
     --sjdbGTFfeatureExon CDS \
     --limitGenomeGenerateRAM 15000000000
