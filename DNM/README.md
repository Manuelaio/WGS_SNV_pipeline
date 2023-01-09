# WGS_SNV_pipeline

Requirements:
- Nextflow v22.04.0
- [Platypus](https://github.com/andyrimmer/Platypus)


Input :

1) input.csv a tab-delimited file containing the ID of proband  in the first column and the absolute path of the proband, mother, and father CRAMs/BAMs in the second column, separated by #,

Output :

In a folder calls result two file are generated, the VCF of calls calling from Platypus named $ID-platypus.vcf and the DMNs filtered small variants obtained from bayesianDeNovoFilter.py script provided from platypus owens. 
