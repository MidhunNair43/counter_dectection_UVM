# counter_dectection_UVM

This project's main intention is to learning how to use a UVM testbench and its associated properties.

// DUT Description :
//--------------------------------------------------------------------
// Detect if the input series of data is incrementing or decrementing
// Inputs to the DUT are clk, reset & 4 bit data input
// Outputs from the DUT are incr, decr, error
// If data increases by 1, flag the incr output as 1
// If data decreases by 1, flag the decr output as 1
// Else flag the error outputs as 1
//--------------------------------------------------------------------


If data is 1 more,less or equal to the prev data the error flag will be set high
Reset bit needs to initialised first to set all the flags to zero

Test bench description:

The coverage group consist of 4 main groups greater,smaller, equal and errors_notequal. I find these are the most of the corner cases that needs to be covered. 
Rand is used as data input and a more through check can be done by using a for loop can trying for all 16X16 (prevXcurrent) combinations. Assertions are used to check whether conflicting conditions are occuring at once due to sequential logic error.
x states are covered to the error flag.
Assertions to check whether when incr is high is only when prev is equal to data-1
Assertions to check whether when decr is high is only when prev is equal to data+1
Assertions to check whether when reset is high incr,decr and error are set 0.



