#ifndef PARAMETERS_H
#define PARAMETERS_H

#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <fstream>

class Parameters{

	public:
	        const int 	_N		;	//number of particles
	        const float	_T		;	//duration of the simulation	
        	const float	_dt		;	//time steps
	        const int	_output_flag	;	//flag to enable writing an output file
	
		Parameters(int argc,char ** argv);

};

#endif
