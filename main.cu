#include "db.cuh"

int main( int argc,char ** argv){
	
	// set the simulation parameters
	const int max_thread	= 1024;		//maximum number of threads per block
	const int N				= NUMBER;	//number of particles
	const int T				= 1000;		// duration of the simulation
	const float dt 			= 0.1;		//time steps	

	
	//declare input and output array on the Host
	Particle h_particles[N];
	
	//set particle position randomly 
	initial_condition(h_particles,N);
	
	//output array on the Host
	float h_output_x[N];
	float h_output_y[N];
	
	
	//calculate the size of the arrays to be allocated
	int particles_array_bytes	= N * sizeof(Particle);
	int output_array_bytes 		= N * sizeof(float);

	//declare arrays which will be transfered to the Device
	Particle * d_particles;
	float * d_output_x;
	float * d_output_y;
	
	//allocate memory space on the Device
	cudaMalloc((void **) &d_particles,particles_array_bytes);
	cudaMalloc((void **) &d_output_x,output_array_bytes);		
	cudaMalloc((void **) &d_output_y,output_array_bytes);	
			
	//Transfer arrays to the Device
	cudaMemcpy(d_particles,h_particles,particles_array_bytes,cudaMemcpyHostToDevice);
		
	// run the kernel with N threads and 1 Blocks
	std::ofstream myfile;
	myfile.open("data.txt");
	for(int i = 0; i < int(T/dt); i++){
		update_position<<<1,N>>>(dt,T,N,d_particles,d_output_x,d_output_y,max_thread);
		if(i%10 == 1){
			cudaMemcpy(h_output_x,d_output_x,output_array_bytes,cudaMemcpyDeviceToHost);
			cudaMemcpy(h_output_y,d_output_y,output_array_bytes,cudaMemcpyDeviceToHost);
			for(int j = 0; j < N; j++){
				myfile << h_output_x[j]<<","<<h_output_y[j]<<'\t';
			}
			myfile << std::endl;
		}
	}
	myfile.close();

	
	//write the solution back to the Host
	cudaMemcpy(h_output_x,d_output_x,output_array_bytes,cudaMemcpyDeviceToHost);
	cudaMemcpy(h_output_y,d_output_y,output_array_bytes,cudaMemcpyDeviceToHost);
	
	for(int i = 0 ; i < N ; i++){
		std::cout<<h_output_x[i]<<","<<h_output_y[i]\
		<<std::endl;
	}
	//std::cout<<positions_array_bytes<<std::endl;
	
	cudaFree(d_particles);
	cudaFree(d_output_x);
	cudaFree(d_output_y);
	return 0;
}
