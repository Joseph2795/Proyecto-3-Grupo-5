  `timescale  1 ns / 1 ps
  module formato (clk, control, AD, state, contador, sw_formato, v_sync, control_timer);

    parameter stnd = 4'b0000;     
    parameter read = 4'b0001;
    parameter read11 = 4'b0010;
    parameter read1 = 4'b0011;
    parameter read12 = 4'b0100;
    parameter read2 = 4'b0101;
    parameter read3 = 4'b0110;
    parameter read4 = 4'b0111;      
    parameter formato = 4'b1000; 
    
    parameter DATA_WIDTH = 8;

    input  clk, state, sw_formato, v_sync, control_timer; 
    output control, AD, contador;
    reg control_carga;
    wire [6:0] counterlr;  
    wire control_timer;
    reg [7:0] AD;
   
   /*Control
   control[3] = CS
   control[2] = AD
   control[1] = RD
   control[0] = WR
   */
    reg [3:0] actuals = stnd;
    reg [3:0] control;
    reg [5:0] counter;
    reg [6:0] contador;
    wire [2:0] state;
    
   always @(posedge clk) begin
        if (v_sync) 
        begin
            contador <= 0;
        end
        else if (counter == 39 && state == 6) begin
            if (contador == 0) begin
                contador <= contador + 1;end
           else begin
                 contador <= 1;
           end
        end
    end
            
    always @(posedge clk)
    begin
        if (v_sync)
        begin
            counter <= 6'b0;
        end
        else
        begin
            if (counter <= 39 && state == 6)
            begin
                counter <= counter + 1;        
            end
            else
            begin
                counter <= 6'b0;
            end
        end
    end 
  
  
  always @(posedge clk)
        begin 
            case(actuals)
            stnd : begin 
            if (state != 6)
            begin
                actuals <= stnd;
                control <= 4'b0000;
            end
            else
                actuals <= read;
            end    
            read : begin
                if (counter >= 0 && counter <= 3)
                    begin
                        actuals <= read;
                        control <= 4'b1101;
                    end
                else 
                    actuals <= read11;
                end               
            read11 : begin                
                    if (counter >= 6'b000100 && counter <= 6'b000101)
                        begin   
                            actuals <= read11;
                            control <= 4'b1001;
                        end
                    else
                        actuals <= read1;
                    end
            read1 : begin                
                if (counter >= 6'b000110 && counter <= 6'b001011)
                    begin   
                        actuals <= read1;
                        control <= 4'b0010;
                    end
                else
                    actuals <= read12;
                end
            read12 : begin                
                if (counter >= 6'b001100 && counter <= 6'b001101)
                    begin   
                        actuals <= read12;
                        control <= 4'b1001;
                    end
                else
                    actuals <= read2;
                end
            read2 : begin
                if (counter >= 6'b001110 && counter <= 6'b011001)
                    begin
                        actuals <= read2;
                        control <= 4'b1101;
                    end    
                else 
                    actuals <= read3;
                end
          read3 : begin
                if (counter >= 6'b011010 && counter <= 6'b011111)
                    begin
                        actuals <= read3;
                        control <= 4'b0110;
                    end                
                else 
                    actuals <= read4;
                end
         read4 : begin
                if (counter >= 6'b100000 && counter <= 6'b101000)
                    begin
                        actuals <= read4;
                        control <= 4'b1101;
                    end
                else
                    actuals <= read;
                end
            endcase
         end
 
always @(posedge clk)
   begin
     if (counter >= 9 && counter <= 16 && contador == 0)
           AD <= 0;
     else if (counter >= 29 && counter <= 36 && contador == 0)
        if (sw_formato && control_timer == 0)
           AD <= 24;
        else if (sw_formato && control_timer == 1)
            AD <= 16;
        else if (!sw_formato && control_timer == 1)
            AD <= 0;
        else if (!sw_formato && control_timer == 0)
            AD <= 8;
     end
endmodule