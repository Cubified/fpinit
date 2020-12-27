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

OS_NAME=$(shell awk -F'=' '$$1 == "PRETTY_NAME" {printf("%s", $$2)}' /etc/os-release | sed 's/"//g')

FPINIT_VERSION='"0.1.0"'
SCRIPT_GREETING='"printf \"\\x1b[34mWelcome to \\x1b[32mfpinit v$(FPINIT_VERSION) \\x1b[34mrunning on \\x1b[33m$$(. /etc/os-release; printf \"$$PRETTY_NAME\")\""'

.PHONY: script
script:
	$(CC) script/script.c -o script/script $(LIBS) $(FLAGS) -DDO_NOT_DEFINE_GREETING -DGREETING_CMD=$(SCRIPT_GREETING)

.PHONY: fpinit
fpinit:
	$(CC) $(SOURCES) -o $(OUT) $(LIBS) $(FLAGS) -DFPINIT_VERSION=$(FPINIT_VERSION)

debug:
	$(CC) $(SOURCES) -o $(OUT) $(LIBS) $(DEBUGFLAGS)

install:
	$(CP) -rT fpinit.d $(SHAREDIR)/fpinit.d
	$(CP) -rT fphalt.d $(SHAREDIR)/fphalt.d
	test -d $(INSTALLDIR) || mkdir -p $(BINDIR)
	install -pm 755 script/script $(BINDIR)
	install -pm 755 $(OUT) $(BINDIR)

uninstall:
	$(RM) -rf $(SHAREDIR)/fpinit.d
	$(RM) -rf $(SHAREDIR)/fphalt.d
	$(RM) $(BINDIR)/$(OUT)

clean:
	if [ -e "$(OUT)" ]; then $(RM) script/script; fi
	if [ -e "$(OUT)" ]; then $(RM) $(OUT); fi
