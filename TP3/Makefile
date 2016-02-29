date : date.o
	gcc -gstabs -o date date.o

date.o : date.s
	gcc -c -o date.o date.s

clean :
	rm -fv date date.o
