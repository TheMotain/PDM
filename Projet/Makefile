myprintf : myprintf1.o myprintf2.o
	gcc -gstabs -o myprintf myprintf1.o myprintf2.o

myprintf2.o : myprintf.s
	gcc -g -c -o myprintf2.o myprintf.s

myprintf1.o : myprintf.c
	gcc -g -c -o myprintf1.o myprintf.c

clean :
	rm -fv myprintf myprintf1.o myprintf2.o
