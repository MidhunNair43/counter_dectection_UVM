// Code your testbench (including checks and coverage) here to verify the DUT.

// Provide details of verification strategy & testbench.
/*The coverage group consist of 4 main groups greater,smaller, equal and errors_notequal. I find these are the most of the corner cases that needs to be covered. 
Rand is used as data input and a more through check can be done by using a for loop can trying for all 16X16 (prevXcurrent) combinations. Assertions are used to check whether conflicting conditions are occuring at once due to sequential logic error.
x states are covered to the error flag.
asssertions to check whether when incr is high is only when prev is equal to data-1
asssertions to check whether when decr is high is only when prev is equal to data+1
asssertions to check whether when reset is high incr,decr and error are set 0

*/
// NOTE: Display messages are not checks.
//--------------------------------------------------------------------
`include "uvm_macros.svh"
`include "testbench_pckg.svh"


// The top module that contains the DUT and interface.
// This module starts the test.
module top;
  import uvm_pkg::*;
  import testbench_pckg::*;
  
  logic[3:0] prev;
  // Instantiate the interface
  dut_if dut_if1();
  
  // Instantiate the DUT and connect it to the interface
  CD dut(dut_if1);
  
  
  // Clock generator
  initial begin
    dut_if1.clk = 0;
    forever #5 dut_if1.clk = ~dut_if1.clk;
  end
  // Reset 
  initial begin
    dut_if1.reset=1;
  #5
  dut_if1.reset=0;
  end
  
  always @(posedge dut_if1.clk)
    prev<=dut_if1.data;
//Cover Group //////////////////////////////////////  
 covergroup CovGrp @(posedge dut_if1.clk);
    option.per_instance = 1;    // show bins in GUI & each instance coverage is collected separately
    option.comment = "Checks"; 
    greater: coverpoint prev==dut_if1.data+1;
    smaller: coverpoint prev==dut_if1.data-1;
    equal:   coverpoint prev==dut_if1.data;
    errors_notequal: coverpoint prev>dut_if1.data+1 || prev<dut_if1.data-1 ;
	endgroup
  
CovGrp cg;
  initial begin
  cg = new();
      cg.sample();
    $display(cg.get_coverage());
  end
///////////////////////////////////////////////////  
//Asssertions//////////////////////////////////////
property all_high;
  @ (posedge dut_if1.clk) not (dut_if1.decr && dut_if1.incr && dut_if1.error);
endproperty
property incr_decr;
  @ (posedge dut_if1.clk) not (dut_if1.decr && dut_if1.incr);
endproperty  
property incr_error;
  @ (posedge dut_if1.clk) not ( dut_if1.incr && dut_if1.error);
endproperty
property decr_error;
  @ (posedge dut_if1.clk) not (dut_if1.decr && dut_if1.error);
endproperty  
property incr;
  @ (posedge dut_if1.clk) (prev==dut_if1.data-1) |=> $rose(dut_if1.incr) ;
endproperty
property decr;
  @ (posedge dut_if1.clk) (prev==dut_if1.data+1) |=> $rose(dut_if1.decr);
endproperty
property reset;
  @ (posedge dut_if1.clk) ((dut_if1.incr && dut_if1.decr && dut_if1.error)) |=> $rose(dut_if1.reset);
endproperty
  

  
  assert property (all_high)
    else $warning("All flags are high!");
  assert property (incr_decr)
    else $display("Flags incr and decr high!");
  assert property (incr_error)
    else $display("Flags incr and error high!");
  assert property (decr_error)
    else $display("Flags decr and error high!");
    assert property (incr)
      else $display("prev not equal to data-1 when incr is 1!");
  assert property (decr)
    else $display("prev not equal to data+1 when decr is 1!");
    assert property (reset)
      else $warning("All values not reset");
      assert property (all_high)
    else $display("All flags are high!");
///////////////////////////////////////////////
  initial begin
    // Placing the interface into the UVM configuration database
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_vif", dut_if1);
    // Start the test
    run_test("my_test");
    
  end
  
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
   
endmodule




