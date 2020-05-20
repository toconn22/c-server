CC=		gcc
CFLAGS=		-g -Werror -std=gnu99 -Iinclude
LD=		gcc
LDFLAGS=	-L.
AR=		ar
ARFLAGS=	rcs
TARGETS=	bin/server

all:		$(TARGETS)

clean:
	@echo Cleaning...
	@rm -f $(TARGETS) lib/*.a src/*.o *.log *.input

.PHONY:		all test clean

# TODO: Add rules for bin/spidey, lib/libspidey.a, and any intermediate objects

src/forking.o: 		src/forking.c 
	@echo Compiling src/forking.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

src/handler.o: 		src/handler.c
	@echo Compiling src/handler.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

src/request.o: 		src/request.c
	@echo Compiling src/request.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

src/single.o: 		src/single.c
	@echo Compiling src/single.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

src/socket.o: 		src/socket.c
	@echo Compiling src/socket.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

src/utils.o: 		src/utils.c
	@echo Compiling src/utils.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

lib/libtable.a:  	src/forking.o src/handler.o src/request.o src/single.o src/socket.o src/utils.o
	@echo Linking lib/libtable.a...
	-@ $(AR) $(ARFLAGS) $@ $^

src/server.o:        src/server.c
	@echo Compiling src/server.o...
	-@ $(CC) $(CFLAGS) -fPIC -c -o $@ $^

bin/server:          src/server.o lib/libtable.a
	@echo Linking bin/server...
	-@ $(LD) $(LDFLAGS) -o $@ $^


