# Run the quality control analyses on the sequencing reads


# Run FASTQC on my raw reads
module load FastQC/0.11.9-Java-11
mkdir data/fastqc_raw_results
#fastqc -o data/fastqc_raw_results data/raw_fastq/*.fastq.gz


# Run MultiQC to compile the FASTQC results
module load MultiQC/1.14-foss-2022a
#multiqc -o  data/fastqc_raw_results  data/fastqc_raw_results

# Trim raw reads with trimmomatic
module load Trimmomatic/0.39-Java-13
mkdir data/trimmed_fastq 
TRIMMOMATIC="java -jar /apps/eb/Trimmomatic/0.39-Java-13/trimmomatic-0.39.jar" 
for fwd in data/raw_fastq/*_1.fastq.gz
do
  sample=$(basename $fwd _1.fastq.gz)
   
  $TRIMMOMATIC PE data/raw_fastq/${sample}_1.fastq.gz data/raw_fastq/${sample}_2.fastq.gz  \
      data/trimmed_fastq/${sample}_1.paired.fastq.gz data/trimmed_fastq/${sample}_1.unpaired.fastq.gz \
      data/trimmed_fastq/${sample}_2.paired.fastq.gz data/trimmed_fastq/${sample}_2.unpaired.fastq.gz \
      ILLUMINACLIP:data/raw_fastq/NexteraPE-PE.fa:2:30:10:5:True SLIDINGWINDOW:4:20
     
done


# Run FASTQC on my trimmed reads
module load FastQC/0.11.9-Java-11
mkdir data/fastqc_trimmed_results
#fastqc -o data/fastqc_trimmed_results data/trimmed_fastq/*.paired.fastq


# Run MultiQC to compile the trimmed FASTQC results
module load MultiQC/1.14-foss-2022a
#multiqc -o data/fastqc_trimmed_results data/fastqc_trimmed_results


