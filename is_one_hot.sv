module tb;
  
  int a;
  
  function int is_one_hot(int a);
    is_one_hot = ((a != 0) && ((a & (a - 1)) == 0));
  endfunction

  initial begin
    
    a = 128;
    $display("a = %0d, is onehot: %0d", a, is_one_hot(a));
        
    a = 10;
    $display("a = %0d, is onehot: %0d", a, is_one_hot(a));
       
    a = 8;
    $display("a = %0d, is onehot: %0d", a, is_one_hot(a));
         
    a = 31;
    $display("a = %0d, is onehot: %0d", a, is_one_hot(a));
        
    a = 32;
    $display("a = %0d, is onehot: %0d", a, is_one_hot(a));
  end
  
endmodule


/*OUTPUT:
# KERNEL: a = 128, is onehot: 1
# KERNEL: a = 10, is onehot: 0
# KERNEL: a = 8, is onehot: 1
# KERNEL: a = 31, is onehot: 0
# KERNEL: a = 32, is onehot: 1
*/
