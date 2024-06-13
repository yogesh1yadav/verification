`timescale 1ns / 1ps
interface fifo_if #(parameter depth=8, width=8, ptr_width = $clog2(depth))(input clk_i);
//	parameter depth=8, width=8;                   
//	parameter ptr_width = $clog2(depth);        

	logic rst_i,wr_en_i, rd_en_i;              
	logic [width-1:0] wr_data_i;                                    
	logic [width-1:0] rd_data_o;                   
	logic full_o, empty_o, wr_error_o, rd_error_o;

//	logic [ptr_width-1:0] wr_ptr, rd_ptr;                 
//	logic wr_toggle_f, rd_toggle_f;        
    
  	modport master (input rst_i, wr_en_i, rd_en_i, output full_o, empty_o, wr_error_o, rd_error_o, rd_data_o);

    modport slave (output rst_i, wr_en_i, rd_en_i, input full_o, empty_o, wr_error_o, rd_error_o, rd_data_o);

endinterface

module sync_fifo (fifo_if ifc);
    parameter depth=8, width=8;
    parameter ptr_width = $clog2(depth);

    // Declare memory
    logic [width-1:0] mem [depth-1:0];

    integer i;
    bit [width-1:0] expected_data [depth-1:0];

    logic [ptr_width-1:0] wr_ptr, rd_ptr;
    logic wr_toggle_f, rd_toggle_f;

    always_ff @ (posedge ifc.clk_i) begin
        if (ifc.rst_i) begin
            // Reset all signals and memory
            wr_ptr <= 0;
            rd_ptr <= 0;
            wr_toggle_f <= 0;
            rd_toggle_f <= 0;
            ifc.wr_error_o <= 0;
            ifc.rd_error_o <= 0;
            ifc.full_o <= 0;
            ifc.empty_o <= 1;
            for (i = 0; i < depth; i = i + 1) begin
                mem[i] <= 0;
                expected_data[i] <= 0;
            end
        end else begin
            // WRITE OPERATION  
            if (ifc.wr_en_i && !ifc.full_o) begin
                mem[wr_ptr] <= ifc.wr_data_i;  // Store data into FIFO
                expected_data[wr_ptr] <= ifc.wr_data_i; // Store expected data
                if (wr_ptr == depth-1) begin
                    wr_ptr <= 0;
                    wr_toggle_f <= ~wr_toggle_f;
                end else begin
                    wr_ptr <= wr_ptr + 1;
                end
            end else if (ifc.wr_en_i && ifc.full_o) begin
                ifc.wr_error_o <= 1;
            end else begin
                ifc.wr_error_o <= 0;
            end

            // READ OPERATION     
            if (ifc.rd_en_i && !ifc.empty_o) begin
                ifc.rd_data_o <= mem[rd_ptr];  // Read data from FIFO
                if (rd_ptr == depth-1) begin
                    rd_ptr <= 0;
                    rd_toggle_f <= ~rd_toggle_f;
                end else begin
                    rd_ptr <= rd_ptr + 1;
                end
            end else if (ifc.rd_en_i && ifc.empty_o) begin
                ifc.rd_error_o <= 1;
            end else begin
                ifc.rd_error_o <= 0;
            end
        end
    end
   
    // FULL OR EMPTY SIGNAL GENERATION    
    always_comb begin
        ifc.empty_o = (wr_ptr == rd_ptr) && (wr_toggle_f == rd_toggle_f);
        ifc.full_o = (wr_ptr == rd_ptr) && (wr_toggle_f != rd_toggle_f);
    end
endmodule






//testbench

module tb_sync_fifo;

    parameter depth = 8;
    parameter width = 8;
    parameter ptr_width = $clog2(depth);
    logic clk_i;
    
    fifo_if #(depth, width,ptr_width) ifc(clk_i);

    sync_fifo #(depth, width,ptr_width) dut (.ifc(ifc));
    int i;
    // Clock generation
    initial begin
        ifc.clk_i = 0;
        forever #5 ifc.clk_i = ~ifc.clk_i;
    end

 // Test procedure
   initial begin
       // Initialize signals
       ifc.rst_i = 1;
       ifc.wr_en_i = 0;
       ifc.rd_en_i = 0;
       ifc.wr_data_i = 0;
       
       #20;
       ifc.rst_i = 0;
       
       // Write to FIFO till it gets full
       for (i = 0; i < depth; i = i + 1) begin
           @(posedge ifc.clk_i);
           begin
               ifc.wr_data_i = $random; // writing Random data
               ifc.wr_en_i = 1;
           end            
       end
       
       @(posedge ifc.clk_i);    
       ifc.wr_en_i = 0;      
       
       // Attempt to write when FIFO is full
       @(posedge ifc.clk_i);
       begin
           ifc.wr_data_i = $random;
           ifc.wr_en_i = 1;
       end
       
       @(posedge ifc.clk_i);       
       ifc.wr_en_i = 0;
       
       // Read from FIFO 5 stored data 
       for (i = 0; i < 5; i = i + 1) begin
           @(posedge ifc.clk_i);
           ifc.rd_en_i = 1;
       end
       
       @(posedge ifc.clk_i);
       ifc.rd_en_i = 0;
       
       // Attempt to write again after some reading to check full and empty conditions  
       for (i = 0; i < 4; i = i + 1) begin
           @(posedge ifc.clk_i);
           begin
               ifc.wr_data_i = $random;  
               ifc.wr_en_i = 1;
           end
       end    
           
       @(posedge ifc.clk_i);
       ifc.wr_en_i = 0;
             
       // Read from FIFO again         
       for (i = 0; i < depth; i = i + 1) begin
           @(posedge ifc.clk_i);
           ifc.rd_en_i = 1;
       end 
                   
       @(posedge ifc.clk_i);
       ifc.rd_en_i = 0;
       
       // Attempt to read when FIFO is empty
       @(posedge ifc.clk_i);
       ifc.rd_en_i = 1;
       
       @(posedge ifc.clk_i);
       ifc.rd_en_i = 0;
       
       // Test reset
       @(posedge ifc.clk_i);
       ifc.rst_i = 1;
       
       #20;
       ifc.rst_i = 0;
       
       #30;
       $finish;

        // Verify written data
        for (int i = 0; i < depth; i++) begin
            if (ifc.rd_data_o != dut.expected_data[i]) begin
                $display("Data mismatch at address %d. Expected: %h, Actual: %h", i, dut.expected_data[i], ifc.rd_data_o);
                $finish;
            end
        end

        $display("All test cases passed.");
        $finish;
    end

endmodule
