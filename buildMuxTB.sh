#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys mux.vhdl
ghdl -a --std=08 -fsynopsys mux_test_bench.vhdl
ghdl -e --std=08 -fsynopsys MuxTestBench
ghdl -r --std=08 -fsynopsys MuxTestBench --stop-time=10000ns --vcd=mux.vcd
