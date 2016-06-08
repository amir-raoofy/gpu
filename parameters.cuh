#ifndef PARAMETERS_H
#define PARAMETERS_H

#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <fstream>

class Parameters{

	public:
	        const int   	_N		;	//number of particles
	        const float	_T		;	//duration of the simulation	
        	const float 	_dt		;	//time steps
	        const int   	_output_flag	;	//flag to enable writing an output file
	
		const float 	_mass		;	// mass of the particles
	        const float	_q		;	// charge of the particles	
        	const float	_Lx		;	// length of the cube in x direction
	        const float	_Ly		;	// length of the cube in y direction

		const int	_max_threads	;	//maximum number of threads per block
		int 	    	_blocks		;
		
		Parameters(int argc,char ** argv);

};

#endif
