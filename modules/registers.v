/* registers module
 *
 */
module registers(input clk, input isJAL, input [31:0] JALaddress, input [4:0] readReg1, input [4:0] readReg2, input [4:0] writeReg, input [31:0] writeData, input regWrite, output reg [31:0] readOut1, output reg [31:0] readOut2, output wire [31:0] v0, output wire [31:0] a0, output wire [31:0] ra);

  reg [31:0] reggies[0:31];
  integer i;

  initial begin
    for(i = 0; i < 32; i += 1) begin
      reggies[i] = 32'b0;
    end
  end

  assign v0 = reggies[`v0];
  assign a0 = reggies[`a0];
  assign ra = reggies[`ra];

  // read block
  always @(readReg1, readReg2) begin
    readOut1 = reggies[readReg1];
    readOut2 = reggies[readReg2];
  end

  // write block
  always @(negedge clk) 
  begin
    if ((regWrite == 1) & (writeReg != `zero)) begin
      if (isJAL == 1)
        reggies[`ra] = JALaddress;
      else
        reggies[writeReg] = writeData;
    end
  end
endmodule
