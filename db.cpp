#include "db.h"

void ElectricField(float* E, const Particle& P){
	E[0]=1.0;
	E[1]=1.0;
}

Particle::Particle(){

	this ->m    = 1  ;
	this ->q    = 0.01  ;
	this ->x[0] = 0.0;
	this ->x[1] = 0.0;
	this ->v[0] = 0.0;
	this ->v[1] = 0.0;
	this ->E[0] = 0.0;
	this ->E[1] = 0.0;
	this ->I[0] = 0.0;
	this ->I[1] = 0.0;

};

float Particle::get_mass(){
	return this ->m;
};
float Particle::get_charge(){
	return this ->q;
};
float* Particle::get_position(){
	return this ->x;
};
float* Particle::get_velocity(){
	return this ->v;
};
float* Particle::get_field(){
	return this ->E;
};


void Particle::set_parameters(Parameters* parameters){
	this -> _parameters = parameters;
}

void Particle::set_mass(float mass){
	this -> m = mass;
};

void Particle::set_charge(float charge){
	this -> q = charge;
};

void Particle::set_position(float* position){
	this->x[0]=position[0];
	this->x[1]=position[1];
};
void Particle::set_velocity(float* velocity){
	this->v[0]=velocity[0];
	this->v[1]=velocity[1];
};
void Particle::set_field(){
	electricField(this->E,this->x, this->_parameters);
};

void Particle::update_field(int N, int index, Particle * particles){
	
	this->set_interaction(N, index, particles);
	this->set_field();
};

void Particle::solve_time_step(float dt){

	v[0] = v[0] + dt * q * (E[0]+I[0]) / m ;
	x[0] = x[0] + dt * v [0];
	
	v[1] = v[1] + dt * q * (E[1]+I[1]) / m ;
	x[1] = x[1] + dt * v [1];

}

void Particle::set_interaction(int N, int index, Particle * particles){
	
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

void update_position(float dt, float T, const int N,\
 Particle * particles){
	
	for (int index=0; index<N; index++){
		particles[index].update_field(N, index , particles);
		particles[index].solve_time_step(dt);
	}
};


void electricField(float* E, float* x, Parameters* parameters){
	E[0]=1/x[0] + 1/(x[0] - parameters->_Lx);
	E[1]=1/x[1] + 1/(x[1] - parameters->_Ly);
}

void initial_condition(Particle * particles, Parameters* parameters){
	float pos[2];
	for( int i = 0; i < parameters->_N; i++){
		
		particles[i].set_parameters 	(parameters		);
		particles[i].set_mass  		(parameters->_mass	);
		particles[i].set_charge		(parameters->_q		);
		
		pos[0]=(parameters->_Lx)/4.0 +(float)(rand()%(int)(parameters->_Lx)) / 2.0;
		pos[1]=(parameters->_Ly)/4.0 +(float)(rand()%(int)(parameters->_Ly)) / 2.0;
		particles[i].set_position(pos);
	}
}

