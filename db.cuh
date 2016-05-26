#include <iostream>

class Particle{
	private:
	
		double q;	//charge of the particle
		double m;	//mass of the particle
		double x[2];	//array of the positions
		double v[2];	//array of the velocities
		double E[2];
	
	public:
	
		Particle();
		__device__ __host__ double get_mass();
		__device__ __host__ double get_charge();
		__device__ __host__ double* get_field();
		
		
		__device__ __host__ double* get_position();
		__device__ __host__ double* get_velocity();		
		__device__ __host__ void set_position(double * position);
		__device__ __host__ void set_velocity(double* velocity);
		__device__ __host__ void set_field();
		__device__ __host__ void solve_time_step(double dt);

};

__device__ __host__  void ElectricField(double* E, const Particle& P);
__global__ void solve(double dt, double T, const int N, Particle * d_particles, Particle * d_output); //this is the kernel of the simulation
		
