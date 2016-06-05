#include "db.cuh"
int main( int argc,char ** argv){
	
	// set the simulation parameters
	const int max_thread = 1024;
	const int N = 100;	//number of particles
	int blocks;
	if(N % max_thread == 0){
		blocks = int(N/max_thread);
	}
	else{
		blocks = int(N/max_thread)+1;
	}
	
	int T = 10;		// duration of the simulation
	float dt = 0.001;		//time steps
	
	
	
	//declare input and output array on the Host
	Particle h_particles[N];
	initial_condition(h_particles, N);
	/*double dummy[2];
	dummy[0] = 3;
	dummy[1] = 3;
	h_particles[0].set_position(dummy);
	dummy[1] = 5;
	dummy[0] = 5;
//	h_particles[0].set_interaction(2,0,h_particles);
	h_particles[1].set_position(dummy);*/
	Particle h_output[N];

	//std::cout<< h_particles[0].get_interaction()[1]<<std::endl;	
	
	//calculate the size of the arrays to be allocated
	int particles_array_bytes = N * sizeof(Particle);
	int output_array_bytes = particles_array_bytes;

	//declare arrays which will be transfered to the Device
	Particle * d_particles;
	Particle * d_output;
	
	//allocate memory space on the Device
	cudaMalloc((void **) &d_particles,particles_array_bytes);
	cudaMalloc((void **) &d_output,output_array_bytes);		
	
	//Transfer arrays to the Device
	cudaMemcpy(d_particles,h_particles,particles_array_bytes,cudaMemcpyHostToDevice);
	
	// run the kernel with N threads and 1 Blocks
	for( int i = 0; i < int(T/dt); i++){
	update_position<<<blocks,((N<max_thread)?N:max_thread)>>>(dt,T,N,d_particles,d_output,max_thread,blocks);
	cudaDeviceSynchronize();
	}
	
	//write the solution back to the Host
	cudaMemcpy(h_output,d_output,output_array_bytes,cudaMemcpyDeviceToHost);
	
	for(int i = 0 ; i < N ; i ++){
		std::cout<<h_output[i].get_position()[0]<<","<<h_output[i].get_position()[1]\
		<<std::endl;
	}
	//std::cout<<positions_array_bytes<<std::endl;
	
	cudaFree(d_particles);
	cudaFree(d_output);
	
	return 0;
}
