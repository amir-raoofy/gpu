CC  =g++
NVCC=nvcc
CFLAGS=-c
FLAGS = 

all: cpu gpu

cpu: main.o db.o output.o parameters.o
	$(CC) $(FLAGS) main.o db.o output.o parameters.o -o cpu

main.o: main.cpp
	$(CC) $(CFLAGS) $(FLAGS) main.cpp

db.o: db.cpp
	$(CC) $(CFLAGS) $(FLAGS) db.cpp

output.o: output.cpp
	$(CC) $(CFLAGS) $(FLAGS) output.cpp

parameters.o: parameters.cpp
	$(CC) $(CFLAGS) $(FLAGS) parameters.cpp


gpu: main_gpu.o db_gpu.o output_gpu.o parameters_gpu.o
	$(NVCC) $(FLAGS) main_gpu.o db_gpu.o output_gpu.o parameters_gpu.o -o gpu

main_gpu.o: main.cu
	$(NVCC) $(CFLAGS) $(FLAGS) main.cu -o main_gpu.o

db_gpu.o: db.cu
	$(NVCC) $(CFLAGS) $(FLAGS) db.cu -o db_gpu.o

output_gpu.o: output.cu
	$(NVCC) $(CFLAGS) $(FLAGS) output.cu -o output_gpu.o 

parameters_gpu.o: parameters.cu
	$(NVCC) $(CFLAGS) $(FLAGS) parameters.cu -o parameters_gpu.o 

clean: 
	rm -f *o cpu gpu
