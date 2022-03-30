# Simulate Genomes
This pipeline is designed to simulate full genomes, derived from reference genomes, with some genomic variation.
The intention of this pipeline is to be used as a tool to create datasets that can be used as part of a validation experiment for other
microbial genomics analysis pipelines.

## Dependencies
Dependencies are listed in [environments.yml](environments/environment.yml). When using the `conda` profile, they will be installed automatically.
Other runtime environments such as docker, podman or singularity are not currently supported.

## Usage
The pipeline takes a single reference genome as input, in FASTA format.

To run the pipeline with default parameters:

```
nextflow run dfornika/simulate-genomes \
  -profile conda \
  --cache ~/.conda/envs \
  --ref </path/to/ref> \
  --outdir </path/to/outdir>
```

Several parameters are available to control the amount of genomic variation that is introduced in the simulation process.

| Parameter   | Description                                          | Default |
|:------------|:-----------------------------------------------------|--------:|
| `min_snps`  | Minimum number of SNPs that will be introduced.      | 2       |
| `max_snps`  | Maximum number of SNPs that will be introduced.      | 20      |

## Output
For each simulated genome, a four-character semi-random string will be appended to the original input genome name. For example, starting with an input file named `ATCC-BAA-2779.fasta`
will generate the following outputs.

```
ATCC-BAA-2779-DCDE
    ├── ATCC-BAA-2779-DCDE.fa
    ├── ATCC-BAA-2779-DCDE_mutation_info.csv
    ├── ATCC-BAA-2779-DCDE.variants.tsv
    └── ATCC-BAA-2779-DCDE.vcf
```
