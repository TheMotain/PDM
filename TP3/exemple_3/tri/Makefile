tri: tri.o func.o
	gcc -gStabs -o tri tri.o func.o

tri.asm.o: tri.s
	gcc -g -c -o tri.o tri.s

func.o: func.c
	gcc -g -c -o func.o func.c

clean:
	rm -fv tri.o func.o
