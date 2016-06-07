#include "parameters.h"

Parameters::Parameters(int argc,char ** argv):
	_N           (atoi(argv[1])),          
        _T           (atof(argv[2])),
        _dt          (atof(argv[3])),
        _output_flag (atoi(argv[4]))
{
        // argument handling
	if (argc<5){
		fprintf(stderr, "usage: ./sim_cuda <maximum_number_of_threads> <number_of_particles> <simulation_time> <time_step>\n");
                exit(1);
	}
}
