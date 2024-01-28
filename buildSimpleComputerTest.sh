#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys memory.vhd
ghdl -a --std=08 -fsynopsys data_register.vhd
ghdl -a --std=08 -fsynopsys mux.vhd
ghdl -a --std=08 -fsynopsys SimpleComputerTest.vhd

ghdl -e --std=08 -fsynopsys SimpleComputerTest
ghdl -r --std=08 -fsynopsys SimpleComputerTest --stop-time=10000ns --vcd=SimpleComputerTest.vcd
