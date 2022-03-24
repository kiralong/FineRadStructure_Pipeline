#!/bin/bash
#SBATCH -p secondary
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -J populations_long_p9_r0.8_mac3_whitelist_10k_radpainter
#SBATCH -t 4:00:00
#SBATCH --mail-user user@email.edu
#SBATCH --mail-type ALL

module load gcc/7.2.0

stacks=/projects/aces/user/programs/stacks-2.60/bin
popmap_path=/projects/aces/user/chapter_1_HZ_movement/popmaps/popmap_long_samples.tsv
gstacks_out=/projects/aces/user/chapter_1_HZ_movement/gstacks_runs/220308_gstacks_rm-pcr-dups_ALL
populations_output_path=/projects/aces/user/chapter_1_HZ_movement/populations_runs
whitelist_path=/projects/aces/kira2/chapter_1_HZ_movement/whitelists/hwe_10K_loci_whitelist.tsv

mac=3
r=0.8
p=9
populations_output=$populations_output_path/populations_long_only_p${p}_r${r}_mac${mac}_whitelist_10k_loci_radpainter

mkdir -p $populations_output

cmd=(
    $stacks/populations
    --in-path $gstacks_out
    --out-path $populations_output
    --popmap $popmap_path
    --threads 4
    --min-samples-per-pop $r
    --min-mac $mac
    --min-population $p
    --whitelist $whitelist_path
    --filter-haplotype-wise
    --radpainter
)
