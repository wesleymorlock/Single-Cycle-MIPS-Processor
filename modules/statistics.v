/* Statistics module
 *
 */
module statistics(input clk, input runStats, input [31:0] instructionCount);

  reg [31:0] clkCount;
  real ipc;

  initial
  begin
    clkCount = 0;
  end

  always @(posedge clk)
  begin
    clkCount += 1;
  end

  always @(runStats)
  begin
    ipc = instructionCount / clkCount;
    $monitor($time, " time units,\n clock cycles: %d,\n number of instructions: %d,\n Instructions per Clock Cycle: %f", clkCount, instructionCount, ipc);
  end
endmodule
