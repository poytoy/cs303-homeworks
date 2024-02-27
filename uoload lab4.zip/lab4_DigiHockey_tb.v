module DigiHockey_tb();


// Do not worry too much about these parameter statements, they are here to ease your work
parameter HP = 5;       // Half period of our clock signal
parameter FP = (2*HP);  // Full period of our clock signal

reg clk, rst, START;
reg [1:0] DIRECTION;
reg [2:0] INIT_Y_POS;

wire [2:0] X_COORD, Y_COORD;

// Our design-under-test is the DigiHockey module
DigiHockey dut(clk, rst, START, DIRECTION, INIT_Y_POS, X_COORD, Y_COORD);

// This always statement automatically cycles between clock high and clock low in HP (Half Period) time. Makes writing test-benches easier.
always #HP clk = ~clk;

initial begin
    $dumpfile("DigiHockey.vcd"); //  * Our waveform is saved under this file.
    $dumpvars(0,DigiHockey_tb); // * Get the variables from the module.
    
    $display("Simulation started.");

    // * Initialize the testbench variables
    clk = 0; // Set clock low (we won't have to write clk = 1 again, thanks to those parameter and always statements we gave you)
    rst = 0;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;
    #10
   

    clk = 0;
    rst = 1;
    START = 0;
    DIRECTION = 2'b01;
    INIT_Y_POS = 3'h2;
  
   

    // Apply reset
    #10 rst = 0;

    // Apply START signal
    #10 START = 1;
    #60

    clk = 0;
    rst = 1;
    START = 0;
    DIRECTION = 2'b10;
    INIT_Y_POS = 3'h4;

   

    // Apply reset
    #10 rst = 0;

    // Apply START signal
    #10 START = 1;
    #80
    clk = 0;
    rst = 1;
    START = 0;
    DIRECTION = 2'b00;
    INIT_Y_POS = 3'h0;

     // Apply reset
    #10 rst = 0;

    // Apply START signal
    #10 START = 1;
    #150;
    $finish;


	
	// Here, you are asked to write your test scenario.
	// The test scenario must cover all possible cases (moving directions and bouncings)
	
	
	
	
    $display("Simulation finished.");
    $finish(); // Finish simulation.
end



endmodule