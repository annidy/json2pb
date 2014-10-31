CPPFLAGS = -g -fPIC -I.
LDFLAGS = -lprotobuf -ljansson
CC = clang++
all: libjson2pb.dylib test_json

clean:
	-rm -f *.o *.dylib *.a libjson2pb.dylib.* test

test_json: test_json.o test.pb.o libjson2pb.dylib
test_json.o: test.pb.h

json2pb.o: bin2ascii.h

libjson2pb.dylib: json2pb.o
	$(CC) $(LDFLAGS) -o $@ $^ -dynamiclib

test.pb.h test.pb.cc: test.proto
	protoc --cpp_out=$(shell pwd) test.proto
