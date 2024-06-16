class Queue #(parameter int max_size=5, type t=int);
  t queue[max_size];
  int front, rear , count;
  t item;
  
  function new();
    front=0;
    rear=-1;
    count=0;
  endfunction
  
  function void push(t item);
    if (count>=max_size)
      $display("queue is full, cant push more item");
    else begin
      rear=(rear+1)% max_size;
      queue[rear]=item;
      count++;
      $display("item pushed , current size of queue=%d",count);end
  endfunction
  
  function t pop();
    
    if (count==0)begin
      $display("queue is empty, cant pop more item");
      return t'(0) ;

    end
    else begin
      item=queue[front];
      front=(front+1)%max_size;
      count--;
     
      return item;
      $display("item popped, current size of queue=%d",count);
    end
  endfunction
  
endclass



//testbench
// Code your testbench here
// or browse Examples
module Queue_tb();
  Queue #(4,int) q1;
  Queue #(3,string) q2;
  Queue #(5,real) q3;
  
  initial begin
    q1=new();
    q1.push(1);
    q1.push(2);

    $display("popped item is : %0d",q1.pop());
    $display("popped item is : %0d",q1.pop());
    $display("popped item is : %0d",q1.pop());
    
    q1.push(3);
    q1.push(4);
    q1.push(5);
    q1.push(6);
    q1.push(7);
    $display("popped item is : %0d",q1.pop());
    
    $display("---------------------------");
    
    q2=new();
    q2.push("A");
    q2.push("B");

    $display("popped item is : %s",q2.pop());
    $display("popped item is : %s",q2.pop());
    $display("popped item is : %s",q2.pop());
    
    q2.push("C");
    q2.push("D");
    q2.push("E");
    q2.push("F");
    q2.push("G");
    $display("popped item is : %s",q2.pop());
    $display("popped item is : %s",q2.pop());
    q2.push("F");
    q2.push("G");
    
    $display("---------------------------");    
    
    q3=new();
    q3.push(1.22);
    q3.push(2.5);

    $display("popped item is : %f",q3.pop());
    $display("popped item is : %f",q3.pop());
    $display("popped item is : %f",q3.pop());
    
    q3.push(6.55);
    q3.push(6.2);
    q3.push(56.1);
    q3.push(2.12);
    q3.push(5.2);
    $display("popped item is : %f",q3.pop());
    $display("popped item is : %f",q3.pop());
    $display("popped item is : %f",q3.pop());
    $display("---------------------------");    
  end
   
endmodule


    
    
    
    
  
  
        
    	
    
        
      
        
    
      
      

      
      
    
    
      
  
  
