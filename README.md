Wesley Morlock
CSCI 320
Project 1
16 February 2018

Design:
This project is made up of 15 different modules, all included and run from a single testbench. The modules included in the project are:

	adder.v
	add4.v
	alu.v
	andGate.v
	control.v
	getJumpAddr.v
	memory.v
	memReadWrite.v
	mux.v
	pc.v
	registers.v
	regMux.v
	signExtend.v
	statistics.v
	syscall.v

The testbench, `myTest.v`, runs includes each of the module files, along with `mips.h`to include defined global constants for opcodes, function codes, register numbers, and control signal bit numbers. 

Based on the single cycle cpu diagram (found in project description: http://www.eg.bucknell.edu/~csci320/2018-spring/project-1-single-cycle-mips/), timing is an important part of getting the cpu to operate. In verilog, this can be done using sensitivity statements which affect the always blocks of each module. The PC module is one of the few that runs on the positive edge of a clock. This is so that the operation is read at the beginning of a clock cycle and all of the other modules can run based on what is interpreted as the instruction at the current pc.  

-how it works, what runs when (based on sensitivity/clock)

Compilation:

-running makefile and what it does to write add_test and fibonacci

To compile the project into a working executable, navigate to the modules directory and run the following command: `iverilog -o fibOutput myTestbench.v`.

Execution: 
After compiling, the program can be executed by running the command `vvp fibOutput`. Running the current program will execute fibonacci, which outputs a value of 55 as the 10th number in the fibonacci sequence. To execute the `add_test` program, in the `memory.v` file, change the `$readmemh` statement to read from `add_test.v` instead of `fibonacciRefined.v`. For the alternate fibonacci files, change this to `fibonacciRefined5` or `fibonaaciRefined20`. And again compile and run using the same commands.  

Testing:
In terms of testing, statistics were run on the add_test and fibonacci files. For additional statistics, additional fibonacciRefined files were modified to output the 5th and 20th fibonacci numbers. The results of these statistics were as follows:

add_test.v
20 time units,
 clock cycles:          7,
 number of instructions:          7,
 Instructions per Clock Cycle: 1.000000

fibonacciRefined.v
41500 time units,
 clock cycles:       2076,
 number of instructions:       2076,
 Instructions per Clock Cycle: 1.000000

fibonacciRefined5.v
3500 time units,
 clock cycles:        176,
 number of instructions:        176,
 Instructions per Clock Cycle: 1.000000

fibonacciRefined20.v
5141100 time units,
 clock cycles:     257056,
 number of instructions:     257056,
 Instructions per Clock Cycle: 1.000000
NOTE: to get this execution to run fully, the timestep for `$finish` in `myTest.v` needed to be increased to `#10000000

From these results, it is clear that these programs are running on a single cycle cpu because of the fact that the IPC is always 1. Another important result is the amount of time required for each of the program executions. `add_test` does not require a lot of time because it is a much simpler program with just a few arithmetic instructions. As we move to fibonacci, however, the program includes branching, loading and storing in memory, as well is syscalls. The program executes in a loop until the desired fibonacci value is calculated. As number term for the fibonacci value increases (5, 10, or 20 in these tests), the number of time units increases significantly. This same relation shows in the clock cycles and number of instructions, because many more operations are required to calculate an nth fibonacci number. 

Furthermore, gtkwave images were created for each of these outputs. They can be found in the gtkwaves directory under the names:
	
	add_test_gtk.png
	fib10_gtk.png
	fib5_gtk.png
	fib20_gtk.png
These images show the exact changes of values throughout time.
 
	-run with different numbers to get stats on:
		-total sim time = monitor in syscall
		-number of clock cycles = count in testbench
		-number of instructions executed = count in control block
		-IPC = number of instructions / clock cycles
	-gtkwave on add_test and fib
