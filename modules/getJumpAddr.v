/* getJumpAddr module
 *
 */
module getJumpAddr(input [31:0] instr, input [31:0] PCplus4, output wire [31:0] jumpAddr);

    assign jumpAddr = {PCplus4[31:28], instr[25:0] << 2};

endmodule