/* syscall module
 *
 */
module callSys(input syscall, input [31:0] v, input [31:0] a, output reg runStats);

initial begin
  runStats = 0;
end

always @(*)
begin
  if(syscall == 1) begin
    if(v == 1) begin
      $display("print: %d", a);
    end
    else if(v == 10) begin
      $display("killing program");
      runStats = 1; 
      #1; $finish;
    end
  end
end
endmodule
