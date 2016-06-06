#include "db.h"

int main (int argc,char ** argv){
	
	// set the simulation parameters
	int N=10;		//number of particles 	

	// set solver parameters
	double dt=1;		// time step
	double T =1;		// time interval for the simulation

	Particle * particles = new Particle[N];
	initial_condition(particles, N);
	
	for( int i = 0; i < int(T/dt); i++){
		update_position(dt,T,N,particles);
	}
	
	
	for(int i = 0 ; i < N ; i ++){
		std::cout<<particles[i].get_position()[0]<<","<<particles[i].get_position()[1]\
		<<std::endl;
	}
	
	delete [] particles;

	return 0;

}
