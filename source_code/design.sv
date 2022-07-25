// DUT Description :
//--------------------------------------------------------------------
// Detect if the input series of data is incrementing or decrementing
// Inputs to the DUT are clk, reset & 4 bit data input
// Outputs from the DUT are incr, decr, error
// If data increases by 1, flag the incr output as 1
// If data decreases by 1, flag the decr output as 1
// Else flag the error outputs as 1
//--------------------------------------------------------------------

// Code your DUT here
// Describe all your assumptions
/* If data is 1 more,less or equal to the prev data the error flag will be set high
Reset bit needs to initialised first to set all the flags to zero

*/
interface dut_if;
  logic clk;
  logic reset;
  logic[3:0] data;
  logic incr;
  logic decr;
  logic error;

endinterface

module CD(dut_if test);
  
  logic[3:0] prev;
  always @(posedge test.clk)
    begin
      if(test.reset)
        begin
          test.incr<='0;
          test.error<='0;
          test.decr<='0;
        end
      else
        begin
          if(prev==(1+test.data))
            begin
              test.decr<='1;
              test.incr<='0;
              test.error<='0;
            end
          else if(prev==(test.data-1))
            begin
              test.incr<='1;
              test.decr<='0;
              test.error<='0;
            end
          else
            begin
              test.incr<='0;
              test.decr<='0;
              test.error<='1;
            end
          prev<=test.data;
        end
    end  
                
endmodule
          
  
