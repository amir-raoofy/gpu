#include "db.h"

void ElectricField(double* E, const Particle& P){
	E[0]=1.0;
	E[1]=1.0;
}

void Interaction_field  (double* E, Particle* particles, int index, int N){
	
	// calculate the interaction between the particle ( index - n )
	double x= particles[index].get_position()[0];		//position of particles[index]
	double y= particles[index].get_position()[1];
	double x_i;						//temp position
	double y_i;
	double r_i;						//temp distance

	for (int n=index+1; n<N; n++){

		x_i = particles[n].get_position()[0];
		y_i = particles[n].get_position()[1];
		r_i = pow(((x-x_i)*(x-x_i) + (y-y_i)*(y-y_i)), 1.5);

		E[0]+= particles[n].get_charge()*(x-x_i)/r_i;
		E[1]+= particles[n].get_charge()*(y-y_i)/r_i;
	}

	for (int n=0; n<index-1; n++){

		x_i = particles[n].get_position()[0];
		y_i = particles[n].get_position()[1];
		r_i = pow(((x-x_i)*(x-x_i) + (y-y_i)*(y-y_i)), 1.5);

		E[0]+= particles[n].get_charge()*(x-x_i)/r_i;
		E[1]+= particles[n].get_charge()*(y-y_i)/r_i;
	}
}


Particle::Particle(){
	
	this ->m    = 1  ;
	this ->q    = 1  ;
	this ->x[0] = 0.5;
	this ->x[1] = 0.5;
	this ->v[0] = 0.5;
	this ->v[1] = 0.5;

	// initialize the field for a priticle
	ElectricField (this->E, *this);
};

double Particle::get_mass(){
	return this ->m;
};
double Particle::get_charge(){
	return this ->q;
};
double* Particle::get_position(){
	return this ->x;
};
double* Particle::get_velocity(){
	return this ->v;
};
double* Particle::get_field(){
	return this ->E;
};
void Particle::set_position(double* position){
	this->x[0]=position[0];
	this->x[1]=position[1];
};
void Particle::set_velocity(double* velocity){
	this->v[0]=velocity[0];
	this->v[1]=velocity[1];
};
void Particle::set_field(){
	ElectricField(this->E, *this);
};

void Particle::solve_time_step(double dt){

	v[0] = v[0] + dt * q * E[0] / m ;
	x[0] = x[0] + dt * v [0];
	
	v[1] = v[1] + dt * q * E[1] / m ;
	x[1] = x[1] + dt * v [1];
}

void solve (double dt, double T, int N, Particle *particles){

	int Nt=T/dt;
	for (int i=0; i<Nt; i++){

		for (int n=0; n<N; n++){
			// update the electric field
			particles[n].set_field();
			particles[n].solve_time_step(dt);
		}

	std::cout << 
	particles[1].get_position()[1] <<
	std::endl;
	}
}
