/* ALU module
 *
 */
module alu(input [31:0] data1, input [31:0] data2, input [2:0] aluOp, output reg [31:0] address, output reg zero);

// output zero can be a continuous result where the ALU result == 0

always @(*)
begin
  // make this a case statement
  case (aluOp)
  3'b000:
    address = data1 & data2;
  3'b001:
    address = data1 | data2;
  3'b010:
    address = data1 + data2;
  3'b110:
    address = data1 - data2;
  3'b111: 
  begin
    if (data1 < data2)
      address = 1;
    else
      address = 0; 
  end
  3'b011: // handles an LUI command
    address = {data2, 16'b0};
 default:
    $display("command not found");
  endcase

  zero = (address == 0) ? 1 : 0;
end
endmodule
