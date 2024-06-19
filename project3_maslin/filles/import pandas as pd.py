import pandas as pd
import os

# Directory containing the files
directory = "D:/2nd_sem/NGS/FINALS/MaAslin2_project3/project3_maslin/filles/"

# List to store DataFrames for each file
dfs = []

# Loop over each file
for file_name in os.listdir(directory):
    if file_name.endswith(".txt"):
        file_path = os.path.join(directory, file_name)
        
        # Read the file skipping lines until line 17 as headers are present at line 18
        data = pd.read_csv(file_path, sep='\t', skiprows=17)
        
        # Add sample name as a column
        data['sample'] = file_name.split(".")[0]
        
        # Append to the list
        dfs.append(data)

# Concatenate all DataFrames into one
result = pd.concat(dfs)

# Aggregate duplicate entries by taking the mean of the values
result_agg = result.groupby(['sample', 'scientific_name'])['relative_abundance'].mean().reset_index()

# Pivot the table to have samples as rows and species as columns
pivot_result = result_agg.pivot(index='sample', columns='scientific_name', values='relative_abundance')

# Fill missing abundance values with 0
pivot_result.fillna(0, inplace=True)

# Write the result to a new file
output_file = "all_samples_Specie_Abundance.txt"
pivot_result.to_csv(output_file,sep='\t')