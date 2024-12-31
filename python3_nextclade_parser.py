import os

# user input for directory path
def get_directory_input(prompt):
    return input(prompt)

def check_mutation(mutation, known_mutations):
    if mutation in known_mutations:
        return "yes"
    else:
        return "no"


def get_add_value(mutation, nomenclature_dict):
    return nomenclature_dict.get(mutation, "unknown")  # Return 'unknown' if mutation not found

# remove the file extension and keep the base filename
def get_filename_without_extension(file_path):
    return os.path.splitext(os.path.basename(file_path))[0]

# Function to remove "_clean" part from the base filename
def get_filename_without_clean(file_path):
    base_name = get_filename_without_extension(file_path)
    return base_name.replace('_clean', '')  

def main():
    # prompt user
    directory_path = get_directory_input("Please enter the path to the directory containing the files: ")

     # list of known mutations:
    known_mutations = [
        #add mutations like the following:
        "C39139T"
    ]

    # dictionary of muts to clade
    nomenclature_dict = {
        #made assignments like the following into a dict:
        "C39139T": "Assignment 1"
    }

    # Create the output directory if it doesn't exist
    output_directory = os.path.join(os.getcwd(), 'parsed')
    os.makedirs(output_directory, exist_ok=True)


    for filename in os.listdir(directory_path):
        # Process only files that end with '_clean.tsv'
        if filename.endswith('_clean.tsv'):
            input_file_path = os.path.join(directory_path, filename)
            
            base_filename = get_filename_without_clean(input_file_path)

            with open(input_file_path, 'r') as file:
                lines = file.readlines()

            header = lines[0].strip().split('\t')

            # Find the index of the column with the specified name
            try:
                column_index = header.index("founderMuts['clade'].substitutions")
            except ValueError:
                print(f"Error: Column 'founderMuts['clade'].substitutions' not found in file {filename}.")
                continue

            output_file_path = os.path.join(output_directory, f"{base_filename}_parsed.tsv")

        # Create the output file and add the headers (change as needed)
            rows_to_write = []
            rows_to_write.append("seq_name\tMutations_found_on_sequence\tFound_in_Clade_I_or_Clade_II\tClade_designation\n")

            # Process the lines from the input file (skip the header)
            for line in lines[1:]:
                columns = line.strip().split('\t')  # Split the line by tab
                if len(columns) > column_index:
                    mutations = columns[column_index].split(',')  # Get the mutation column and split by commas
                    for mutation in mutations:
                        # Check if the mutation is in the known mutations list and write to the output file
                        result = check_mutation(mutation.strip(), known_mutations)
                        if result == "yes":
                            add_value = get_add_value(mutation.strip(), nomenclature_dict)
                        else:
                            add_value = "N/A"
                        # Prepend the base filename (without extension or _clean part) as the first column
                        rows_to_write.append(f"{base_filename}\t{mutation.strip()}\t{result}\t{add_value}\n")

            # Filter out rows where 'found_in_nomenclature' is "no"
            rows_to_write = [row for row in rows_to_write if "no" not in row]

            # Write the filtered rows back to the output file
            with open(output_file_path, 'w') as output_file:
                output_file.writelines(rows_to_write)

            print(f"Processed file '{filename}', output saved to '{output_file_path}'.")

if __name__ == "__main__":
    main()
