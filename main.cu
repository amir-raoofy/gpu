#include "db.cuh"
#include "output.cuh"

int main (int argc,char ** argv){
	
	// set the simulation parameters
	Parameters * parameters = new Parameters (argc, argv);
	
	//calculate the size of the arrays to be allocated
	int particles_array_bytes	= parameters->_N * sizeof(Particle);
	int output_array_bytes 		= parameters->_N * sizeof(Particle);
	
	//declare input and output array on the Host which are the same
	Particle h_particles[parameters->_N];
	//set particle position randomly 
	initial_condition(h_particles,parameters);
	

	//declare arrays which will be transfered to the Device
	Particle * d_particles;
	Particle * d_output;
	
	Output *output =new Output(parameters->_N,h_particles,parameters->_output_flag);
	
	//allocate memory space on the Device
	cudaMalloc((void **) &d_particles,particles_array_bytes);
	cudaMalloc((void **) &d_output,output_array_bytes);		

	//Transfer arrays to the Device
	cudaMemcpy(d_particles,h_particles,particles_array_bytes,cudaMemcpyHostToDevice);

	for(int i = 0; i < int(parameters->_T/parameters->_dt); i++){
		
		// run the kernel with N threads and 1 Blocks
		update_position<<<1,(parameters->_N)>>>(parameters->_dt,parameters->_T,parameters->_N,d_particles,d_output,parameters->_max_threads);
		//cudaDeviceSynchronize();
		
		if (parameters->_output_flag){
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
