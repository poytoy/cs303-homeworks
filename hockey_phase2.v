module hockey(

    input clk,
    input rst,
    
    input BTN_A,
    input BTN_B,
    
    input [1:0] DIR_A,
    input [1:0] DIR_B,
    
    input [2:0] Y_in_A,
    input [2:0] Y_in_B,
   
    /*output reg LEDA,
    output reg LEDB,
    output reg [4:0] LEDX,
    
    output reg [6:0] SSD7,
    output reg [6:0] SSD6,
    output reg [6:0] SSD5,
    output reg [6:0] SSD4, 
    output reg [6:0] SSD3,
    output reg [6:0] SSD2,
    output reg [6:0] SSD1,
    output reg [6:0] SSD0   */
	
	output reg [2:0] X_COORD,
	output reg [2:0] Y_COORD


  
  

    );

    parameter [3:0] IDLE = 0;
    parameter [3:0] DISP = 1;
    parameter [3:0] HIT_A = 2;
    parameter [3:0] HIT_B = 3;
    parameter [3:0] SEND_A = 4;
    parameter [3:0] SEND_B = 5; 
    parameter [3:0] RESP_A = 6;
    parameter [3:0] RESP_B = 7;
    parameter [3:0] GOAL_A = 8;
    parameter [3:0] GOAL_B = 9;
    parameter [3:0] END_state = 10;


    
    reg Turn;
    reg [1:0] Timer;
    reg [1:0] direction_Y;
    reg [1:0] Score_A;
    reg [1:0] Score_B;


    reg [3:0] State; 

    
    
    
    
    


    always @(posedge clk or posedge rst) //comb. part for state transitions
    begin

        if(rst) begin
            State <= IDLE;
            
            Timer <= 0;
            
            
            Score_A <= 0;
            Score_B <= 0;
            X_COORD <= 0;
            Y_COORD <= 0;


            
        end



        else begin
            
        
        case(State)
        IDLE:
        begin

        if(BTN_A  == 1)
        begin
            Turn<= 0;
            State <= DISP; 
        end

        else if(BTN_B == 1)begin
            Turn<= 1;  
            State <= DISP; 
        end

        else begin
            State <=IDLE ;
        end
        end


        DISP:
        begin
            if(Timer < 2) begin
                Timer <= Timer + 1;
                State <= DISP; 
            end

            else begin
                Timer <= 0 ;

                if(Turn == 1)begin
                    State <= HIT_B; 
                end

                else begin
                    State <= HIT_A; 
                end

            end

        end


        HIT_B: begin

        if(BTN_B == 1 && (Y_in_B <5)) begin
            X_COORD <= 4;
            Y_COORD <= Y_in_B;
            direction_Y <= DIR_B;
            State <= SEND_A; 
            
        end

        else begin
            State <= HIT_B; 
        end
        end

        HIT_A: begin

        if(BTN_A == 1 && (Y_in_A < 5)) begin
            X_COORD <= 0;
            Y_COORD <= Y_in_A;
            direction_Y <= DIR_A;
            State <= SEND_B; 

        end

        else begin
            State <= HIT_A; 
        end
        end

        SEND_A:  begin
            if(Timer < 2)begin
                Timer <= Timer + 1;
            end

            else begin
               Timer <= 0;

               if(direction_Y == 0) begin // straight direction
                if(X_COORD > 1)begin
                    X_COORD <= X_COORD -1;
                    State <= SEND_A;
                end

                else begin
                    X_COORD <= 0;
                    State <= RESP_A; 
                end
               end


               if(direction_Y == 2'b01)begin // up direction
                 if(Y_COORD == 4)begin
                    direction_Y <= 2'b10;
                    Y_COORD <= Y_COORD - 1;    
                    if(X_COORD > 1)begin
                        X_COORD <= X_COORD -1;
                        State <= SEND_A;  
                    end
                    else begin
                        X_COORD <= 0;
                        State <= RESP_A; 
                    end
                end

                else begin
                    Y_COORD <= Y_COORD + 1;
                    if(X_COORD > 1)begin
                        X_COORD <= X_COORD -1;
                        State <= SEND_A  ;    
                    end
                    else begin
                        X_COORD <= 0;
                        State <= RESP_A; 
                    end
                end
               end

               if(direction_Y == 2'b10)begin
                   if(Y_COORD == 0)begin
                    direction_Y <= 2'b01;
                    Y_COORD <= Y_COORD + 1; 

                    if(X_COORD > 1)begin
                        X_COORD <= X_COORD -1;
                        State <= SEND_A   ;   
                    end
                    else begin
                        X_COORD <= 0;
                        State <= RESP_A; 
                    end

                   end

                   else begin
                    Y_COORD <= Y_COORD - 1; 

                    if(X_COORD > 1)begin
                        X_COORD <= X_COORD -1;
                        State <= SEND_A  ;    
                    end
                    else begin
                        X_COORD <= 0;
                        State <= RESP_A; 
                    end
                   end



                end

            end

        end
      
        SEND_B: begin
            
            if(Timer < 2) begin
                Timer <= Timer + 1;
                State <= SEND_B;
            end

            else begin
                Timer <= 0;

                if(direction_Y == 2'b00) begin // straight
                    if(X_COORD < 3)begin
                        X_COORD <= X_COORD + 1;
                        State <= SEND_B;
                    end

                    else begin
                        X_COORD <= 4;
                        State <= RESP_B;
                    end
                end

                else if(direction_Y == 2'b01)begin
                    if(Y_COORD == 4)begin
                        direction_Y <= 2'b10;
                        Y_COORD <= Y_COORD - 1;
                         
                        if(X_COORD < 3)begin
                            X_COORD <= X_COORD + 1;
                            State <= SEND_B;
                        end
    
                        else begin
                            X_COORD <= 4;
                            State <= RESP_B;
                        end


                    end

                    else begin
                        Y_COORD <= Y_COORD + 1;

                        if(X_COORD < 3)begin
                            X_COORD <= X_COORD + 1;
                            State <= SEND_B;
                        end
    
                        else begin
                            X_COORD <= 4;
                            State <= RESP_B;
                        end
                    end
                    
                end


                else if(direction_Y == 2'b10) begin
                        if(Y_COORD == 0)begin

                            direction_Y <= 2'b01;
                            Y_COORD <= Y_COORD + 1;

                            if(X_COORD < 3)begin
                                X_COORD <= X_COORD + 1;
                                State <= SEND_B;
                            end
        
                            else begin
                                X_COORD <= 4;
                                State <= RESP_B;
                            end
                        end

                        else begin
                            Y_COORD <= Y_COORD - 1;

                            if(X_COORD < 3)begin
                                X_COORD <= X_COORD + 1;
                                State <= SEND_B;
                            end
        
                            else begin
                                X_COORD <= 4;
                                State <= RESP_B;
                            end
                         end
                end

            end
        end


    RESP_A: begin
    
     if(Timer < 2)begin

        if(BTN_A == 1 && (Y_COORD == Y_in_A))begin
          X_COORD <= 1;
          Timer <= 0;
        
          if(DIR_A == 2'b00) begin
            direction_Y <= DIR_A;
            State <= SEND_B;
            end

          else if(DIR_A == 2'b01) begin

            if(Y_COORD == 4)begin
                direction_Y <= 2'b10;
                Y_COORD <= Y_COORD -1;
                State <= SEND_B;
            end

            else begin
                direction_Y <= DIR_A;
                Y_COORD <= Y_COORD +1;
                State <= SEND_B;

            end
            
          end


          else if(DIR_A == 2'b10)begin
            
            if(Y_COORD == 0)begin
                direction_Y <= 2'b01;
                Y_COORD <= Y_COORD + 1;
                State <= SEND_B;

            end

            else begin
                direction_Y <= DIR_A;
                Y_COORD <= Y_COORD - 1;
                State <= SEND_B;
            end



          end


        end

        else begin
            Timer <=Timer + 1;
            State <= RESP_A;
    
    
         end
        
     end

     else begin
        Timer <= 0;
        Score_B <= Score_B + 1;

        State <= GOAL_B;

     end

    end




    RESP_B: begin
        
    if(Timer < 2)begin
       if(BTN_B == 1 && (Y_COORD == Y_in_B))begin
        X_COORD <= 3;
        Timer <= 0;

        if(DIR_B == 2'b00)begin
            direction_Y <= DIR_B;
            State <= SEND_A;
        end

        else if(DIR_B == 2'b01) begin
            if(Y_COORD == 4)begin
                direction_Y <= 2'b10;
                Y_COORD <= Y_COORD -1;
                State <= SEND_A;
            end

            else begin
                direction_Y <= DIR_B   ;
                Y_COORD <= Y_COORD + 1;
                State <= SEND_A;
            end
        end

        else if(DIR_B == 2'b10) begin

            if(Y_COORD == 0)begin
                direction_Y <= 2'b01;
                Y_COORD <= Y_COORD +1;
                State <= SEND_A;
            end

            else begin
                direction_Y <= DIR_B;
                Y_COORD <= Y_COORD -1;
                State <= SEND_A;
            end
            
        end


       end

       else begin
        Timer <= Timer + 1;
        State <= RESP_B;
       end
    end


    else begin
        Timer <= 0;
        Score_A <= Score_A + 1;

        State <= GOAL_A; 
    end

    end

    
   
  
    GOAL_B: begin
        if(Timer < 2) begin
            Timer <= Timer + 1;
            State <= GOAL_B; 
        end

        else begin
            Timer <= 0;

            if(Score_B == 3) begin
                Turn <= 1; 
                State <= END_state; 
            end

            else begin
                State <= HIT_A; 
            end
        end


    end

    GOAL_A: begin
        
    if(Timer < 2)begin
        Timer <= Timer + 1;
        State <= GOAL_A; 
    end
   
    else begin
        Timer <= 0;

        if(Score_A == 3)begin
            Turn <= 0;
            State <= END_state; 
        end

        else begin
            State <= HIT_B; 
        end
    end




    end
    

    END_state: begin
        State <= END_state; 
    end





endcase

end

end




    
    
endmodule