# WGS_SNV_pipeline

Requirements:
- Nextflow v22.04.0
- [Platypus](https://github.com/andyrimmer/Platypus)


Input :

1) input.csv a tab-delimited file containing the ID of proband  in the first column and the absolute path of the proband, mother, and father CRAMs/BAMs in the second column, separated by #,

Running: 



Output :
In a `result` folder two files are generated: 
- VCF of calls calling from Platypus called `$ID-platypus.vcf`
- DMNs VCF filtered small variants of `bayesianDeNovoFilter.py` script provided by platypus developers

