/* sign extend module
 *
 */
module signExtend(input [31:0] instr, output reg [31:0] extendedImmediate);

  always @(*)
  begin
    if (instr[`op] == `ORI)
      extendedImmediate = { 16'b0, instr[15:0] };
    else
      extendedImmediate = { {16{instr[15]}}, instr[15:0]};
  end
endmodule

