class producer;
  mailbox #(int) mb;
  function new(mailbox #(int) mb);
    this.mb=mb;
  endfunction
  
  task put();
    for (int i=1; i<5; i++) 
      begin
        mb.put(i);
        $display("at %0t producer put the value =%0d",$time,i);
        #1;
      end
  endtask
endclass


class consumer;
  mailbox #(int) mb;
  function new(mailbox #(int) mb);
    this.mb=mb;
  endfunction
  
  task get();
    
    int i;
    repeat(4) 
      begin
        mb.get(i);
        $display("at %0t consumer get the value =%0d",$time,i);
        #3;
      end
  endtask
endclass

module tb;
  mailbox #(int) mb=new();
  producer p=new(mb);
  consumer c=new(mb);

  initial begin
    fork
      p.put();
      c.get();
    join
  end
endmodule








// output
// # KERNEL: at 0 producer put the value =1
// # KERNEL: at 0 consumer get the value =1
// # KERNEL: at 1 producer put the value =2
// # KERNEL: at 2 producer put the value =3
// # KERNEL: at 3 consumer get the value =2
// # KERNEL: at 3 producer put the value =4
// # KERNEL: at 6 consumer get the value =3
// # KERNEL: at 9 consumer get the value =4
