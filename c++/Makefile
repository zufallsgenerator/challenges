CXX=c++
CXXFLAGS= -Wall -std=c++11
LDFLAGS= -lssl -lcrypto

debug:clean
	$(CXX) $(CXXFLAGS) -g  -o challenge4 challenge4.cpp $(LDFLAGS)
release:clean
	$(CXX) $(CXXFLAGS) -O2 -o challenge4 challenge4.cpp $(LDFLAGS)
clean:
	rm -vfr *~ challenge4
