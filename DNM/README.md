# WGS_SNV_pipeline

Requirements:
- Nextflow v22.04.0
- [Platypus](https://github.com/andyrimmer/Platypus)


## Input :

1) input.csv a tab-delimited file containing the ID of proband  in the first column and the absolute path of the proband, mother, and father CRAMs/BAMs in the second column, separated by # , .  An example is provided. 
2) ped file (ID_proband\tID_MOM\tID_DAD\tSEX)

## Running: 

An example of command needed are required

`nextflow platypus_nx.nf --reference_file /path/.fasta  --alignment_list input.csv --pedigree_file family.ped --outdir result --denovo_script /path/script/bayesianDeNovoFilter.py --bind_path /path_of_fasta, /path_of_cram -resume `


## Output :
In a `result` folder two files are generated: 
- VCF of calls calling from Platypus called `$ID-platypus.vcf`
- DMNs VCF filtered small variants of `bayesianDeNovoFilter.py` script provided by platypus developers

