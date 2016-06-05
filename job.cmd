#!/bin/bash

##############################################################
#
# invoke the cuda executable using the following commands 
# ./sim_cuda <maximum_number_of_threads> <number_of_particles>
# <simulation_time> <time_step> <output_flag>
#
##############################################################

./sim_cuda 512 50 10 0.001 1
