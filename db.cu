#include "db.cuh"


// implementation of the constructor of the particles

__host__ Particle::Particle(){
	
	this ->m    = 1  ;
	this ->q    = 0.001;
	this ->x[0] = 0.0;
	this ->x[1] = 0.0;
	this ->v[0] = 0.0;
	this ->v[1] = 0.0;
	this ->E[0] = 0.0;
	this ->E[1] = 0.0;
	this ->I[0] = 0.0;
	this ->I[1] = 0.0;

};

__device__ __host__ float Particle::get_mass(){
	return this ->m;
};
__device__ __host__ float Particle::get_charge(){
	return this ->q;
};
__device__ __host__ float * Particle::get_position(){
	return this ->x;
};
__device__ __host__ float * Particle::get_velocity(){
	return this ->v;
};

__device__ __host__ float * Particle::get_interaction(){
	return this-> I;
};

__device__ __host__ void Particle::set_position(float* position){
	this->x[0]=position[0];
	this->x[1]=position[1];
};
__device__ __host__ void Particle::set_velocity(float* velocity){
	this->v[0]=velocity[0];
	this->v[1]=velocity[1];
};
__device__ void Particle::update_field(int N, int index, Particle * particles){
	
	this->set_interaction(N, index, particles);

	this->set_field();


};

//solve the newton equation by euler method
__device__ __host__ void Particle::solve_time_step(float dt){

	v[0] = v[0] + dt * q * (E[0]+I[0]) / m ;
	x[0] = x[0] + dt * v [0];
	
	v[1] = v[1] + dt * q * (E[1]+I[1]) / m ;
	x[1] = x[1] + dt * v [1];
};

//set the electronic field of each particle
__device__ __host__ void Particle::set_field(){
	electricField(this->E,this->x);
};

//calculate the interaction between the particle[index] and other particles
__device__ void Particle::set_interaction(int N, int index, Particle * particles){
	
	float x_1 = this->x[0];
	float y_1 = this->x[1];
	float x_2 ;
	float y_2 ;
	float r_sqrt;
	float r_3_2;
	float q_2;
	
	this->I[0]=0;
	this->I[1]=0;
	for(int i = 0 ; i < index ; i++){
		x_2 = particles[i].get_position()[0];

		y_2 = particles[i].get_position()[1];

		q_2 = particles[i].get_charge();

		r_sqrt = sqrt(sqrt((x_1-x_2)*(x_1-x_2) + (y_1-y_2)*(y_1-y_2)));
		r_3_2 = r_sqrt*r_sqrt*r_sqrt;
		this->I[0] += q_2*(x_1-x_2)/r_3_2;

		this->I[1] += q_2*(y_1-y_2)/r_3_2;

	}
	for(int i=index + 1;i < N ; i++){
		x_2 = particles[i].get_position()[0];

		y_2 = particles[i].get_position()[1];

		q_2 = particles[i].get_charge();
		r_sqrt = sqrt(sqrt((x_1-x_2)*(x_1-x_2) + (y_1-y_2)*(y_1-y_2)));
		r_3_2 = r_sqrt*r_sqrt*r_sqrt;
		this->I[0] += q_2*(x_1-x_2)/r_3_2;
		this->I[1] += q_2*(y_1-y_2)/r_3_2;

	}
}
		

__global__ void update_position(float dt, float T, const int N,\
 Particle * particles, Particle * d_output, const int max_thread){

	int index = threadIdx.x;
	
	//allocate shared memory and copy the particles into it
	//__shared__ Particle sh_particles[NUMBER];
	//sh_particles[index] = particles[index];
	//__syncthreads();
	
	//update field and solve for a time step
	particles[index].update_field(N, index, particles);
	__syncthreads();

	particles[index].solve_time_step(dt);
	__syncthreads();
	
	//particles[index] = sh_particles[index];
	//__syncthreads();
	
	d_output[index] = particles[index];
	__syncthreads();
	//__threadfence();
		
	
	
};

//the electrical field acts similar to a infinite wall
__host__ __device__ void electricField(float* E, float* x){
	E[0]=1/x[0] + 1/(x[0] - 100000);
	E[0]*=E[0];
	E[1]=1/x[1] + 1/(x[1] - 100000);
	E[1]*=E[1];
}

__host__ void initial_condition(Particle * particles,int N){
	float pos[2];
	for( int i = 0; i < N; i++){
		pos[0]=2500+(float)(rand()%100000) / 20.0;
		pos[1]=2500+(float)(rand()%100000) / 20.0;
		particles[i].set_position(pos);
	}
}
	
	
	
