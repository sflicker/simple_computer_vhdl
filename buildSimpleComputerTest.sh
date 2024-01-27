#! /bin/bash
ghdl --clean

ghdl -a --std=08 -fsynopsys memory.vhdl
ghdl -a --std=08 -fsynopsys data_register.vhdl
ghdl -a --std=08 -fsynopsys mux.vhdl
ghdl -a --std=08 -fsynopsys SimpleComputerTest.vhdl

ghdl -a --std=08 -fsynopsys SimpleComputerTest.vhdl
ghdl -e --std=08 -fsynopsys SimpleComputerTest
ghdl -r --std=08 -fsynopsys SimpleComputerTest --stop-time=10000ns --vcd=SimpleComputerTest.vcd
