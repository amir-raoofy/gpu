#include "db.h"

int main (int argc,char ** argv){
	
	// set the simulation parameters
	int N=10;		//number of particles 	

	// set solver parameters
	double dt=1;		// time step
	double T =1;		// time interval for the simulation

	Particle * particles = new Particle[N];

	solve(dt, T, N, particles);


	delete [] particles;

	return 0;

}
