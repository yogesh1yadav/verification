module with_semaphore();
  int i; 
  semaphore sema=new(1);
  
  task A();
    sema.get();
    $display("@%0t task A start",$time);
    i=i+10;
    $display("@%0t current value of i=%0d",$time,i);
    sema.put();
  endtask
  
  task B(); 
    sema.get();
    $display("@%0t task B start",$time);
    i=i+100; #1
    $display("@%0t current value of i=%0d",$time,i); 
    sema.put();
  endtask
  
  task C();
    sema.get();
    $display("@%0t task C start",$time);
    i=i+1000;
    $display("@%0t current value of i=%0d",$time,i); 
    sema.put();
  endtask
  
  initial 
    begin
      repeat(1)
        fork
          A();
          B();
          C();
        join
    end
  
endmodule
  

module without_semaphore();
  int i; 
  
  task A();  
    $display("@%0t task A start",$time);
    i=i+10;
    $display("@%0t current value of i=%0d",$time,i);
  endtask
  
  task B();
    $display("@%0t task B start",$time);
    i=i+100; #1
    $display("@%0t current value of i=%0d",$time,i); 
  endtask
  
  task C();
    $display("@%0t task C start",$time);
    i=i+1000;
    $display("@%0t current value of i=%0d",$time,i); 
  endtask
  
  initial 
    begin
      repeat(1)
        fork
          A();
          B();
          C();
        join
    end
endmodule

// output with semaphore:
// # KERNEL: @0 task A start
// # KERNEL: @0 current value of i=10
// # KERNEL: @0 task B start
// # KERNEL: @1 current value of i=110
// # KERNEL: @1 task C start
// # KERNEL: @1 current value of i=1110/


/*output without semaphore: observe that as due to fork join parallel access of process A and B occur due to at time @1 i value didnt increment both shows same i value, 
this is resolved by using semaphore, so one process work at a time , then when it release the key only then other process can occur , as sema.put() is blocking statement*/

// # KERNEL: @0 task A start
// # KERNEL: @0 current value of i=10
// # KERNEL: @0 task B start
// # KERNEL: @0 task C start
// # KERNEL: @0 current value of i=1110
// # KERNEL: @1 current value of i=1110
