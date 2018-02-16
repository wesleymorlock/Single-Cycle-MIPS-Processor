/* memory module
 *
 */
module memory(input [31:0] currPC, output reg [31:0] instr);

    reg [31:0] mem[29'h00100000:29'h00100100];

    initial begin
        $readmemh("fibonacciRefined.v", mem);
    end

    always @(currPC) begin
        instr = mem[currPC[31:2]];
    end

endmodule
