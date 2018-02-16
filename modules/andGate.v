/* andGate module
 *
 */
module andGate(input branch, input zero, output reg andResult);

  always @(*)
  begin
    andResult = 0;

    if((branch == 1) & (zero == 1))
      andResult = 1; 
  end

endmodule
