module tb;

    reg clk;
    reg reset;

    wire [2:0] lightA;
    wire [2:0] lightB;

    // Instantiate DUT
    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .lightA(lightA),
        .lightB(lightB)
    );

    // Clock generation (10 time units period)
    always #5 clk = ~clk;

    initial begin
        // Generate VCD file for EPWave
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply reset
        #20;
        reset = 0;

        // Run simulation
        #250;

        $finish;
    end

    // Display output changes
    initial begin
        $monitor("Time=%0t | Reset=%b | LightA=%b | LightB=%b",
                  $time, reset, lightA, lightB);
    end

endmodule
