module associative_array;
  int array [int];
  int index;
  
  initial begin
    array[5]=1;                                                    //need to asssign element value individually, as indexing is not continuous
    array[10]=2;
    array[6]=3;
    array[20]=4;
    array[18]=5;
    
    $display("array = %p",array);								                   // can use %p directly for array # KERNEL: array = '{5:1, 6:3, 10:2, 18:5, 20:4}
    foreach(array[i])
      $display("array[%0d] = %0d", i , array[i]);                  //arrange automatically according to the indexing from starting location in ascending index value
	
    $display("size of array is: %0d", array.size());					
    $display("number of entries of array is: %0d", array.num());
    $display("-------------------");
    
    if(array.exists(6))											                     	// array_name.exists(index);              remember it is exists not exist
      $display("element exist at index 6");
    else $display(" element not exist at index 6");
    $display("-------------------");
    
    array.first(index);                                           
    $display("first index of array=%0d", index);
    
    array.last(index);
    $display("last index of array=%0d", index);
    
    array.prev(index);
    $display("prev index of array=%0d", index);
    
    array.next(index);
    $display("next index of array=%0d", index);
    $display("-------------------");
    
    array.delete(18);
    $display("array = %p",array);                                                    //# KERNEL: array = '{5:1, 6:3, 10:2, 20:4}
    $display("size of array is: %0d", array.size());
    $display("number of entries of array is: %0d", array.num());
    $display("-------------------");
    
    array.delete();
    $display("array = %p",array);                                                    //# KERNEL: array = '{}
    $display("size of array is: %0d", array.size());
    $display("number of entries of array is: %0d", array.num());
    $display("-------------------");
      
  end
endmodule


/*OUTPUT:
# KERNEL: array = '{5:1, 6:3, 10:2, 18:5, 20:4}
# KERNEL: array[5] = 1
# KERNEL: array[6] = 3
# KERNEL: array[10] = 2
# KERNEL: array[18] = 5
# KERNEL: array[20] = 4
# KERNEL: size of array is: 5
# KERNEL: number of entries of array is: 5
# KERNEL: -------------------
# KERNEL: element exist at index 6
# KERNEL: -------------------
# KERNEL: first index of array=5
# KERNEL: last index of array=20
# KERNEL: prev index of array=18
# KERNEL: next index of array=20
# KERNEL: -------------------
# KERNEL: array = '{5:1, 6:3, 10:2, 20:4}
# KERNEL: size of array is: 4
# KERNEL: number of entries of array is: 4
# KERNEL: -------------------
# KERNEL: array = '{}
# KERNEL: size of array is: 0
# KERNEL: number of entries of array is: 0
# KERNEL: -------------------
*/
    
