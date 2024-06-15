virtual class transaction;
  bit[6:0] header;
  bit[8:0] payload;
  bit parity;
    
  virtual function void print_packets();
  endfunction
  virtual function void display_payload();
  endfunction
  virtual function bit calculate_parity();
    return 0;
  endfunction
  virtual function void display_parity();
  endfunction
    
endclass

    
class large_packet extends transaction;
  
  function new (bit[6:0] header, bit[8:0] payload);    
    this.header = header;
    this.payload = payload;
    this.parity = calculate_parity();    
  endfunction
  
  function void print_packets();
    $display("large_packet : header = %0h, payload = %0h, parity = %b", this.header, this.payload, this.parity);  
  endfunction
   
  function void display_payload();  	
    $display("large_packet_payload = %0h", this.payload);    
  endfunction;
   
  function bit calculate_parity();
        return ^ this.payload;    
  endfunction

  function void display_parity();
    $display("large_packet_parity = %b", this.parity);
  endfunction
  
endclass: large_packet

    
class small_packet extends transaction;
  
  function new (bit[6:0] header, bit[8:0] payload);    
    this.header = header;
    this.payload = payload;
    this.parity = calculate_parity();    
  endfunction
  
  function void print_packets();    
    $display("small_packet : header = %0h, payload = %0h, parity = %b", this.header, this.payload, this.parity);    
  endfunction
  
  function void display_parity();    
    $display("small_packet_parity = %b", this.parity);    
  endfunction
  
  function void display_payload();   
    $display("small_packet_payload = %0h", this.payload);    
  endfunction
  
  function bit calculate_parity();    
    return ^this.payload;    
  endfunction
  
endclass: small_packet

    
class corrupted_packet extends transaction;
  
  function new (bit[6:0] header, bit[8:0] payload);    
    this.header = header;
    this.payload = payload;
    this.parity = calculate_parity();    
  endfunction
    
  function void print_packets();    
    $display("corrupted_packet: header=%0h, payload=%0h, parity=%b", this.header, this.payload, this.parity);    
  endfunction
  
  function void display_payload();    
    $display("corrupted_packet_payload = %0h ", this.payload);    
  endfunction
  
  function bit calculate_parity();    
    return ^this.payload;    
  endfunction
  
  function void display_parity();    
    $display("corrupted_packet_parity = %b",this.parity);    
  endfunction
  
endclass: corrupted_packet

//testbench

module transaction_tb();
  function void send_packet(transaction t1);
    t1.print_packets();
    t1.display_payload();
    t1.display_parity();
  endfunction
  
  large_packet l=new(6'b011011,8'b11001011);
  small_packet s=new(6'b011101,8'b11010111);
  corrupted_packet c=new(6'b010011,8'b11000111);
  
  initial begin
    
    send_packet(l);
    send_packet(s);
    send_packet(c);
    
    $stop;
    
  end
endmodule
