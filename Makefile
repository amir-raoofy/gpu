CC=g++
CFLAGS=-c
FLAGS = 

all: sim

sim: main.o db.o output.o
	$(CC) $(FLAGS) main.o db.o output.o -o sim

main.o: main.cpp
	$(CC) $(CFLAGS) $(FLAGS) main.cpp

db.o: db.cpp
	$(CC) $(CFLAGS) $(FLAGS) db.cpp

output.o: output.cpp
	$(CC) $(CFLAGS) $(FLAGS) output.cpp
clean: 
	rm *o sim
