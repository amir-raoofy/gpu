#include <iostream>
#include <fstream>
#include <stdlib.h>
#define NUMBER 10


class Particle{
	private:
	
		float q;	//charge of the particle
		float m;	//mass of the particle
		float x[2];	//array of the positions
		float v[2];	//array of the velocities
		float E[2];	//array of field
		float I[2]; 	//array of interaction
		
		__device__ __host__ void set_field();

	
	public:
		__device__ void set_interaction(int N, int index, Particle * particles);
		__device__ __host__ Particle();
		__device__ __host__ float get_mass();
		__device__ __host__ float get_charge();
		__device__ __host__ float* get_field();

		
		
		__device__ __host__ float* get_position();
		__device__ __host__ float* get_velocity();		
		__device__ __host__ float* get_interaction();
		__device__ __host__ void set_position(float * position);
		__device__ __host__ void set_velocity(float* velocity);
		__device__ void update_field(int N, int index, Particle * particles);
		
		//solve the differential equation for dt time step for "this" particle
		__device__ __host__ void solve_time_step(float dt);
		

		
		

};
//this is the kernel of the simulation on the Device
__global__ void update_position(float dt, float T, const int N,\
 Particle * d_particles, Particle * d_output, const int max_thread);
__host__ __device__ void electricField(float* E, float* x);
__host__ void initial_condition(Particle * particles,int N);
