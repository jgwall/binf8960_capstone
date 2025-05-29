# Run the quality control analyses on the sequencing reads


# Run FASTQC on my raw reads
echo "Running FASTQC on raw reads"
module load FastQC/0.11.9-Java-11
mkdir results/fastqc_raw_results
fastqc -o results/fastqc_raw_results data/raw_fastq/*.fastq.gz


# Run MultiQC to compile the FASTQC results
echo "Running MultiQC for raw reads"
module load MultiQC/1.14-foss-2022a
multiqc -o  results/fastqc_raw_results  results/fastqc_raw_results

# Trim raw reads with trimmomatic
echo "Running Trimmomatic"
module load Trimmomatic/0.39-Java-13
mkdir data/trimmed_fastq 
TRIMMOMATIC="java -jar /apps/eb/Trimmomatic/0.39-Java-13/trimmomatic-0.39.jar" 
for fwd in data/raw_fastq/*_1.fastq.gz
do
  sample=$(basename $fwd _1.fastq.gz)
  echo "    Trimming sample $sample" 
  $TRIMMOMATIC PE data/raw_fastq/${sample}_1.fastq.gz data/raw_fastq/${sample}_2.fastq.gz  \
      data/trimmed_fastq/${sample}_1.paired.fastq.gz data/trimmed_fastq/${sample}_1.unpaired.fastq.gz \
      data/trimmed_fastq/${sample}_2.paired.fastq.gz data/trimmed_fastq/${sample}_2.unpaired.fastq.gz \
      ILLUMINACLIP:data/raw_fastq/NexteraPE-PE.fa:2:30:10:5:True SLIDINGWINDOW:4:20
     
done


# Run FASTQC on my trimmed reads
echo "Running FASTQC on trimmed reads"
module load FastQC/0.11.9-Java-11
mkdir results/fastqc_trimmed_results
fastqc -o results/fastqc_trimmed_results data/trimmed_fastq/*.paired.fastq.gz  # Only paired reads


# Run MultiQC to compile the trimmed FASTQC results
echo "Runing MultiQC on trimmed reads"
module load MultiQC/1.14-foss-2022a
multiqc -o results/fastqc_trimmed_results results/fastqc_trimmed_results


