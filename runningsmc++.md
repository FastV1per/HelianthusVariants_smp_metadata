## How to set up smc++ through a cluster


### 1.) Log into your cluster along with the corresponding account with FileZilla since this would be useful to see where files goes. 
Upload the necessary builds:

module load [build]  

To check that you have those builds bulit into your cluster here is the code: 
 
 module avail

### Builds:
Here are the builds for smc++ (plase also refer to the main repository here: https://github.com/popgenmethods/smcpp 
-  Singularity 
-  Python 3.7 or greater (should be python3) 
-  gcc 4.8 or later 
-  gmp
-  mpfr
-  gsl
-  bcftools <-- this is to modify the data  

### 2.) Set up singularity through this code 
 
 singularity pull smc++ docker://uvarc/smcpp:1.15.4

 View that you've installed it correctly: ./smc++ -h

source: https://hub.docker.com/r/uvarc/smcpp

### 3.) Subsetting the data with bcftools 
In order to use smc++ we must format it in the way that smc++ can read it
Download your vcf file that you're analyzing. We will be using HelianthusVariants.vcf  
If you want to look at a particular chromosomes then you must split and index them:

 bcftools index -s in.vcf.gz | cut -f 1 | while read C; do bcftools view -O z -o split.${C}.vcf.gz in.vcf.gz "${C}" ; done

Here we're creating a pipeline that says to first index the vcf file while also splitting them as well. You won't see anything for awhile since this is a large file 
The reason as to why we need to index the vcf file is to save storage space and to allow your computer to work efficently

### 4.) Compress and fix ploidy (if haploid) 
So we have an split and index vcf file of each chromosomes. Put all data in a directory 
Pick one chromosome to analyze for example split.Ha7.vcf.gz 
First, we want to fix the ploidy of the data due to how the vcf file came as haploid and not diploid
 
bcftools +fixploidy split.Ha7.vcf.gz -- -f 2 > fix.Ha7.vcf 

Then compress the data once more

bgzip fix.Ha7.vcf 
tabix -p vcf fix.Ha7.vcf.gz

You should see that you have both a gz and a tbi file. smc++ needs both in order to run.
If by chance this has not worked. Delete the gz and tbi file and redo it all over again.

### 5.) Working with smc++ (You can follow the github directions or the directions below)
If you haven't already make sure to clone the smc++ into your files folder:

git clone https://github.com/popgenmethods/smcpp  

Now that we have the correct modified file here is the code to convert the vcf file to a smc file: 

./smc++ vcf2smc fix.Ha7.vcf.gz Ha7.smc.gz Ha7 PPN:PPN019,PPN038

The ./ is the run code for singularity since you can physically modifiy the file yourself: 
Note: PPN is your population and PPN019 and PPN038 is your sample population (please look at metadata). If you want to compare more than 2 observations order the PPN number by the type of category (ex. PPPHA1, PPNHA2, PPNRHA1, PPNRHA2..etc)
Then you can estimate the sample size: 

./smc++ estimate -o output 1e-8 Ha7.smc.gz > estimate.Ha7.vcf.gz

You will find all your plots from this code as a json file in the output directory. You can modify the output directory to whatever it must be  

To get your plots as a png file you must take the one you want to convert
Here is how to plot the final model into a graph as a png while also getting the points in a CSV file

./smc++ plot model.final.png model.final.json -c model.final.csv

If you want all the output models graph into one here is the code for it: 

./smc++ plot model.combfinal.png .model.iter*.json model.final.json
 
If you're looking for other codes within the smc++ function 

./smc++ -h 

### 6.) Repeat steps 4 through 6

Important note: if smc++ is not working by the off chance here are some tips I recommend:
1.) Make sure your working your files where the smc++ file is present. If your in your output directory and smc++ is not there, smc++ will not work 
2.) Ask for help, as once told by my very wise coding professor, coding is meant to be collaborated! Otherwise there would be no reasearch to be done. 
3.) Google-ing is an iffy option as whatever you're trying to search has to be very specific. 
