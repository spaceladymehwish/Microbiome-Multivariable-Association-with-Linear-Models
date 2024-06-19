BiocManager::install("Maaslin2")
library(Maaslin2)


#load the samples data
samples_data <- read.table("Samples.txt", header=TRUE, row.names=1, sep="\t") 
#load the metadata
metadata <- read.table("Metadata.txt", header=TRUE, row.names=1, sep="\t")
#load pathway data
pathway_data <- read.table("Pathways.txt", header=TRUE, row.names=1, sep="\t")

fit_data = Maaslin2(input_data     = samples_data, 
                    input_metadata = metadata, 
                    min_prevalence = 0,
                    normalization  = "TSS",
                    output         = "demo_output", 
                    fixed_effects  = c("diagnosis", "dysbiosis"),
                    reference      = c("diagnosis,nonIBD"))

#This can also be done with with the HUMAnN 3 untiliy `humann_split_stratified_table`
#This can also be done with with the HUMAnN 3 untiliy `humann_split_stratified_table`
unstrat_pathways <-function(dat_path){
  temp = dat_path[!grepl("\\|",rownames(dat_path)),]
  return(temp)
}

pathway_data = unstrat_pathways(pathway_data)

fit_func = Maaslin2(input_data     = pathway_data, 
                    input_metadata = metadata,, 
                    output         = "demo_functional", 
                    fixed_effects  = c("diagnosis", "dysbiosis"),
                    reference      = c("diagnosis,nonIBD"),
                    min_abundance  = 0.0001,
                    min_prevalence = 0.1)