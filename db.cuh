#include <iostream>
#include <stdlib.h>

class Particle{
	private:
	
		double q;	//charge of the particle
		double m;	//mass of the particle
		double x[2];	//array of the positions
		double v[2];	//array of the velocities
		double E[2];	//array of field
		double I[2]; 	//array of interaction
		
		__device__ __host__ void set_field();
		__device__ __host__ void set_interaction(int N, int index, Particle * particles);
	
	public:
	
		__device__ __host__ Particle();
		__device__ __host__ double get_mass();
		__device__ __host__ double get_charge();
		__device__ __host__ double* get_field();

		
		
		__device__ __host__ double* get_position();
		__device__ __host__ double* get_velocity();		
		__device__ __host__ double* get_interaction();
		__device__ __host__ void set_position(double * position);
		__device__ __host__ void set_velocity(double* velocity);
		__host__ __device__ void update_field(int N, int index, Particle * particles);
		
		//solve the differential equation for dt time step for "this" particle
		__device__ __host__ void solve_time_step(double dt);
		

		
		

};
//this is the kernel of the simulation on the Device
__global__ void update_position(double dt, double T, const int N,\
 Particle * d_particles, Particle * d_output, const int max_thread,int blocks);
__host__ __device__ void electricField(double* E);
__host__ void initial_condition(Particle * particles,int N);
