
# Script to set up analysis of E coli variation for BINF 8960

source=/scratch/jgwall  # Source directory of files (different than in class so works on Sapelo2 cluster)

# Make subdirectories
mkdir data docs results

# Copy over data 
cp -r $source/instructor_data/raw_fastq ./data/

# Make raw data read-only
chmod -w data/raw_fastq/*.fastq*
