#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { simulate_genome } from './modules/simulate_genomes.nf'

workflow {
  ch_ref = channel.fromPath(params.ref)

  main:
    simulate_genome(ch_ref)

}
