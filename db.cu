#include "db.cuh"


// implementation of the constructor of the particles

Particle::Particle(){
	
	this ->m    = 1  ;
	this ->q    = 1  ;
	this ->x[0] = 0.5;
	this ->x[1] = 0.5;
	this ->v[0] = 0.5;
	this ->v[1] = 0.5;
	this ->E[0] = 0;
	this ->E[1] = 0;

};

__device__ __host__ double Particle::get_mass(){
	return this ->m;
};
__device__ __host__ double Particle::get_charge(){
	return this ->q;
};
__device__ __host__ double * Particle::get_position(){
	return this ->x;
};
__device__ __host__ double * Particle::get_velocity(){
	return this ->v;
};

__device__ __host__ void Particle::set_position(double* position){
	this->x[0]=position[0];
	this->x[1]=position[1];
};
__device__ __host__ void Particle::set_velocity(double* velocity){
	this->v[0]=velocity[0];
	this->v[1]=velocity[1];
};

__device__ __host__ void ElectricField(double* E, const Particle& P){
	
};

__host__ __device__ void diff_solve (double dt, double T, int N, Particle *particles){
	int Nt=T/dt;
	for (int i=0; i<Nt; i++){
		for (int n=0; n<N; n++){
			// update the electric field
			particles[n].set_field();
			particles[n].solve_time_step(dt);
		}
	}
};

__device__ __host__ void Particle::solve_time_step(double dt){

	v[0] = v[0] + dt * q * E[0] / m ;
	x[0] = x[0] + dt * v [0];
	
	v[1] = v[1] + dt * q * E[1] / m ;
	x[1] = x[1] + dt * v [1];
};
__device__ __host__ void Particle::set_field(){
	ElectricField(this->E, *this);
};

__global__ void solve(double dt, double T, const int N, Particle * particles, Particle * d_output){
	
	// define the index of the thread
	int index = threadIdx.x;
	
	//write particles into the shared memory
	__shared__ Particle sh_particles[10];
	sh_particles[index] = particles[index]; // copying entire position into the shared memory
	
	//synchronize the thread
	__syncthreads();
	
	for( int i = 0; i < int(T/dt); i++){
		
		particles[index].solve_time_step(dt); 
	}
	d_output[index] = particles[index];
};


	
