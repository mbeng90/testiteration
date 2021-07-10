
GXX = g++
CLANGXX = clang++
CXXSTD = -std=c++2a 
OPTDBG = -O3 -march=haswell #-march=skylake
WARNFLAGS = -Wall -Wextra -Werror
GENERATEASM = -S -fverbose-asm -masm=intel
CXXFLAGS = $(CXXSTD) $(OPTDBG) $(WARNFLAGS)

SRC = testiteration.cc
ASMS = testiteration_gcc_Og.S testiteration_gcc_O1.S testiteration_gcc_O2.S testiteration_gcc_O3.S testiteration_gcc_O3_haswell.S \
       testiteration_clang_Og.S testiteration_clang_O1.S testiteration_clang_O2.S testiteration_clang_O3.S testiteration_clang_O3_haswell.S 
PROGS = $(patsubst %.S,%,$(ASMS))

all: $(PROGS) $(ASMS)


testiteration_gcc_Og.S: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -Og $(GENERATEASM) -o $@ $<

testiteration_gcc_Og: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -Og -o $@ $<

testiteration_gcc_O1.S: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O1 $(GENERATEASM) -o $@ $<

testiteration_gcc_O1: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O1 -o $@ $<

testiteration_gcc_O2.S: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O2 $(GENERATEASM) -o $@ $<

testiteration_gcc_O2: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O2 -o $@ $<

testiteration_gcc_O3.S: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O3 $(GENERATEASM) -o $@ $<

testiteration_gcc_O3: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O3 -o $@ $<

testiteration_gcc_O3_haswell.S: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O3 -march=haswell $(GENERATEASM) -o $@ $<

testiteration_gcc_O3_haswell: $(SRC)
	$(GXX) $(CXXSTD) $(WARNFLAGS) -O3 -march=haswell -o $@ $<


testiteration_clang_Og.S: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -Og $(GENERATEASM) -o $@ $<

testiteration_clang_Og: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -Og -o $@ $<

testiteration_clang_O1.S: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O1 $(GENERATEASM) -o $@ $<

testiteration_clang_O1: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O1 -o $@ $<

testiteration_clang_O2.S: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O2 $(GENERATEASM) -o $@ $<

testiteration_clang_O2: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O2 -o $@ $<

testiteration_clang_O3.S: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O3 $(GENERATEASM) -o $@ $<

testiteration_clang_O3: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O3 -o $@ $<

testiteration_clang_O3_haswell.S: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O3 -march=haswell $(GENERATEASM) -o $@ $<

testiteration_clang_O3_haswell: $(SRC)
	$(CLANGXX) $(CXXSTD) $(WARNFLAGS) -O3 -march=haswell -o $@ $<

.PHONY: run
run: $(PROGS)
	@echo "G++ with -Og"
	./testiteration_gcc_Og
	@echo "G++ with -O1"
	./testiteration_gcc_O1
	@echo "G++ with -O2"
	./testiteration_gcc_O2
	@echo "G++ with -O3"
	./testiteration_gcc_O3
	@echo "G++ with -O3 -march=haswell"
	./testiteration_gcc_O3_haswell
	@echo "Clang++ with -Og"
	./testiteration_clang_Og
	@echo "Clang++ with -O1"
	./testiteration_clang_O1
	@echo "Clang++ with -O2"
	./testiteration_clang_O2
	@echo "Clang++ with -O3"
	./testiteration_clang_O3
	@echo "Clang++ with -O3 -march=haswell"
	./testiteration_clang_O3_haswell

	
.PHONY: clean

clean: 
	rm -f $(PROGS) *.o

.PHONY: realclean
realclean: clean
	rm -f $(ASMS) *.o