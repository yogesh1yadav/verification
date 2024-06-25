module dynamic_array;
  int array[];
  initial begin
    array=new[5];									                              //new[] : create a memory and allocate size, use for resize nd copy a dynamic array also
    array= {1,3,5,7,9};								

    foreach(array[i])
      $display("array[%0d] = %0d",i,array[i]);
    $display("size of array=%0d",array.size());
    $display("-----------");

    array=new[8] (array);                                      //resize and copy old array content
    array[5]=2;									                               //old content adds from starting, giving new content value by using indexing separately,   
    array[6]=4;									                               //cant use array={2,4,6};, it will override and new array have these 3 value only
    array[7]=6;
    foreach(array[i])
      $display("array[%0d] = %0d",i,array[i]);
    $display("new size of array=%0d",array.size());
    $display("-----------");
    
    array=new[3];                                             //ovveride, prev array data lost, and by default show 0 value , means null array
    foreach(array[i])
      $display("array[%0d] = %0d",i,array[i]);
    $display("new size of array=%0d",array.size());           //size is 3 , it is not like that, we didnt assign value so size is o. in memory array is created
    $display("-----------");
    
    array.delete();
    foreach(array[i])
      $display("array[%0d] = %0d",i,array[i]);			          // it will not show anything , as array is empty now , not exist.
    $display("new size of array=%0d",array.size());           // size is 0. 
    $display("-----------");  

  end
endmodule


/*OUTPUT
# KERNEL: array[0] = 1
# KERNEL: array[1] = 3
# KERNEL: array[2] = 5
# KERNEL: array[3] = 7
# KERNEL: array[4] = 9
# KERNEL: size of array=5
# KERNEL: -----------
# KERNEL: array[0] = 1
# KERNEL: array[1] = 3
# KERNEL: array[2] = 5
# KERNEL: array[3] = 7
# KERNEL: array[4] = 9
# KERNEL: array[5] = 2
# KERNEL: array[6] = 4
# KERNEL: array[7] = 6
# KERNEL: new size of array=8
# KERNEL: -----------
# KERNEL: array[0] = 0
# KERNEL: array[1] = 0
# KERNEL: array[2] = 0
# KERNEL: new size of array=3
# KERNEL: -----------
# KERNEL: new size of array=0
# KERNEL: -----------
*/
    
  
   
  
  
