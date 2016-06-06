#include <iostream>
#include <stdlib.h>
#include <math.h>

class Particle {
	
	private:
		double q;	//charge of the particle
		double m;	//mass of the particle
		double x[2];	//array of the positions
		double v[2];	//array of the velocities
		double E[2];	//array of field
		double I[2]; 	//array of interaction

		void set_field();

	public:
		Particle();
		double get_mass();
		double get_charge();

		double* get_position();
		double* get_velocity();
		double* get_field();
		
		void update_field(int N, int index, Particle * particles);
		void set_position(double * position);
		void set_velocity(double* velocity);
		void set_interaction(int N, int index, Particle * particles);
		void solve_time_step(double dt);

};

void update_position(double dt, double T, const int N, Particle * particles);
void electricField(double* E, double* x);
void initial_condition(Particle * particles,int N);
