/*module up_down_counter_x(
    input clk,
    input reset,
    output [2:0] counter

);

reg [2:0] counter_up_down;
reg increment;  // New variable to determine direction

// down counter
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter_up_down <= 3'h0;
        increment <= 1'b1;  // Initialize to increment
    end else begin
        if (counter_up_down < 3'h4) begin
            if (increment)
                counter_up_down <= counter_up_down + 3'd1;
            else
                counter_up_down <= counter_up_down - 3'd1;
        end
        // Change direction when reaching 4 or 0
        if (counter_up_down == 3'h4 || counter_up_down == 3'h0)
            increment <= ~increment;
    end 
end

assign counter = counter_up_down;

endmodule

module up_down_counter_y(
    input clk,
    input [2:0] INIT_Y_POS,
    input reset,
    input [1:0] DIRECTION,
    output  [2:0] counter
);

reg [3:0] counter_up_down;
reg increment;

// down counter
always @(posedge clk or posedge reset) begin
    counter_up_down = INIT_Y_POS;
    if (reset) begin
        counter_up_down <= 3'h0;
        if (DIRECTION == 2'b01)
            increment <= 1'b1;  // Initialize to increment
        else if (DIRECTION == 2'b10)
            increment <= 1'b0;  // Initialize to decrement
    end
    if (DIRECTION != 2'b00) begin
        if (counter_up_down < 3'h4) begin
            if (increment)
                counter_up_down <= counter_up_down + 3'd1;
            else
                counter_up_down <= counter_up_down - 3'd1;
        end
        // Change direction when reaching 4 or 0
        if (counter_up_down == 3'h4 || counter_up_down == 3'h0)
            increment <= ~increment;
    end
end

assign counter = counter_up_down;

endmodule
module DigiHockey(
    input clk,
    input rst,
    input START,
    input [1:0] DIRECTION,
    input [2:0] INIT_Y_POS,
    output [2:0] X_COORD,
    output [2:0] Y_COORD
);
reg [2:0]X_c;
reg [2:0]Y_c;
req started;
reg increment_x;
reg increment_y;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset logic here
        X_c <= 3'h0;
        Y_c <= 3'h0;
        increment_x <= 1'b1;
        started <= 0;
    end else if (START) begin
        // Initialize counters when START is asserted
        X_c <= 3'h0;
        Y_c <= INIT_Y_POS;
        started <= 1;
    end else if (started) begin 
            if (X_c < 3'h4) begin
                if (increment_x)begin
                    X_c <= X_c + 3'd1;
                else
                    x_c <= X_c - 3'd1;
            end
            // Change direction when reaching 4 or 0
            if (X_c == 3'h4 || X_c == 3'h0)
                increment_x <= ~increment_X;
    end 
    if (DIRECTION == 2'b01) 
        increment_y <= 1'b1;  // Initialize to increment
    else if (DIRECTION == 2'b10)
        increment_y <= 1'b0;  // Initialize to decrement

    if (DIRECTION != 2'b00 && Y_c < 3'h4) begin
            if (increment_y)
                Y_c <= Y_c + 3'd1;
            else
                Y_c <= Y_c - 3'd1;
        end
        // Change direction when reaching 4 or 0
        if (Y_c == 3'h4 || Y_c == 3'h0)
            increment_y <= ~increment_y;
        
    end

        

assign X_COORD = X_c;
assign Y_COORD = Y_c;

endmodule

module DigiHockey(
    input clk,
    input rst,
    input START,
    input [1:0] DIRECTION,
    input [2:0] INIT_Y_POS,
    output reg [2:0] X_COORD,
    output reg [2:0] Y_COORD
);

    reg started;
    reg increment_x;
    reg increment_y;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic here
            X_COORD <= 3'h0;
            Y_COORD <= 3'h0;
            increment_x <= 1'b1;
            started <= 0;
        end else if (START && started!=1) begin
            // Initialize counters when START is asserted
            X_COORD <= 3'h0;
            Y_COORD <= INIT_Y_POS;
            started <= 1;
        end if (started) begin 
            if (X_COORD <= 3'h3 && X_COORD >= 3'h1) begin
                if (increment_x)
                    X_COORD <= X_COORD + 3'b001;
                else
                    X_COORD <= X_COORD - 3'b001;
    
                if (X_COORD == 3'h3 || X_COORD == 3'h1)
                    increment_x <= ~increment_x;
            end
            
        end

        if (DIRECTION == 2'b01) 
            increment_y <= 1'b1;  // Initialize to increment
        else if (DIRECTION == 2'b10)
            increment_y <= 1'b0;  // Initialize to decrement

        if (DIRECTION != 2'b00 && Y_COORD < 3'h4) begin
            if (increment_y)
                Y_COORD <= Y_COORD + 3'd1;
            else
                Y_COORD <= Y_COORD - 3'd1;
        end
        // Change direction when reaching 4 or 0
        if (Y_COORD == 3'h4 || Y_COORD == 3'h0)
            increment_y <= ~increment_y;
    end
    // Continuous assignments for X_COORD and Y_COORD

endmodule

module DigiHockey(
    input clk,
    input rst,
    input START,
    input [1:0] DIRECTION,
    input [2:0] INIT_Y_POS,
    output reg [2:0] X_COORD,
    output reg [2:0] Y_COORD
);

    reg started;
    reg increment_x;
    reg increment_y;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic here
            X_COORD <= 3'h0;
            Y_COORD <= 3'h0;
            increment_x <= 1'b1;
            started <= 0;end
        else if (!started && START) begin  // Fixed condition
            // Initialize counters when START is asserted
            X_COORD <= 3'h0;
            Y_COORD <= INIT_Y_POS;
            started <= 1;
        end

        if (started) begin 
            if (X_COORD == 3'h1) // Adjusted condition
                increment_x <= 1;

            if (increment_x)
                X_COORD <= X_COORD + 3'b001;

            else
                X_COORD <= X_COORD - 3'b001;

            if(X_COORD == 3'h3)
                increment_x<=0;
            
        end

        if (DIRECTION == 2'b01) begin
            increment_y <= 1'b1;end

        
        
        // Additional conditions to control increment_y
        

        else if (Y_COORD == 3'h0) begin 
            increment_y <= 1'b1;
        end 
        
        if (DIRECTION != 2'b00) begin
            if (increment_y)
                Y_COORD <= Y_COORD + 3'd1;
            else
                Y_COORD <= Y_COORD - 3'd1;
        end
        if (Y_COORD == 3'h4) begin
            increment_y <= 0;  // Set increment_y to 0 when reaching 3'h4
        end 
    else if (DIRECTION == 2'b10) begin
        increment_y <= 1'b0;
    end
        
    end        
    // Continuous assignments for X_COORD and Y_COORD

endmodule
*/
module DigiHockey(
    input clk,
    input rst,
    input START,
    input [1:0] DIRECTION,
    input [2:0] INIT_Y_POS,
    output reg [2:0] X_COORD,
    output reg [2:0] Y_COORD
);

    reg started;
    reg increment_x;
    reg increment_y;
    reg y_set;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic here
            X_COORD <= 3'h0;
            Y_COORD <= 3'h0;
            increment_x <= 1'b1;
            started <= 0;
        end
        else if (!started && START) begin  // Fixed condition
            // Initialize counters when START is asserted
            X_COORD <= 3'h0;
            Y_COORD <= 3'h0;
            started <= 1;
            increment_y <= DIRECTION;
            y_set<=0;
        end
        else if(!y_set)begin 
            Y_COORD <= INIT_Y_POS;
            y_set<=1;
        end

        if (started&&y_set) begin 
            
            if (X_COORD == 3'h1) // Adjusted condition
                increment_x <= 1;

            if (increment_x)
                X_COORD <= X_COORD + 3'b001;

            else
                X_COORD <= X_COORD - 3'b001;

            if(X_COORD == 3'h3)
                increment_x<=0;
            
            if(increment_y == DIRECTION)begin
                if (DIRECTION == 2'b10) begin
                    increment_y <= 2'b10;
                end
                if (DIRECTION == 2'b01)begin 
                    increment_y<= 2'b01;
                end
                if (Y_COORD == 3'h1) begin 
                    increment_y <= 2'b01;
                end 
                if (Y_COORD == 3'h3) begin
                    increment_y <= 2'b10;  // Set increment_y to 0 when reaching 3'h4
                end 
            end
            if(increment_y != DIRECTION)begin
                if (Y_COORD == 3'h1) begin 
                    increment_y <= 2'b01;
                end 
                if (Y_COORD == 3'h3) begin
                    increment_y <= 2'b10;  // Set increment_y to 0 when reaching 3'h4
                end 
            end
            if (DIRECTION != 2'b00) begin
                if (increment_y==2'b01)
                    Y_COORD <= Y_COORD + 3'd1;
                else
                    Y_COORD <= Y_COORD - 3'd1;
            end
       
                
            
        end
    end
    // Continuous assignments for X_COORD and Y_COORD

endmodule