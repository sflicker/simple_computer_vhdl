#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys data_register.vhdl
ghdl -a --std=08 -fsynopsys data_register_test_bench.vhdl
ghdl -e --std=08 -fsynopsys DataRegisterTestBench
ghdl -r --std=08 -fsynopsys DataRegisterTestBench --stop-time=10000ns --vcd=data_register.vcd
