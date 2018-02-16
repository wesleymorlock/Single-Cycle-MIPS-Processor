/* adder module
 *
 */
module adder(input [31:0] pcPlus4, input [31:0] signedImmediate, output reg [31:0] adderResult);


  always @(*)
  begin
    adderResult = pcPlus4 + {signedImmediate << 2};
  end

endmodule
