#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys mux.vhd
ghdl -a --std=08 -fsynopsys mux_test_bench.vhd
ghdl -e --std=08 -fsynopsys MuxTestBench
ghdl -r --std=08 -fsynopsys MuxTestBench --stop-time=10000ns --vcd=mux.vcd
