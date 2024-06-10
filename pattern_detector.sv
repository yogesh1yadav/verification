// Problem 3: Write a state machine to detect a pattern of "PRESENT MONTH and DATE".

// 1) Take the present date (LSB 5-bit) and month (MSB 4-bit) as a pattern and convert it into binary number, For example, Today is 23rd Nov (23/11), So our Pattern is 11(4'b1011)_ 23(5'b10111) -> 9'b1011_10111

// 2) Data generator should generate a 10-bit incremental pattern. This 10-bit parallel data should be converted into serial data.

// 3) The one-bit data is received by detector block. So Incremental data should be updated in every 10 clock cycles.

// 4) Detector block detects the output pulse every time when it detects the required pattern
module patterndetector(
    input logic clk,
    input logic reset,
    output logic match
);
  parameter [8:0] PATTERN = 9'b0110_01001; // example pattern for june 9th
    logic [9:0] pattern;
    logic [3:0] bit_counter;
    logic serial_out;
    logic [8:0] pattern_reg;

    // Data Generator Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern <= 10'b0;
            bit_counter <= 4'b0;
        end else begin
          if (bit_counter == 9) begin		
                bit_counter <= 0;
                pattern <= pattern + 1;
            end else begin
                bit_counter <= bit_counter + 1;
            end
        end
    end

    assign serial_out = pattern[bit_counter];

    // Detector Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_reg <= 9'b0;
            match <= 0;
        end else begin
          pattern_reg <= {pattern_reg[7:0], serial_out};
          if (pattern_reg == PATTERN) begin
                match <= 1;
            end else begin
                match <= 0;
            end
        end
    end
endmodule

// Testbench
module tb_patterndetector;
    logic clk;
    logic reset;
    logic match;

    // Instantiate the Pattern Detector
    patterndetector dut (
        .clk(clk),
        .reset(reset),
        .match(match)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        reset = 1; // Apply reset
        #20;
        reset = 0; // Release reset
        #1000;
        $finish;
    end

    initial begin
        $monitor("At time %t: match = %b", $time, match);
    end

    initial begin
        $dumpfile("waveform.vcd");
      $dumpvars(0, tb_patterndetector);
    end
endmodule
