#include "parameters.h"

Parameters::Parameters(int argc,char ** argv):
	_N           (atoi(argv[1])),          
        _T           (atof(argv[2])),
        _dt          (atof(argv[3])),

	_mass        (atof(argv[4])),          
        _q           (atof(argv[5])),
        _Lx          (atof(argv[6])),
        _Ly	     (atof(argv[7])),
        
	_output_flag (atoi(argv[8]))

{
        // argument handling
	if (argc<9){
		fprintf(stderr, "usage: ./cpu <number_of_particles> <simulation_time> <time_step> <mass_of_particles> <charge_of_particles> <Lx> <Ly> <>output_flag\n");
                exit(1);
	}
}
