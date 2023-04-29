#!/bin/bash

module load conda/diploshic/1.0.4

diploSHIC fvecSim diploid test.msOut testbeta.diploid.fvec

# make sure that the file for (test.msOut) is the same with this script or else you will see nothing