Wesley Morlock
CSCI 320
Project 1
16 February 2018

Design:
This project is made up of 15 different modules, all included and run from a single testbench. The modules included in the project are:
	-alu.v
	-adder.v
	-andGate.v
	-add4.v
	-control.v
	-getJumpAddr.v
	-memory.v
	-memReadWrite.v
	-mux.v
	-pc.v
	-registers.v
	-regMux.v
	-signExtend.v
	-statistics.v
	-syscall.v

The testbench, `myTest.v`, runs includes each of the module files, along with `mips.h`to include defined global constants for opcodes, function codes, register numbers, and control signal bit numbers. 

-how it works, what runs when (based on sensitivity/clock)

Compilation:
-running makefile and what it does to write add_test and fibonacci
To compile the project into a working executable, navigate to the directory and run the following command: `iverilog -o fibOutput myTestbench.v`.

Execution: 
After compiling, the program can be executed by running the command `vvp fibOutput`. Running the current program will execute fibonacci, which outputs a value of 55 as the 10th number in the fibonacci sequence. To execute the `add_test` program, in the `memory.v` file, change the `$readmemh` statement to read from `add_test.v` instead of ` 

Testing:
	-run with different numbers to get stats on:
		-total sim time = monitor in syscall
		-number of clock cycles = count in testbench
		-number of instructions executed = count in control block
		-IPC = number of instructions / clock cycles
	-gtkwave on add_test and fib
