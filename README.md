# FineRadStructure_Pipeline
How to run [fineRADstructure and RADpainter](https://github.com/millanek/fineRADstructure) on RAD data

This document provides notes and instructions on running `RADpainter` and `fineRADstructure` on Restriction site-associated DNA sequencing data. `RADpainter` and `finRADstructure` are programs for the estimation of co-ansestry with RADseq data. See the publication by [Malinsky et al.](https://academic.oup.com/mbe/article/35/5/1284/4883220) and [Malinsky's homepage](https://www.milan-malinsky.org/fineradstructure) for detailed instructuions.

This document serves as an addtional resource to the github and instructions already provided by Malinsky et al. for running analyses with finRADstrucutre. 

## Overall Pipeline Summary
raw RAD reads (fastq file) -> see [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) -> `RADpainter` file from `stacks` -> `RADpainter` -> fineSTRUCURE -> graph outputs

## Pipelline Steps

### Step 1: Process raw RAD reads
See [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) for instructions on how to process raw RAD reads after you get your giant fastq.gz file from the sequencing facility. At the step for running `populations` in `stacks`, you will need to make sure you add the flag `--radpainter` to have the `populations` module output a radpainter file, the preferred input of radpainter. Make sure that you are filtering by haplotypes, and not just snps, as radpainter is a haplotype level analysis. Make sure you use the flag `--filter-haplotype-wise` along with the standard filters `-r .80`, `-p # pops`, and `-mac 3`. Even if you have a whitelist of filtered snps from before, note that reapplying these filters for haplotypes may  remove some loci if the haplotype is missing some data but that snp wasn't. In this pipeline, I ran 10k loci from a whitelist, but `fineRADstructure` can handle more loci, if desired. If you want to learn more on how `stacks` filtlers and handles haplotypes and the respective haplotype outputs see the [protocol paper](https://www.biorxiv.org/content/10.1101/2021.11.02.466953v1) and [stacks 2 paper](https://onlinelibrary.wiley.com/doi/full/10.1111/mec.15253).

For an example script of running `populations` to get the structure file see [run_populations.sh](run_populations.sh)

### Step 2: Running `RADpainter` and `fineStructure`

Using the script [run_fineradstructure.sh](run_fineradstructure.sh), you can run both `RADpainter` and `fineSTRUCTURE` on the output radpainter file that `stacks` provides you. This is will give you a number of output files, of which you will need `populations.haps_chunks.mcmc.xml`, `populations.haps_chunks.mcmcTree.xml`, and `populations.haps_chunks.out` to make your graphs to visualize the coansestry of your populations. 

### Step 3: Graph the output

Use the scripts [fineRADstructureplot.R](fineRADstructureplot.R) and [FinestructureLibrary.R](FinestructureLibrary.R) to graph the outputs from the previous step. You shouldn't have to modify anything in FinestructureLibrary.R, but you will need to make sure you install the dependent packages and change the paths and working directory in fineRADstructureplot.R. You will need to use `populations.haps_chunks.mcmc.xml`, `populations.haps_chunks.mcmcTree.xml`, and `populations.haps_chunks.out` to make your graphs. I last ran the plotting script successfully in `R version 4.0.1` on a windows machine. You will get 3 graphs of your data. Note that the labels can get really squiushed and wonky, especially if you are running many individuals. You may need to change the margins of you pdf to fit the names in. 
