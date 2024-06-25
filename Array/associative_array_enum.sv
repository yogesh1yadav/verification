// elements of associative array can be of any data type, and index also can be of any type
// syntax: data_type array_name [ index_type ];


module associative_array_enum;
  typedef enum {red, blue, green} colours;											// create a user defined enum named as "colours" and use it as index_type of array.
  
  bit[6:0] array_enum [colours];					
  
  initial begin
    array_enum[blue]=15;										                   // in associative array need to assign value separately to each index, 
    array_enum[red]=10;                                        // bcz it is not stored in contiguous manner, and data space is sparse 
    array_enum[green]=20;

    $display("array_enum= %p",array_enum);                              //use %p to show array like this # KERNEL: array_enum= '{red:10, blue:15, green:20}
    
    foreach (array_enum[i])begin													         
      $display("array_enum[%0d] = %0d", i , array_enum[i]);                   // i simply print numbering of index in integer    
      $display("array_enum[%0s] = %0d", i.name() , array_enum[i]);					  // i.name() used to print the array index with enum string names  
      $display("--------------");
    end
  end
endmodule



/*OUTPUT
# KERNEL: array_enum='{red:10, blue:15, green:20}
# KERNEL: array_enum[0] = 10
# KERNEL: array_enum[red] = 10
# KERNEL: --------------
# KERNEL: array_enum[1] = 15
# KERNEL: array_enum[blue] = 15
# KERNEL: --------------
# KERNEL: array_enum[2] = 20
# KERNEL: array_enum[green] = 20
# KERNEL: --------------
*/
