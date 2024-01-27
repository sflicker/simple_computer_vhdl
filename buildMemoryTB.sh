#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys memory.vhdl
ghdl -a --std=08 -fsynopsys memory_test_bench.vhdl
ghdl -e --std=08 -fsynopsys Memory_TB 
ghdl -r --std=08 -fsynopsys Memory_TB --stop-time=10000ns --vcd=memory_register.vcd
