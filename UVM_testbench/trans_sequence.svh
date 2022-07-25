class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction)
 
  rand logic[3:0] data;
  
  function new(string name="");
    super.new(name);
    
  endfunction
  
endclass: my_transaction

class sequence_gen extends uvm_sequence#(my_transaction);
  `uvm_object_utils(sequence_gen)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body;
    repeat(100)
    begin
      req=my_transaction::type_id::create("req");
      start_item(req);

     if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
     end
      
      finish_item(req);
      end
    
  endtask: body
  
endclass: sequence_gen
