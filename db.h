class Particle {
	
	private:
		double q;
		double m;
		double x;
		double y;
		double u;
		double v;
		double Ex;
		double Ey;
	public:
		Particle();
		double get_mass();
		double get_charge();

		double get_position();
		double get_velocity();
		double get_field();

		void set_position();
		void set_velocity();
		void set_field();
};

void ElectricField(double* E, const Particle& P);

