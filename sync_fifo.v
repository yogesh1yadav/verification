`timescale 1ns / 1ps

module sync_fifo (clk_i, rst_i, wr_en_i, rd_en_i, wr_data_i, rd_data_o, full_o, empty_o, wr_error_o, rd_error_o);
parameter depth=8, width=8;                   
parameter ptr_width = $clog2(depth);        

input clk_i, rst_i, wr_en_i, rd_en_i;               //wr_en_i       : write enable input               rd_en_i      : read enable input
input [width-1:0] wr_data_i;                        //wr_data_i     : write data input              
output reg [width-1:0] rd_data_o;                   //rd_data_o     : read data output
output reg full_o, empty_o, wr_error_o, rd_error_o;

reg [ptr_width-1:0] wr_ptr, rd_ptr;                 //wr_ptr        : write pointer                    rd_ptr       : read pointer
reg wr_toggle_f, rd_toggle_f;                       //wr_toggle_f   : write toggle flag                rd_toggle_f  : read toggle flag

reg [width-1:0] mem [depth-1:0];                    //declare memory

integer i;

always @ (posedge clk_i) begin      
    if (rst_i) begin                                // reset signal enable
        rd_data_o=0;                                // all reg variable assign to reset value 0
        full_o=0;
        empty_o=0;
        wr_error_o=0; 
        rd_error_o=0;
        wr_ptr=0;
        rd_ptr=0;
        wr_toggle_f=0; 
        rd_toggle_f=0;
        
        for (i=0;i<depth;i=i+1) begin
            mem[i]=0;                               // reset full memory  
        end
    end
    
    
// WRITE OPERATION  
    else begin                                      // reset signal disable
        if (wr_en_i==1) begin                        
            if(full_o==1) begin                     // checking for full condition to perform write operation
                wr_error_o=1;
            end
            else begin
                wr_error_o=0;
                mem[wr_ptr]=wr_data_i;              // store or write data into FIFO
                if (wr_ptr==depth-1) begin
                    wr_ptr=0;
                    wr_toggle_f=~wr_toggle_f;
                end
                else begin
                    wr_ptr=wr_ptr+1;
                end
            end
        end
        else begin 
            wr_error_o=0;                           // Clear write error if not writing
        end
        
        
// READ OPERATION     
        if (rd_en_i==1) begin                                         
            if(empty_o==1) begin                    // checking for empty condition to perform read operation
                rd_error_o=1;
            end
            else begin
                rd_error_o=0;
                rd_data_o=mem[rd_ptr];
                if (rd_ptr==depth-1) begin          // collect or read data from FIFO
                    rd_ptr=0;
                    rd_toggle_f=~rd_toggle_f;
                end
                else begin
                    rd_ptr=rd_ptr+1;
                end
            end    
        end
        else begin
            rd_error_o = 0;                         // Clear read error if not reading
        end  
    end
end
   
   
//FULL OR EMPTY SIGNAL GENERATION    
always@(*) begin                                    
    empty_o=0;
    full_o=0;
    if (wr_ptr==rd_ptr) begin
        if (wr_toggle_f==rd_toggle_f) begin
            empty_o=1;
        end
        if (wr_toggle_f!=rd_toggle_f) begin
            full_o=1;
        end
    end
end
endmodule



                
                
     
    




