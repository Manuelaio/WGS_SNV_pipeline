nextflow.enable.dsl = 2

reference_file = file(params.reference_file, type: "file")
if (!reference_file.exists()) {
    println("--reference_file: File doesn't exist, check path.")
    exit 1
}

reference_file_index = file("${reference_file}.fai")
if (!reference_file_index.exists()) {
    println("Missing Fasta Index")
    exit 1
}


alignment_list = file(params.alignment_list, type:"file")
if (!alignment_list.exists()){
   println ("--alignment_list: File doesn't exist, check alignment file list.")
   exit 1
}

denovo_script = file(params.denovo_script, type: "file", checkIfExists: true)
data=  Channel
       .fromPath(alignment_list)
       .splitCsv(sep: "\t", header: ["sample_id", "alignment_file"])
       .map { row -> tuple(row.sample_id, row.alignment_file) }

pedigree_file = file(params.pedigree_file, type: "file", checkIfExists: true)

process calling {
    publishDir "results/$sample_id/", mode:"copy"
    input:
    tuple val(sample_id), val(alignment_file)
    output:
    tuple val(sample_id), path("$sample_id-platypus.vcf")
    script:
    """
    platypus callVariants --output=$sample_id-platypus.vcf --refFile=$reference_file --bamFiles=$alignment_file --minMapQual=1 --minVarFreq=0.01 --abThreshold=0 --mergeClusteredVariants=1 --minFlank=0 --nCPU=10 
    """
    stub:
    """
    touch $sample_id-platypus.vcf
    """
}

process DNM {
    publishDir "results/$sample_id/", mode:"copy"
    input:
    tuple val(sample_id), path(output_calling)
    output:
    tuple val(sample_id), path("${sample_id}-platypus_deNovoVariantsPassingBayesianFilter.vcf")
    script:
    """
    python $denovo_script $sample_id-platypus.vcf $pedigree_file
     
    """
    stub:
    """
    touch ${sample_id}-platypus_deNovoVariantsPassingBayesianFilter.vcf
    """
}

workflow {
   DNM(calling(data)) 
}

