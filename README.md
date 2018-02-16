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

In the single cycle cpu diaram (found in Project 1 description at: http://www.eg.bucknell.edu/~csci320/2018-spring/project-1-single-cycle-mips/), each wire that connects modules is represented in the testbench. These wires connect outputs to inputs, and within modules registers are defined to help keep track and manipulate values/variables. 

As an overview, the diagram starts with the PC counter determining where it should read an instruction from. The instruction memory reads the instruction at that location and sends it to various modules such as the registers and control block. Each instruction can be broken down into different pieces of information such as register addresses, operation codes, immediate values, etc. so within each module the instruction is handled properly so that the information is processed correctly. The control block creates bit signals that reach out to many of the other modules. These signals are important in determining what actions to take such as jumping, branching, reading, or writing (amongst others).

The registers module reads data from registers and passes it to the ALU. Again, based on control signals, the ALU will perform an operation and sends the result to the data memory. From here, the options are to write the data, read data, and pass the data memory back to the registers to possibly be written.

At the same time, the cpu is calculating which instruction should be run next. The program counter will try to increment to the next instruction (current pc + 4), but in cases of jumps and branches this next instruction might not be the next to follow linearly.  

Equally as important to the other modules, but more abundant is the MUX module. This module will take control signals and based on its value let one of two inputs pass through as the output. This is extremely important for choosing the destination register, write data, alu input, and next pc (for branch and jump).

While the workings are a bit more complicated and detailed than the above description, this is a high level design that the modules were modeled after and integrated in order to execute the test programs.


Compilation:

To compile the project into a working executable for the fibonacci program, navigate to the modules directory and run the following command: `iverilog -o fibOutput myTestbench.v`. 

To run the other test programs, the following changes would need to be made. As well the code for these compilations are included below:

add_test:
	Change `$readmemh` statement in memory.v to read `add_test.v`. Compile with `iverilog -o addTestOutput myTest.v`.

fibonacci5:
	Change `$readmemh` statement in memory.v to read `fibonacciRefined5.v`. Compile with `iverilog -o fib5Output myTest.v`.

fibonacci20:
	Change `$readmemh` satement in memory.v to read `fibonacciRefined20.v`. Change the total run time in the always block of myTest.v to be `#1000000`. Compile with `iverilog -o fib20Output myTest.v`.


Execution: 
After compiling, run any of the executables with the following:

fibonacci:  `vvp fibOutput`
add_test:  `vvp addTestOutput`
fibonacci5:  `vvp fib5Output`
fibonacci20:  `vvp fib20Output`

For each of the fibonacci executions, there should be a print statement with the correct fibonacci value. There is also an output monitor statement that reports the time, clock cycles, number of instructions, and IPC. To get this to print out more than just the final number, the syscall 1 would need to be moved to inside the loop of branches. This would result in printing every value instead of just the final end result.

For add_test, the output is a printed value of 3. 

Testing:
In terms of testing, statistics were run on the add_test and fibonacci files. For additional statistics, additional fibonacciRefined files were modified to output the 5th and 20th fibonacci numbers. The results of these statistics were as follows:

add_test.v:
20 time units,
 clock cycles:          7,
 number of instructions:          7,
 Instructions per Clock Cycle: 1.000000

fibonacciRefined.v:
41500 time units,
 clock cycles:       2076,
 number of instructions:       2076,
 Instructions per Clock Cycle: 1.000000

fibonacciRefined5.v:
3500 time units,
 clock cycles:        176,
 number of instructions:        176,
 Instructions per Clock Cycle: 1.000000

fibonacciRefined20.v:
5141100 time units,
 clock cycles:     257056,
 number of instructions:     257056,
 Instructions per Clock Cycle: 1.000000
NOTE: to get this execution to run fully, the timestep for `$finish` in `myTest.v` needed to be increased to `#10000000

From these results, it is clear that these programs are running on a single cycle cpu because of the fact that the IPC is always 1. Another important result is the amount of time required for each of the program executions. `add_test` does not require a lot of time because it is a much simpler program with just a few arithmetic instructions. As we move to fibonacci, however, the program includes branching, loading and storing in memory, as well is syscalls. The program executes in a loop until the desired fibonacci value is calculated. As number term for the fibonacci value increases (5, 10, or 20 in these tests), the number of time units increases significantly. This same relation shows in the clock cycles and number of instructions, because many more operations are required to calculate an nth fibonacci number. 

To know that the programs were executing properly, `$display` statments were used to output registers and other important values to ensure that they were being changed at the correct times and to correct values. This made debugging easier to see which registers or values were being set incorrectly and which operations may be the cause of those problems. A lot of this can also be viewed from a gtkwave file, but for the sake of debugging, the display and monitor statements were easiest.

Once the programs all executed correctly, gtkwave images were created for each of the outputs to show that everything was manipulated properly over the execution of the program. They can be found in the gtkwaves directory under the names:
	
	add_test_gtk.png
	fib10_gtk.png

