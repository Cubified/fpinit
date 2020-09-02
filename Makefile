all: script fpinit

CC=gcc

LIBS=

FLAGS=-Os -s -pipe
DEBUGFLAGS=-Og -Wall -pipe -g

SOURCES=fpinit.c
OUT=fpinit

BINDIR=/usr/local/bin
SHAREDIR=/usr/local/share

RM=/bin/rm
CP=/bin/cp

.PHONY: script
script:
	$(CC) script/script.c -o script/script $(LIBS) $(FLAGS) -include config.h

.PHONY: fpinit
fpinit:
	$(CC) $(SOURCES) -o $(OUT) $(LIBS) $(FLAGS)

debug:
	$(CC) $(SOURCES) -o $(OUT) $(LIBS) $(DEBUGFLAGS)

install:
	$(CP) -r script/init.d $(SHAREDIR)/fpinit.d
	$(CP) -r script/halt.d $(SHAREDIR)/fphalt.d
	test -d $(INSTALLDIR) || mkdir -p $(BINDIR)
	install -pm 755 script/script $(BINDIR)
	install -pm 755 $(OUT) $(BINDIR)

uninstall:
	$(RM) -rf $(SHAREDIR)/fpinit.d
	$(RM) -rf $(SHAREDIR)/fphalt.d
	$(RM) $(BINDIR)/$(OUT)

clean:
	if [ -e "$(OUT)" ]; then $(RM) $(OUT); fi
