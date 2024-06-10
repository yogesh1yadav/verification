// Problem 1: Generate Pulse of Variable Duration
// Generate a pulse of programmable duration. Pulse duration and pulse period is compile-time programmable (Use parameter).
// 1) Design Pass Criteria: Pulse duration should be same as expected.
// 2) Try with Different values of pulse duration and pulse period. Pulse duration < pulse period
// 3) If pulse duration > pulse period, then error should be displayed in log.

module pulse_generator (
    input logic clk,
    input logic reset,
    output logic pulse         
);
    parameter pulse_duration = 4;
    parameter pulse_period = 10;
  	
  	int counter;
    
    initial begin
        if (pulse_duration >= pulse_period) begin
          $display("error: pulse_duration %d is greater than or equal to pulse_period %d", pulse_duration, pulse_period);
          $stop;
        end
    end
    
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            pulse <= 0;
        end else begin
            if (counter < pulse_period - 1) 
                counter <= counter + 1;        
            else 
                counter <= 0;        
        
            if (counter < pulse_duration) 
                pulse <= 1;      
            else
                pulse <= 0;
        end
    end
endmodule


// testbench
module tb_pulse_generator;
  logic clk;
  logic reset;
  logic pulse;

  pulse_generator dut (
    .clk(clk),
    .reset(reset),
    .pulse(pulse)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Test sequence
  initial begin
    reset = 1; // Apply reset
    #20;
    reset = 0; // Release reset
    #150;
    reset = 1;
    #15;
    reset = 0;
    #100;
    $finish;
  end

  initial begin
    $monitor("At time %t: pulse = %b", $time, pulse);
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_pulse_generator);
  end
endmodule

