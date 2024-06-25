class transaction;
  rand bit [2:0] data;
  
covergroup cg;
  coverpoint data{ bins b1={0};
                  bins b2={[1:6]};
                  bins b3={7};}
endgroup

function new();
  this.cg=new();
endfunction
endclass

class producer;
  transaction t;
  mailbox #(transaction) mb;
  function new( mailbox #(transaction) mb);
    this.mb=mb;
  endfunction
  
  task run;
    t=new();
    forever begin     
      t.randomize();
      mb.put(t);
      #5;
    end
  endtask
endclass

class consumer;
  transaction t1;
  mailbox #(transaction) mb;
  function new( mailbox #(transaction) mb);
    this.mb=mb;
  endfunction
  
  task run;
    forever begin
      mb.get(t1);
      $display("data=%d",t1.data);
      t1.cg.sample();
    end
  endtask
endclass
      
// TESTBENCH

module tb();  
  producer p;
  consumer c;
  mailbox #(transaction) mb;
    
  initial begin
    mb = new();
    p = new(mb);
    c = new(mb);
  
    fork      
      p.run();
      c.run();
      #2000;                       // as we give forever loop in run task, so to stop it giving 1statement as #2000 ,
    join_any                       // using join_any , so after 2000 timestamp 1process is complete , come out of fork join nd stops , and after 1000 kill the remainig processes also.
   
    #1000
    $display("Coverage = %0f",c.t1.cg.get_coverage());                  ///from consumer(c) to transaction(t1) to covergrp(cg) to get_coverage
    $finish;  
  end  
endmodule
