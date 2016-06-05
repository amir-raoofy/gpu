#include "db.cuh"
int main( int argc,char ** argv){

	// argument handling
/*	if (argc<6){
		fprintf(stderr, "usage: ./sim_cuda <maximum_number_of_threads> <number_of_particles> <simulation_time> <time_step>\n");
		exit(1);
	}
*/		
	// set the simulation parameters
	const int max_threads = atoi(argv[1]);		//maximum number of threads per blocks
	const int N           = atoi(argv[2]);		//number of particles
	float     T           = atof(argv[3]);		//duration of the simulation
	float     dt          = atof(argv[4]);		//time steps
	int       output_flag = atoi(argv[5]);		//flag to enable writing an output file
	int       blocks      = int (N % max_threads == 0)?(N/max_threads):(N/max_threads);	//number of blocks in GPU
	
	//allocate input and output array of particles on the Host
	Particle *particles_host_in  = new Particle[N];
	Particle *particles_host_out = new Particle[N];

	
	//instantiate a Simulation
	Simulation* simulation= new Simulation(dt, T, N, max_threads, blocks, output_flag, particles_host_in, particles_host_out);
	simulation -> solve();
	
	for(int i = 0 ; i < N ; i ++){
		std::cout<<particles_host_in[i].get_position()[0]<<","<<particles_host_in[i].get_position()[1]\
		<<std::endl;
	}
	
delete [] particles_host_in ;
	delete [] particles_host_out;
	return 0;
}
