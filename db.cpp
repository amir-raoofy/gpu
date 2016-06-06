#include "db.h"

void ElectricField(double* E, const Particle& P){
	E[0]=1.0;
	E[1]=1.0;
}

Particle::Particle(){

	this ->m    = 1  ;
	this ->q    = 0.000001  ;
	this ->x[0] = 0.0;
	this ->x[1] = 0.0;
	this ->v[0] = 0.0;
	this ->v[1] = 0.0;
	this ->E[0] = 0.0;
	this ->E[1] = 0.0;
	this ->I[0] = 0.0;
	this ->I[1] = 0.0;

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
	electricField(this->E,this->x);
};

void Particle::update_field(int N, int index, Particle * particles){
	
	this->set_interaction(N, index, particles);
	this->set_field();
};

void Particle::solve_time_step(double dt){

	v[0] = v[0] + dt * q * (E[0]+I[0]) / m ;
	x[0] = x[0] + dt * v [0];
	
	v[1] = v[1] + dt * q * (E[1]+I[1]) / m ;
	x[1] = x[1] + dt * v [1];

}

void Particle::set_interaction(int N, int index, Particle * particles){
	
	double x_1 = this->x[0];
	double y_1 = this->x[1];
	double x_2 ;
	double y_2 ;
	double r_sqrt;
	double r_3_2;
	double q_2;
	
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
//		this->I[0] = 1;
//		this->I[1] = 0;
	}
	for(int i=index + 1;i < N ; i++){
		x_2 = particles[i].get_position()[0];
		y_2 = particles[i].get_position()[1];
		q_2 = particles[i].get_charge();
		r_sqrt = sqrt(sqrt((x_1-x_2)*(x_1-x_2) + (y_1-y_2)*(y_1-y_2)));
		r_3_2 = r_sqrt*r_sqrt*r_sqrt;
		this->I[0] += q_2*(x_1-x_2)/r_3_2;
		this->I[1] += q_2*(y_1-y_2)/r_3_2;
//		this->I[0] = 1;
//		this->I[1] = 0;
	}
}

void update_position(double dt, double T, const int N,\
 Particle * particles){
	
	for (int index=0; index<N; index++){
		particles[index].update_field(N, index , particles);
		particles[index].solve_time_step(dt);
	}
};


void electricField(double* E, double* x){
	E[0]=1/x[0] + 1/(x[0] - 1000);
	E[0]*=E[0];
	E[1]=1/x[1] + 1/(x[1] - 1000);
	E[1]*=E[1];
}

void initial_condition(Particle * particles,int N){
	double pos[2];
	//double velo[2];
	for( int i = 0; i < N; i++){
		pos[0]=250+(double)(rand()%100000) / 200.0;
		pos[1]=250+(double)(rand()%100000) / 200.0;
		//velo[0]=25+(double)(rand()%10000) / 200.0;
		//velo[1]=25+(double)(rand()%10000) / 200.0;
		particles[i].set_position(pos);
	}
}

