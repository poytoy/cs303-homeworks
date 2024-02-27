module hockey_tb();


parameter HP = 5;       // Half period of our clock signal
parameter FP = (2*HP);  // Full period of our clock signal

reg clk, rst, BTN_A, BTN_B;
reg [1:0] DIR_A;
reg [1:0] DIR_B;
reg [2:0] Y_in_A;
reg [2:0] Y_in_B;

wire [2:0] X_COORD, Y_COORD;
wire [6:0] SSD5, SSD4, SSD2, SSD0;
wire LD0, LD5, LD6, LD7, LD8, LD9, LD15;

// Our design-under-test is the DigiHockey module
hockey dut(
    .clk(clk),
    .rst(rst),
    .BTN_A(BTN_A),
    .BTN_B(BTN_B),
    .DIR_A(DIR_A),
    .DIR_B(DIR_B),
    .Y_in_A(Y_in_A),
    .Y_in_B(Y_in_B),
    .SSD5(SSD5),
    .SSD4(SSD4),
    .SSD2(SSD2),
    .SSD0(SSD0),
    .X_COORD(X_COORD),
    .Y_COORD(Y_COORD),
    .LD0(LD0),
    .LD5(LD5),
    .LD6(LD6),
    .LD7(LD7),
    .LD8(LD8),
    .LD9(LD9),
    .LD15(LD15)
);

// This always statement automatically cycles between clock high and clock low in HP (Half Period) time. Makes writing test-benches easier.
always #HP clk = ~clk;

initial begin
    
	$dumpfile("hockey.vcd"); //  * Our waveform is saved under this file.
    $dumpvars(0,hockey_tb); // * Get the variables from the module.
    
    $display("Simulation started.");

    clk = 0; 
    rst = 0;
    BTN_A = 0;
	BTN_B = 0;
	DIR_A = 0;
	DIR_B = 0;
    Y_in_A = 0;
    Y_in_B = 0;
    
	#FP;
	rst=1;
	#FP;
	rst=0;
	
	// Here, you are asked to write your test scenario.



	//My test sceniro is A's victory. Score will be A-B : 3-2. Also between the score 1-1 and 2-1 that round is pretty competetive. 
	
	#FP
	BTN_A = 1;

	#FP
    BTN_A = 0;
	DIR_A = 0 ; //straight shot.
	Y_in_A = 0;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	// B's turn

	#FP
	DIR_B = 0;
	Y_in_B = 2; //false prediction.
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);
	
	//SCORE A-B : 1-0
	// B again, because they lost. initial shot.

	#FP
	DIR_B = 1; //upward shot.
	Y_in_B = 1;
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);
	

	// A's turn

	#FP
	DIR_A = 2; //down
	Y_in_A = 3;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	// B's turn

	#FP
	DIR_B = 0; //straight
	Y_in_B = 1; 
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);


		
	// A's turn

	#FP
	DIR_A = 2; //downward
	Y_in_A = 3; // false prediction.
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	// Score A-B : 1-1
	// A AGAIN initial shot


    #FP
	DIR_A = 2; //down
	Y_in_A = 4;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);
	
	//B's turn

	#FP
	DIR_B = 0; //straight
	Y_in_B = 0; 
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);

	//A's turn

	#FP
	DIR_A = 1; //up
	Y_in_A = 0;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	//B's turn

	#FP
	DIR_B = 2; //down
	Y_in_B = 4; 
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);
	
	//A's turn

	#FP
	DIR_A = 0; //straight
	Y_in_A = 0;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	//B's turn

	#FP
	DIR_B = 1; //upward
	Y_in_B = 3; //false prediction
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);

	//New score A-B : 2-1

	//B's turn again

	#FP
	DIR_B = 1; //upward
	Y_in_B = 2; 
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);


	//A's turn.

	#FP
	DIR_A = 0; //straight
	Y_in_A = 2;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	//B's turn.

	#FP
	DIR_B = 2; //downward
	Y_in_B = 2; 
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);

	//A's turn. 

	#FP
	DIR_A = 1; //up
	Y_in_A = 4; // false prediction.
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	// New score A-B : 2-2

	//A turn's again because they lost this round. 

	#FP
	DIR_A = 0; //straight
	Y_in_A = 3;
	BTN_A = 1;
	#FP
	BTN_A = 0;
	#(FP * 200);

	//B turn's.

	#FP
	DIR_B = 1; //up
	Y_in_B = 4 ; //false prediction.
	BTN_B = 1;
	#FP
	BTN_B = 0;
	#(FP * 200);

	// New score A-B : 3-2
	// A WON THE GAME !!!



	$display("Simulation finished.");
    $finish(); // Finish simulation.
end



endmodule