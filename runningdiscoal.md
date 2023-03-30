## How to set up discoal through a cluster 

Discoal is the much slimmer version of Richard R. Hudson's ms program. However, Discoal is used to specifically find soft and hard slective sweeps. 

Thankfully, discoal is the easiest one to set up and run without any requried dependencies.

Please follow the  setup tutorial and the introductory on the git repo here: https://github.com/FastV1per/discoal 

Once you have done so, here is how to interpret the outputted data: 

example: 

./disocal 4 3 -t 5
27473 36154 ...

//
segsites: 4
pos: 0.0110 0.0765 ...
0010
0100
0000
...

//
segsites: 5
pos: 0.0491 ...
...

* First line of the output is the command line
* Second line shows tge random number of seeds proceeded by //
* Segsites is the number of polymorphic sites in the sample 
* Positions is the postion of each polymorphic site on a scale of (0,1) (Note: these positions are randomly and independently assigned from a uniform distribution)
* 0/1 are the haplotypes of each of the sampled chromosomes are given, each as a string of 0 and 1

Ancetral state is marked as 0 and the mutant is marked as 1

