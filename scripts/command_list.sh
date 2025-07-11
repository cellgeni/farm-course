### IRODS
# see the catalogs
ils /Sanger1/training

# check metadata
imeta ls -d /Sanger1/training/irodscourse_.JqmFYITGTG.txt

# load the data
iget -Kv /Sanger1/training/irodscourse_.JqmFYITGTG.txt

# Let's find some actual data
imeta qu -z /seq -d sample = "4861STDY7208417"

# Check the metadata
imeta ls -d /seq/24674/24674_7#32.cram

# let's find mapped data
imeta qu -z /seq -C sample = "4861STDY7208417"

# Check the catalog contents
ils /seq/illumina/cellranger/cellranger302_count_4861STDY7208417_GRCh38-3_0_0

# Check the metadata
imeta ls -C /seq/illumina/cellranger/cellranger302_count_4861STDY7208417_GRCh38-3_0_0

### LSF jobs
mkdir logs
mkdir results
bsub -G farm-course -q normal -n 1 -M "2G" -R "select[mem>2G] rusage[mem=2G]" -o "logs/output%J.log" -e "error%J.log" ./scripts/script.sh
bsub -G farm-course -q normal -n 1 -M "2G" -R "select[mem>2G] rusage[mem=2G]" -o "logs/output%J.log" -e "error%J.log" < ./scripts/script.bsub
bsub -J "[1-6]" < scripts/array_script.bsub

### Modules
module avail -C python
module load ISG/python/3.12.3
python3 ./scripts/add_values.py 5 3

module avail -C singularity
module load cellgen/singularity
singularity shell --bind /nfs/cellgeni/singularity/images/toh5ad.sif
singularity shell --bind /lustre,/nfs /nfs/cellgeni/singularity/images/toh5ad.sif

module load ISG/conda
conda create -n mypyenv python=3.11 -y
conda activate mypyenv

bsub < scripts/python_script.bsub