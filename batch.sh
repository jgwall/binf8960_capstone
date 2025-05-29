#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=test
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem=2gb


cd /scratch/jgwall/ecol_test2

# Run e coli pipeline
#bash setup.sh
bash read_qc.sh
#bash variant_calling.sh
