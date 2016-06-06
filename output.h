#ifndef OUTPUT_H
#define OUTPUT_H

#include <sys/stat.h>
#include <ctime>
#include <string.h>
#include "db.h"

class Output{

	private: 
		int _N;
		Particle *_particles;
		int _timeStep;
		char _folderName[26];
		std::ofstream _file;

	public:
		Output (int N, Particle *particles);
		void setTimeStep(int timeStep);
		void openFile();
		void writeHeader();
		void writeGrid();
		void writeVelocity();
		void closeFile();
		void writeFile();
};

#endif
