
# Script to set up analysis of E coli variation for BINF 8960

# Make subdirectories
mkdir data docs results

# Copy over data 
cp -r /work/binf8960/instructor_data/raw_fastq ./data/

# Make raw data read-only
chmod -w data/raw_fastq/*.fastq*
