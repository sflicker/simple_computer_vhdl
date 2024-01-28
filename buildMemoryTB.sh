#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys memory.vhd
ghdl -a --std=08 -fsynopsys memory_test_bench.vhd
ghdl -e --std=08 -fsynopsys Memory_TB 
ghdl -r --std=08 -fsynopsys Memory_TB --stop-time=10000ns --vcd=memory_register.vcd
