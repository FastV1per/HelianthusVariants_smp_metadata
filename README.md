# HelianthusVariants metadata

This repo is a compliation of three machine learning simulators: smc++, discoal, and diploSHIC

All are run through a cluster through FARM, provided by the University of California, Davis

There is an md file for each step by step tutorial on how to run each simulation (eventually pictures to show output)

# Method of Madness

Here is the simplify version of what simulators you would need to run first in order to get the results that you need.
Further details are labeled within this repo. 

1.) Once you have your data, you would first run it through smc++. Here, we will subset the data for future use while also running it to see
ancetral states. Doing so will allow us to get the points for the graphs that would be later used in discoal.

2.) Once you get your points from smc++ make sure you understand discoal before using it to understand the parameters. 

3.) Head over to the diploSHIC repo and you should find a file that says 'generatesinlaunchscript.py'. You will put the points into the python script and then
take that batch script and run it into discoal, you may need to modify the script as discoal hasn't been updated in awhile. 

4.) From there, you'll have a 'train' file folder that can be transfer back to diploSHIC and allow you find hard and soft sweeps.


# Things to note

If by chance you are not running it through a cluster, please use a conda environment or some sort of computerized environment for this work
as the data that you may use for these simulators will become huge files if left uncheck and unzip.
