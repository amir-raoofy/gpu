#include "db.h"
#include "output.h"

int main (int argc,char ** argv){
	
	// set the simulation parameters
	int N=500;		//number of particles 	
	float dt=0.1;		// time step
	float T =10000;		// time interval for the simulation
	int output_flag=0;

	Particle * particles = new Particle[N];
	initial_condition(particles, N);

	Output *output =new Output(N,particles,output_flag);

	for( int i = 0; i < int(T/dt); i++){
		update_position(dt,T,N,particles);
		if (output_flag){
			output->setTimeStep(i);
			output->writeFile();
		}
	}

	delete [] particles;

	return 0;

}
