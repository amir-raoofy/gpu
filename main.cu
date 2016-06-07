#include "db.cuh"
#include "output.cuh"

int main(){
	
	// set the simulation parameters
	const int max_thread	= 512;		//maximum number of threads per block
	const int N		= NUMBER;	//number of particles
	const int T		= 1000;		//duration of the simulation
	const float dt 		= 0.1;		//time steps	
	const int output_flag	= 0;		//

	//calculate the size of the arrays to be allocated
	int particles_array_bytes	= N * sizeof(Particle);
	int output_array_bytes 		= N * sizeof(Particle);
	
	//declare input and output array on the Host which are the same
	Particle h_particles[N];
	//set particle position randomly 
	initial_condition(h_particles,N);
	

	//declare arrays which will be transfered to the Device
	Particle * d_particles;
	Particle * d_output;
	
	Output *output =new Output(N,h_particles,output_flag);
	
	//allocate memory space on the Device
	cudaMalloc((void **) &d_particles,particles_array_bytes);
	cudaMalloc((void **) &d_output,output_array_bytes);		

	//Transfer arrays to the Device
	cudaMemcpy(d_particles,h_particles,particles_array_bytes,cudaMemcpyHostToDevice);

	for(int i = 0; i < int(T/dt); i++){
		
		// run the kernel with N threads and 1 Blocks
		update_position<<<1,NUMBER>>>(dt,T,N,d_particles,d_output,max_thread);
		//cudaDeviceSynchronize();
		
		if (output_flag){
			if (!(i%10))
				cudaMemcpy(h_particles,d_output,particles_array_bytes,cudaMemcpyDeviceToHost);
			output->setTimeStep(i);
			output->writeFile();
		}
	}

	cudaFree(d_particles);
	cudaFree(d_output);
	
	return 0;
}
