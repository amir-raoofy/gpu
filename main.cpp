#include "db.h"
#include "output.h"

int main (int argc,char ** argv){

	Parameters * parameters = new Parameters (argc, argv);

	Particle * particles = new Particle[parameters->_N];
	initial_condition(particles,parameters->_N);

	Output *output =new Output(parameters->_N,particles,parameters->_output_flag);

	for( int i = 0; i < int(parameters->_T/parameters->_dt); i++){
		update_position(parameters->_dt,parameters->_T,parameters->_N,particles);
		if (parameters->_output_flag){
			output->setTimeStep(i);
			output->writeFile();
		}
	}

	delete [] particles;

	return 0;

}
