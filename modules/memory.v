/* memory module
 *
 */
module memory(input [31:0] currPC, output reg [31:0] instr, output reg [31:0] instructionCount);

    reg [31:0] mem[29'h00100000:29'h00100100];

    initial begin
	instructionCount = 0;
        $readmemh("fibonacciRefined.v", mem);
    end

    always @(currPC) begin
	instructionCount += 1;
        instr = mem[currPC[31:2]];
    end

endmodule
