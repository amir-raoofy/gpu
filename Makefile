CC=g++
CFLAGS=-c

all: sim

sim: main.o db.o
	$(CC) main.o db.o -o sim

main.o: main.cpp
	$(CC) $(CFLAGS) main.cpp

db.o: db.cpp
	$(CC) $(CFLAGS) db.cpp

clean: 
	rm *o sim
