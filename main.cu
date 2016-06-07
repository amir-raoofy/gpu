#include "db.cuh"
#include "output.h"

int main(){
	
	// set the simulation parameters
	const int max_thread	= 512;		//maximum number of threads per block
	const int N				= NUMBER;	//number of particles
	const int T				= 1000;		// duration of the simulation
	const float dt 			= 0.1;		//time steps	

	
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


	
	//allocate memory space on the Device
	cudaMalloc((void **) &d_particles,particles_array_bytes);
	cudaMalloc((void **) &d_output,output_array_bytes);		

			
	//Transfer arrays to the Device
	cudaMemcpy(d_particles,h_particles,particles_array_bytes,cudaMemcpyHostToDevice);
		
	
	//std::ofstream myfile;
	//myfile.open("data");
	//myfile << "{";
	//int count = 0;

	Output *output =new Output(N,h_particles);

	for(int i = 0; i < int(T/dt); i++){
		
		// run the kernel with N threads and 1 Blocks
		update_position<<<1,NUMBER>>>(dt,T,N,d_particles,d_output,max_thread);

		cudaMemcpy(h_particles,d_output,particles_array_bytes,cudaMemcpyDeviceToHost);
		output->setTimeStep(i);
		output->writeFile();

		//cudaDeviceSynchronize();
	/*	if(i%10 == 0){
			cudaMemcpy(h_particles,d_output,particles_array_bytes,cudaMemcpyDeviceToHost);
			for(int j = 0; j < N ; j++ ){
				if( i/10 != (int(T/dt)/10)-1 || j !=N-1){
					myfile <<"{"<< h_particles[j].get_position()[0]<<","<<h_particles[j].get_position()[1]<<","<<count<<"},";
				}
				else{
				myfile <<"{"<< h_particles[j].get_position()[0]<<","<<h_particles[j].get_position()[1]<<","<<count<<"}";
				}
			}
		count++;
		}*/
	}
	
	
	//myfile << "}";
	//myfile.close();

	
	//write the solution back to the Host
	cudaMemcpy(h_particles,d_output,particles_array_bytes,cudaMemcpyDeviceToHost);


/*	
	for(int i = N-10 ; i < N ; i++){

		std::cout<<h_particles[i].get_position()[0]<<","<<h_particles[i].get_position()[1]\
		<<std::endl;
	}
	std::cout<<"size of:= "<<particles_array_bytes<<std::endl;
*/
	cudaFree(d_particles);
	cudaFree(d_output);
	
	return 0;
}
