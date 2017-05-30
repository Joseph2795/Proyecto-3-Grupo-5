`timescale 1ns / 1ps
module Escritura(trol, clk, control, reset, AD, contador, data_out_1, data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9, num1, num2, num3, counterlr);

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

    input  clk, reset, trol, data_out_1, data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9, num1, num2, num3, counterlr;
    output control, AD, contador;
    wire orstate;
    wire [DATA_WIDTH-1:0] data_out_1 ;
    wire [DATA_WIDTH-1:0] data_out_2 ;
    wire [DATA_WIDTH-1:0] data_out_3 ;
    wire [DATA_WIDTH-1:0] data_out_4 ;
    wire [DATA_WIDTH-1:0] data_out_5 ;
    wire [DATA_WIDTH-1:0] data_out_6 ;
    wire [DATA_WIDTH-1:0] data_out_7 ;
    wire [DATA_WIDTH-1:0] data_out_8 ;
    wire [DATA_WIDTH-1:0] data_out_9 ;
    wire [7:0]num1;
    wire [7:0]num2;
    wire [7:0]num3;
    reg control_carga;
    wire [6:0] counterlr;  
    reg control_timer;
    
   
   /*Control
   control[3] = CS
   control[2] = AD
   control[1] = RD
   control[0] = WR
   */

    wire [2:0] trol;
    reg [3:0] actuals = stnd;
    reg [3:0] control;
    reg [5:0] counter;
    reg [7:0] contador;
    
(*dont_touch = "true"*)    reg [7:0] AD;

    always @(posedge clk or posedge reset)
    begin
        if (trol == 0 || reset)
        begin
            counter <= 6'b0;
        end
        else
        begin
            if (counter <= 39 && trol == 4)
            begin
                counter <= counter + 1;        
            end
            else
            begin
                counter <= 6'b0;
            end
        end
    end 

   always @(posedge clk or posedge reset)
       if (reset || trol == 0) 
       begin
           contador <= 7'b0100000;
       end
       else if (counter == 39 && trol == 4) begin
           if (contador < 68) begin
               if (contador == 38) begin
                   contador <= 65;end
               else begin
               contador <= contador + 1;end
            end
          else begin
                contador <= 69;
          end
       end            
        
  always @(posedge clk)
        begin 
            case(actuals)
            stnd : begin 
            if (contador > 69)
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
        if (contador == 32 && (counter >= 9 && counter <= 16) && contador == 32)begin 
              AD <= 0;
        end
        else if (contador == 32 && (counter >= 29 && counter <= 36) && contador == 32) begin 
             if ((counterlr == 65 || counterlr == 66 || counterlr == 67)) begin
              AD <= 8; end
             else begin
              AD <= 0; end
        end
        else if  (counter >= 9 && counter <= 16 && contador != 68)
            begin 
               AD <= contador; 
            end
        else if (counter >= 29 && counter <= 36 && contador != 68)
            begin
                if (contador == 33)
                    if (counterlr == 33 || counterlr == 34 || counterlr == 35)
                        AD <= num1;
                    else
                        AD <= data_out_1; 
                else if (contador == 34)
                    if (counterlr == 33 || counterlr == 34 || counterlr == 35)
                        AD <= num2;
                    else
                        AD <= data_out_2; 
                else if (contador == 35)
                    if (counterlr == 33 || counterlr == 34 || counterlr == 35)
                        AD <= num3;
                    else
                        AD <= data_out_3;          
                else if (contador == 36)
                    if (counterlr == 36 || counterlr == 37 || counterlr == 38)
                        AD <= num3;
                    else
                        AD <= data_out_6;                       
                else if (contador == 37)
                    if (counterlr == 36 || counterlr == 37 || counterlr == 38)
                        AD <= num2;
                    else
                        AD <= data_out_5;                     
                else if (contador == 38)
                    if (counterlr == 36 || counterlr == 37 || counterlr == 38)
                        AD <= num1;
                    else
                        AD <= data_out_4;   
                else if (contador == 65)
                    if (counterlr == 65 || counterlr == 66 || counterlr == 67) begin
                        AD <= 0; end
                    else begin
                        AD <= data_out_7;   end
                else if (contador == 66)
                    if (counterlr == 65 || counterlr == 66 || counterlr == 67) begin
                        AD <= 0; end
                    else begin
                        AD <= data_out_8; end
                else if (contador == 67)
                    if (counterlr == 65 || counterlr == 66 || counterlr == 67) begin
                        AD <= 0; end
                    else begin
                        AD <= data_out_9; end
            end
       else if ((counter >= 9 && counter <= 16)  && contador == 68)   
            begin
            if (counterlr == 33 || counterlr == 34 || counterlr == 35 || counterlr == 36 || counterlr == 37 || counterlr == 38)
                AD <= 241;
            else
                AD <= 242;
            end
      else if ((counter >= 29 && counter <= 36) && contador == 68)   
            begin
              if (counterlr == 33 || counterlr == 34 || counterlr == 35 || counterlr == 36 || counterlr == 37 || counterlr == 38)
                  AD <= 241;
              else
                  AD <= 242;
            end
      else
           begin
               AD<=0;
           end
end

endmodule
