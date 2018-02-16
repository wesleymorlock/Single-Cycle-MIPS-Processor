module memReadWrite(input clk, input memWrite, input memRead, input [31:0] address, input [31:0] writeData, output reg [31:0] readData);

  reg [31:0] mem [32'h7ffffffc >> 2: (32'h7ffffffc >> 2) - 256];

  always @(*)
  begin
    if (memRead == 1)
      readData = mem[address >> 2];
  end

  always @(negedge clk)
  begin
    if (memWrite == 1)
      mem[address >> 2] = writeData;
  end
endmodule

