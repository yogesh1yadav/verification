`timescale 1ns / 1ps

module tb_sync_fifo;
parameter depth = 8;
parameter width = 8;
parameter ptr_width = $clog2(depth);
    
reg     clk_i, rst_i, wr_en_i, rd_en_i;
reg     [width-1:0] wr_data_i;
wire    [width-1:0] rd_data_o;
wire    full_o, empty_o, wr_error_o, rd_error_o;
    
integer i;
    
// Instantiate the FIFO
sync_fifo dut(clk_i, rst_i, wr_en_i, rd_en_i, wr_data_i, rd_data_o, full_o, empty_o, wr_error_o, rd_error_o);
    
// Generate clock signal
initial begin
    clk_i=0;
    forever #10 clk_i=~clk_i;
end    
    
// Test procedure
initial begin
 // Initialize signals
    rst_i = 1;
    wr_en_i = 0;
    rd_en_i = 0;
    wr_data_i = 0;
    
    #20;
    rst_i = 0;
    
    
 // Write to FIFO till it gets full
    for (i = 0; i < depth; i = i + 1) begin
        @(posedge clk_i);
        begin
            wr_data_i = $random;                        // writing Random data
            wr_en_i = 1;
        end            
    end
    
    @(posedge clk_i);    
    wr_en_i = 0;      
    
    
 // Attempt to write when FIFO is full
    @(posedge clk_i);
    begin
        wr_data_i = $random;
        wr_en_i = 1;
    end
    
    @(posedge clk_i);       
    wr_en_i = 0;
    
    
 // Read from FIFO 5 stored data 
    for (i = 0; i < 5; i = i + 1) begin
        @(posedge clk_i);
        rd_en_i = 1;
    end
    
    @(posedge clk_i);
    rd_en_i = 0;
    
    
 // Attempt to write again after some reading to check full and empty conditions  
    for (i = 0; i < 4; i = i + 1) begin
        @(posedge clk_i);
        begin
            wr_data_i = $random;  
            wr_en_i = 1;
        end
    end    
        
    @(posedge clk_i);
    wr_en_i = 0;
      
            
 // Read from FIFO again         
    for (i = 0; i < depth; i = i + 1) begin
        @(posedge clk_i);
            rd_en_i = 1;
    end 
                
    @(posedge clk_i);
    rd_en_i = 0;
    
    
 // Attempt to read when FIFO is empty
    @(posedge clk_i);
    rd_en_i = 1;
    
    @(posedge clk_i);
    rd_en_i = 0;
    
 // Test reset
    @(posedge clk_i);
    rst_i = 1;
    
    #20;
    rst_i = 0;
    
    #30;
    $finish;
end
endmodule
