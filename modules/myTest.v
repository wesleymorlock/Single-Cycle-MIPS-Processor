`include "../mips.h"
`include "./pc.v"
`include "./add4.v"
`include "./memory.v"
`include "./control.v"
`include "./getJumpAddr.v"
`include "./mux.v"
`include "./regMux.v"
`include "./alu.v"
`include "./registers.v"
`include "./signExtend.v"
`include "./syscall.v"
`include "./memReadWrite.v"
`include "./andGate.v"
`include "./adder.v"



/* testbench module
 *
 */
module testbench;
  wire [31:0] nextPC;
  wire [31:0] currPC;
  wire [31:0] instr;
  wire [31:0] PCplus4;
  wire [31:0] jumpAddr;
  wire [10:0] controlSignals;
  wire [31:0] writeData;
  wire [31:0] readData1;
  wire [31:0] readData2;
  wire [31:0] signExtendedValue;
  wire [31:0] aluAddress;
  wire [31:0] aluMuxOut;
  wire [31:0] regV0;
  wire [31:0] regA0;
  wire [4:0] writeReg;
  wire syscall_control;
  wire zero;
  reg clk = 1;
  wire [31:0] adderResult;
  wire andResult;
  wire [31:0] branchMuxResult;
  wire [31:0] dataMemRead; 
  wire isJR;
  wire isJAL;
  wire [31:0] JRmuxOut;
  wire [31:0] regRA;
  

  // get current pc
  pc PC_block(clk, nextPC, currPC);
  
  // add 4 to pc for next pc
  add4 PCadd4(currPC, PCplus4);

  // get instruction from memory
  memory instructionMemory(currPC, instr);

  // calculate jump address
  getJumpAddr JumpAddr_block(instr, PCplus4, jumpAddr);
  
  // get all control signals
  control control_block(instr, syscall_control, controlSignals, isJR, isJAL);

  // mux to determine JR or new jump address
  mux JRmux(isJR, jumpAddr, regRA, JRmuxOut);
 
  // mux for write register
  regMux registerMux(controlSignals[`REGDST], instr[20:16], instr[15:11], writeReg);
 
  // execute registers block
  registers reg_block(clk, isJAL, currPC + 8, instr[25:21], instr[20:16], writeReg, writeData, controlSignals[`REGWRITE], readData1, readData2, regV0, regA0, regRA);
 
  // execute syscall if necessary
  callSys testSyscall(syscall_control, regV0, regA0);

  // branch adder
  adder branchAdder(PCplus4, signExtendedValue, adderResult);
  
  // and gate for control signals
  andGate branchAnd(controlSignals[`BRANCH], zero, andResult);

  // branch mux
  mux branchMux(andResult, PCplus4, adderResult, branchMuxResult);

  // mux for jump control
  mux jumpMux(controlSignals[`JUMP], branchMuxResult, JRmuxOut, nextPC);
 
  // sign extend the immediate
  signExtend signExtend_block(instr, signExtendedValue);

 
  // mux for alu
  mux aluMux(controlSignals[`ALUSRC], readData2, signExtendedValue, aluMuxOut);

  // execute alu block
  alu ALU_block(readData1, aluMuxOut, controlSignals[`ALUOP], aluAddress, zero);

  //
  memReadWrite dataMem(clk, controlSignals[`MEMWRITE], controlSignals[`MEMREAD], aluAddress, readData2, dataMemRead);

  //
  mux dataMemMux(controlSignals[`MEMTOREG], aluAddress, dataMemRead, writeData);

always begin
  #10 clk = ~clk;
end

initial
begin
  $dumpfile("testbench.vcd");
  $dumpvars(0,testbench);
  #50000 $finish;
end
endmodule
