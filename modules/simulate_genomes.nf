process simulate_genome {

  tag { genome_id + ' / ' + num_snps }

  publishDir "${params.outdir}/${genome_id}", pattern: "${genome_id}*.{fa,vcf,tsv,csv}", mode: 'copy'

  input:
    path(ref)

  output:
    path("${genome_id}.fa"), emit: seq
    tuple path("${genome_id}.vcf"), path("${genome_id}.variants.tsv"), emit: variants
    path("${genome_id}_mutation_info.csv"), emit: mutation_info

  script:
  def generator = { String alphabet, int n ->
    new Random().with {
      (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
    }
  }
  ref_name = ref.baseName.split('\\.')[0]
  prefix = generator((('A'..'F')+('0'..'9')).join(), 4)
  genome_id = ref_name + '-' + prefix
  num_snps = Math.abs(new Random().nextInt() % params.max_snps.toInteger() + params.min_snps.toInteger())
  """
  echo 'genome_id,num_snps' > ${genome_id}_mutation_info.csv
  echo "${genome_id},${num_snps}" >> ${genome_id}_mutation_info.csv
  simuG -refseq ${ref} -snp_count ${num_snps} -prefix ${genome_id}
  mv ${genome_id}.simseq.genome.fa ${genome_id}.fa
  sed -i '/^>/!s/.\\{70\\}/&\\n/g' ${genome_id}.fa
  sed -i 's/^>.*/>${genome_id}/g' ${genome_id}.fa
  mv ${genome_id}.refseq2simseq.map.txt ${genome_id}.variants.tsv
  mv ${genome_id}.refseq2simseq.SNP.vcf ${genome_id}.vcf
  """
}

