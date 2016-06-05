#include "../FlowField.h"
#include <string>
#include <fstream>
#include <sstream>

class VTK {

    private:
		std::ofstream *_outputFile;
		std::stringstream _velocityStringStream;
		std::stringstream _pressureStringStream;
    public:

        VTK( const Parameters & parameters );
		~VTKStencil ();

        virtual void write ( FlowField & flowField, int timeStep, std::string foldername );

        virtual std::string getFilename( int timeStep, std::string foldername );
        virtual void writeFileHeader();
		virtual void writeCellDataHeader ( FlowField & flowField );
        virtual void writeGrid ( FlowField & flowField );
        virtual void writePressure ( );
        virtual void writeVelocity ( );
        virtual void clearStringStreams();

};

#endif
