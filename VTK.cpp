void VTKStencil::write ( FlowField & flowField, int timeStep, std::string foldername ) {

	std::cout << "=== Writing VTK Output ===" << std::endl;
	
	// Open the file and set precision
	this->_outputFile->open(this->getFilename(timeStep, foldername).c_str());
	*this->_outputFile << std::fixed << std::setprecision(6);
	
	// Output the different sections of the file
	this->writeFileHeader();
	this->writeGrid(flowField);
	this->writeCellDataHeader(flowField);
	this->writePressure();
	this->writeVelocity();
	
	// Close the file
	this->_outputFile->close();
	
	this->clearStringStreams();
	
}
