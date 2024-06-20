module event_practise();
  event e;
  
  task A();
    #5->e;
//  #5->>e;
    $display("A: at time %0t event e triggered",$time);
    
  endtask
  
  task B();
    #5
    @(e);
    $display("B: at time %0t event e triggered using @",$time);
    
  endtask  
  
  task C();
    #5
    wait(e.triggered);
    $display("C: at time %0t event e triggered using wait()",$time);
    
  endtask    
  
  initial begin
    fork
      A();
      B();
      C();
    join
  end
endmodule

