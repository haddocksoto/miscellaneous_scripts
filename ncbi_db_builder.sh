#!/bin/bash -l


#$ -cwd

# Specify the queue to submit the job
#$ -q all.q

# Specify to whom and when to send email notifications (a=abort, b=begin, e=end)
#$ -M uqo2@cdc.gov
#$ -m bae

# Specify the number of CPUs; Specify the maximum hard run time (hours:minutes:seconds); Specify the max RAM needed to run
#$ -pe smp 5
#$ -l h_rt=24:00:00 
#$ -l h_vmem=100G

#$ -o .log/db_builder.out
#$ -e .log/db_builder.err

#$ -N ncbi_db_builder

#$ -V

# Variables

DATABASE="nucleotide" #protein
ORTHOPOXVIRUS_DIR="orthopoxvirus_dir"
ORTHOPOXVIRUS_FASTA_FILE="orthopoxvirus_nucleotides.fasta"
BLAST_DB_NAME="orthopoxvirus_nt_db"
NCBI_DOWNLOAD_TYPE="all,viral" #Options: 'all', 'archaea','bacteria', 'fungi', 'invertebrate', 'metagenomes', 'plant', 'protozoa', 'vertebrate_mammalian', 'vertebrate_other', 'viral'
DBTYPE="nucl" # "prot"
GENUS="orthopoxvirus"
NCBI_FORMAT="fasta" #Options: 'genbank', 'fasta', 'rm','features', 'gff', 'protein-fasta', 'genpept', 'wgs', 'cds-fasta', 'rna-fna', 'rna-fasta', 'assembly-report', 'assembly-stats', 'all'

QUERY_FILE="proteins.fasta"
PROGRAM="blastn"
BLAST_RESULTS="blastp_results.txt"

# load modules 
module load Entrez/18.2
module load ncbi-genome-download/1.0
module load ncbi-blast/2.10.0


# Download Orthopoxvirus protein sequences & create a DIR (choose one method)

## Option 1
esearch -db $DATABASE -query "Orthopoxvirus[Organism]" | efetch -format fasta > $ORTHOPOXVIRUS_FASTA_FILE
mkdir $ORTHOPOXVIRUS_DIR && mv $ORTHOPOXVIRUS_FASTA_FILE $ORTHOPOXVIRUS_DIR && cd $ORTHOPOXVIRUS_DIR

# Check if download was successful and create db
if [ -s $ORTHOPOXVIRUS_FASTA_FILE ]; then
    echo "Download successful, creating BLAST protein database..."

    # Create BLAST protein database
    makeblastdb -in $ORTHOPOXVIRUS_FASTA_FILE -dbtype $DBTYPE -out $BLAST_DB_NAME

    echo "BLAST protein database created successfully."

else
    echo "Download failed or no sequences found."
fi






## Option 2
#mkdir $ORTHOPOXVIRUS_DIR
#ncbi-genome-download -g $GENUS --formats $NCBI_FORMAT --parallel 4 --output-folder $ORTHOPOXVIRUS_DIR $NCBI_DOWNLOAD_TYPE
#cat $ORTHOPOXVIRUS_DIR/virus/Orthopoxvirus/*/*.faa > $ORTHOPOXVIRUS_DIR/$ORTHOPOXVIRUS_FASTA_FILE && cd $ORTHOPOXVIRUS_DIR

# Check if concatenation was successful
#if [ -s $ORTHOPOXVIRUS_FASTA_FILE ]; then
#    echo "Download and concatenation successful, creating BLAST protein database..."

#    # Create BLAST protein database
#    makeblastdb -in $ORTHOPOXVIRUS_FASTA_FILE -dbtype prot -out $BLAST_DB_NAME

#    echo "BLAST protein database created successfully."

    # Perform BLASTP search
#    $PROGRAM -query $QUERY_FILE -db $BLAST_DB_NAME -outfmt "6 qseqid sseqid stitle evalue bitscore length pident nident mismatch gapopen qstart qend sstart send qseq sseq" -max_target_seqs 1 -out $BLAST_RESULTS

#    echo "BLASTP search completed. Results saved to $BLAST_RESULTS"

#else
#    echo "Download failed or no sequences found."
#fi



