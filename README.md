Wesley Morlock
CSCI 320
Project 1
16 February 2018

Design:
	-modules (15)
	-testbench (1)

Compilation:
To compile the project into a working executable, navigate to the directory and run the following command: `iverilog -o fibOutput myTestbench.v`.

Execution: After compiling, the program can be executed by running the command `vvp fibOutput`. Running the current program will execute fibonacci, which outputs a value of 55 as the 10th number in the fibonacci sequence. To execute the `add_test` program, in the `memory.v` file, change the `$readmemh` statement to read from `add_test.v` instead of ` 

Testing:
	-run with different numbers to get stats on:
		-total sim time = monitor in syscall
		-number of clock cycles = count in testbench
		-number of instructions executed = count in control block
		-IPC = number of instructions / clock cycles

