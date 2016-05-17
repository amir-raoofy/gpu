#include <iostream>
#include "db.h"




int main (int argc,char ** argv){
	
	// set the simulation parameters
	int N=10;		//number of particles 	

	Particle * particles = new Particle[N];
	

	// update the electric field

	for (int i=0; i<N; i++)
		particles[i].set_field();


	for (int i=0; i<N; i++){}
//		particles[i].solve_timeStep();



	delete [] particles;
	return 0;

}
