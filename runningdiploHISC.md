Assuming that you've gotten your population size history from smc++, go into the folder diploSHIC/diploSHIC and find the python script 'generateSimLaunchScript.py'
Look inside that file and see the following:

1.) How to run the python script
2.) All the parameters that come with it. 

Depending one what data you're using, you might need to double check the parameters that you're using. 
For example, the default mutation rate given is 3.5e-9 when the mutation rate for a cultivated Sunflower is 6.1e-9.
Change the parameters to your tailored data as best suited to get better accuracy. 

Another thing to note, the python script is asking for two values: Time and year which population size changed to that time 

If we look into your csv file that was made using smc++, we could see that it has four columns, two of them are the ones that we would 
need in order for the python script to work. You may need to manipulate the columns, but once you've done so run the following code:

python3 generateSimLaunchScript.py filefromsmc++.csv train test > launch_script.sh

This will generate a batch scirpt that can be run through an interactive cluster or a job through this code:

sbatch -t 1440 launch_script.sh 

The time is by minutes and 1440 minutes is about 24 hours. Depending on how large your data is, this will about a whole day to run so hence we're running it for about 24 hours.

If you run it in the diploSHIC/diploSHIC folder you will get an erorr code stating discoal is not found in this directory. Transfer that file into the disocal folder that you've git clone and run the batch script through there.
By the off chance that you're still getting an erorr code, make sure that within the batch script that discoal is formatted correctly into './discoal' and not disocal.
Remember the interactive discoal is a hidden file that is not normally seen on FileZilla as I explained in runningsmc++.md. 

You will be outputted multiple *.msOut files in a train folder that you would need to create first. You can see that there are three types of files (Hard, Soft, and Neut for nutral)
From here on out you can either follow this file for further directions or the case study found here:

https://github.com/kr-colab/diploSHIC/wiki/A-soup-to-nuts-example

This link takes you to a step by step guide on using diploSHIC using a case study as an example. 
