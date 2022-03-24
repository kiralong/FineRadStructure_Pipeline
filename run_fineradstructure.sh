#!/bin/bash
#SBATCH -p aces
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -J manacus_radpainter
#SBATCH -t 168:00:00
#SBATCH --mail-user user@email.edu
#SBATCH --mail-type ALL

work_dir=/projects/aces/user/chapter_1_HZ_movement/fineradstructure
bin=/projects/aces/user/programs/fineRADstructure
cd $work_dir

haps=populations.haps.radpainter
out=populations.haps

# Co-Ancestry
$bin/RADpainter paint $haps

# Assign to Pops
$bin/finestructure -x 100000 -y 100000 -z 1000 ${out}_chunks.out ${out}_chunks.mcmc.xml

# Build Trees
$bin/finestructure -m T -x 10000 ${out}_chunks.out ${out}_chunks.mcmc.xml ${out}_chunks.mcmcTree.xml
