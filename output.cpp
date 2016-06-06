#include "output.h"

Output::Output (int N, Particle *particles):_N(N), _particles(particles){

	struct tm* tm_info;
	time_t now;
	time(&now);
	tm_info = localtime(&now);
	strftime(_folderName, 26, "%Y:%m:%d %H:%M:%S", tm_info);
	mkdir(_folderName, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
	this->setTimeStep(0);

}

void Output::setTimeStep(int timeStep){

	_timeStep=timeStep;

}

void Output::openFile(){
	char address [50];
	char timeStep[10];
	sprintf (timeStep, "%d", _timeStep);
	sprintf (address, "./%s/data%d.vtk",_folderName,_timeStep);
	_file.open(address);
}
void Output::writeHeader(){
	
	_file<<"# vtk DataFile Version 3.1\n";
	_file<<"this is a vtk file to save the coordinates of the particles in one time step\n";
	_file<<"ASCII\n";

}
void Output::writeGrid(){

	_file<<"DATASET UNSTRUCTURED_GRID\n";
	_file<<"POINTS "<<_N<<" FLOAT\n";

		for(int j = 0; j < _N; j++)
			_file<< _particles[j].get_position()[0]<<" "<<_particles[j].get_position()[1]<<" "<<0<<"\n";
	_file<<"\n";
	
}
void Output::writeVelocity(){

	_file<<"POINT_DATA "<<_N<<"\n";
	_file<<"SCALARS HorizontalSpeed float\n";
	_file<<"LOOKUP_TABLE default\n";

	if(_timeStep%10 == 0){
			for(int j = 0; j < _N; j++)
				_file<<0<<"\n";
		}
}

void Output::closeFile(){
	
	_file.close();

}

void Output::writeFile(){

	if(_timeStep%10 == 0){
		openFile();
		writeHeader();
		writeGrid();
		writeVelocity();
		closeFile();
	}
}

