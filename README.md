# HelianthusVariants_smp_metadata

## How to set up smc++ through a cluster


### 1.) Log into your cluster along with the corresponding account with FileZilla since this would be useful to see where files goes. Upload the necessary builds  
To check that you have those builds bulit into your cluster here is the code: 
 
 module avail

 module load [build]

### Builds: 
-  Singularity 
-  Python 3.7 or greater (should be python3) 
-  gcc 4.8 or later 
-  gmp
-  mpfr
-  gsl
-  bcftools <-- this is to modify the  

### 2.) Set up singularity through this code 
 
 singularity pull smc++ docker://uvarc/smcpp:1.15.4

 View that you've installed it correctly: ./smc++ -h

source: https://hub.docker.com/r/uvarc/smcpp

### 3.) Subsetting the data with bcftools 
In order to use smc++ we must format it in the way that smc++ can read it
Download your vcf file that you want to look at. We will be using HelianthusVariants.vcf  
If you want to look at a particular chromosomes then you must split and index them

 bcftools index -s in.vcf.gz | cut -f 1 | while read C; do bcftools view -O z -o split.${C}.vcf.gz in.vcf.gz "${C}" ; done
 
Note: The reason as to why we need to index the vcf file is to save storage space and to allow your computer to work efficently

### 4.) Compress and fix ploidy (if haploid) 
So we have an split and index vcf file of each chromosomes. Put all data in a directory 
Pick one chromosome to analyze for example split.Ha7.vcf.gz 
First, we want to fix the ploidy of the data due to how the vcf file came as haploid and not diploid
 
bcftools +fixploidy split.Ha7.vcf.gz -- -f 2 > fix.Ha7.vcf 

Then compress the data once more

bgzip fix.Ha7.vcf 
tabix -p vcf fix.Ha7.vcf.gz

You should see that you have both a gz and a tbi file. Smc++ need both in order to run.
If by chance this has not worked. You must delete all files except the split file and redo it all over again.

### 5.) Working with smc++ (You can follow the github directions or the directions below)  
Now that we have the correct modified file here is the code to convert the vcf file to a smc file 

./smc++ vcf2smc fix.Ha7.vcf.gz Ha7.smc.gz Ha7 PPN:PPN019,PPN038

Note: PPN is your population and PPN019 and PPN038 is your sample population (please look at metadata)
Then you can estimate the sample size 

./smc++ estimate -o output 1e-8 Ha7.smc.gz > estimate.Ha7.vcf.gz

You will find all your plots from this code as a json file in the output directory 

To get your plots as a png file you must take the one you want to convert
Here is how to plot the models into a graph as a png 

./smc++ plot model.final.png model.final.json

This output will send your files to the output directory 
If you're looking for other codes within the smc++ function 

./smc++ -h 

### 6.) Repeat steps 4 through 6
