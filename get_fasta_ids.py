from Bio import SeqIO

def sequence_extract_fasta(fasta_files):
    fasta_id = []
    fasta_seq = []

    # opening given fasta file using the file path
    with open(fasta_files, 'r') as fasta_file:
        # extracting multiple data in single fasta file using biopython
        for record in SeqIO.parse(fasta_file, 'fasta'):  # (file handle, file format)
        
            # appending extracted fasta data to empty lists variables
            fasta_seq.append(record.seq)
            fasta_id.append(record.id)
    return fasta_id#, fatsa_seq
            
