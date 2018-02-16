/* regMux module for which register is the write register
 *
 */

module regMux(input controlSignal, input [4:0] input0, input [4:0] input1, output reg [4:0] muxOut);

always @(*)
begin
  if (controlSignal == 0)
    muxOut = input0;
  else
    muxOut = input1;
end

endmodule