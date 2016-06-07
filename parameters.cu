#include "parameters.cuh"

Parameters::Parameters(int argc,char ** argv):
	_N           (atoi(argv[1])),          
        _T           (atof(argv[2])),
        _dt          (atof(argv[3])),
        _output_flag (atoi(argv[4])),
	_max_threads (atoi(argv[5]))

{
        // argument handling
	if (argc<6){
		fprintf(stderr, "usage: ./gpu  <number_of_particles> <simulation_time> <time_step> <output_flag> <maximum_number_of_threads>\n");
                exit(1);

	_blocks = 1;

	}
	

}
