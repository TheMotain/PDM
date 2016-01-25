# info compilateur
CC=gcc
CFLAGS=-Wall -Werror -ansi -pedantic
CFLAGS+= -D_XOPEN_SOURCE=500 -g
LDFLAGS=-g

# récupératin des fichiers à compiler
CFILES=$(wildcard *.c)
HEADERS=$(wildcard *.h)

# création des dépendences
OBJS=$(CFILES:.c=.o)
# calcul des exécutables
EXE=$(CFILES:.c=)

.PHONY: all clean mrproper

all: $(EXE)

# construction des l'exécutables
%: %.o
	$(CC) $(LDFLAGS) -o $@ $<

# construction des objets et des dépendances
makefile.dep: $(CFILES) $(HEADERS)
	$(CC) $(CFLAGS) -MM $(CFILES) > $@

# nettoyage
clean:
	$(RM) makefile.dep

mrproper: clean
	$(RM) $(EXE)

#inclusion des dépences
include makefile.dep
