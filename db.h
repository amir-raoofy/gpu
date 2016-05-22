#include <iostream>

class Particle {
	
	private:
		double q;
		double m;
		double x[2];
		double v[2];
		double E[2];
	public:
		Particle();
		double get_mass();
		double get_charge();

		double* get_position();
		double* get_velocity();
		double* get_field();

		void set_position(double * position);
		void set_velocity(double* velocity);
		void set_field();

		void solve_time_step(double dt);

};

void ElectricField(double* E, const Particle& P);
void solve (double dt, double T, int N, Particle *particles);

