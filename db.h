#ifndef DB_H
#define DB_H

#include "parameters.h"

class Particle {
	
	private:
		float q;	//charge of the particle
		float m;	//mass of the particle
		float x[2];	//array of the positions
		float v[2];	//array of the velocities
		float E[2];	//array of field
		float I[2]; 	//array of interaction

		void set_field();

	public:
		Particle();
		float get_mass();
		float get_charge();

		float* get_position();
		float* get_velocity();
		float* get_field();
		
		void update_field(int N, int index, Particle * particles);
		void set_position(float * position);
		void set_velocity(float* velocity);
		void set_interaction(int N, int index, Particle * particles);
		void solve_time_step(float dt);

};

void update_position(float dt, float T, const int N, Particle * particles);
void electricField(float* E, float* x);
void initial_condition(Particle * particles,int N);

#endif
