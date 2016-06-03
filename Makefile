#CC=g++
CC=nvcc
CFLAGS=-c

all: sim sim_cuda

sim: main_seq.o db.o
	$(CC) main_seq.o db.o -o sim

sim_cuda: main_gpu.o db_gpu.o
	$(CC) main_gpu.o db_gpu.o -o sim_cuda

main_seq.o: main_seq.cpp
	$(CC) $(CFLAGS) main_seq.cpp

main_gpu.o: main_gpu.cu
	$(CC) $(CFLAGS) main_gpu.cu

db.o: db.cpp
	$(CC) $(CFLAGS) db.cpp

db_gpu.o: db.cu
	$(CC) $(CFLAGS) db.cu -o db_gpu.o
clean: 
	rm *o sim sim_cuda
