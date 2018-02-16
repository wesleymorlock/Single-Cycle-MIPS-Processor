/* pc module
 * 
 */
module pc(input clk, input [31:0] nextPC, output reg [31:0] currPC);

initial
begin
    currPC = 32'h00400020;
end

always @(posedge clk)
begin
  if($time != 0)
    currPC = nextPC;
end

endmodule
