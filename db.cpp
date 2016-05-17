#include "db.h"

void ElectricField(double* E, const Particle& P){
	E[0]=0;
	E[1]=0.5;
}

Particle::Particle(){
	this ->m = 1;
	this ->q = 1;
	this ->x = 0.5;
	this ->y = 0.5;
	this ->u = 0.5;
	this ->v = 0.5;
};

double Particle::get_mass(){};
double Particle::get_charge(){};
double Particle::get_position(){};
double Particle::get_velocity(){};
double Particle::get_field(){};
void Particle::set_position(){};
void Particle::set_velocity(){};
void Particle::set_field(){};



