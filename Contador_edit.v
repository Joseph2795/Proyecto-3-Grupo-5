`timescale 1ns / 1ps

module Contador_edit(swformat, clk, reset, FSMedit, FSMpos, boton_ed, counterlr, data_out_1, data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9,edicion_out_1, edicion_out_2, edicion_out_3, state);

input clk, reset, swformat, FSMedit, FSMpos, boton_ed, data_out_1, data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9, state;
output counterlr, edicion_out_1, edicion_out_2, edicion_out_3;  

parameter DATA_WIDTH = 8;

wire [7:0] data_out_1 ;
wire [7:0] data_out_2 ;
wire [7:0] data_out_3 ;
wire [7:0] data_out_4 ;
wire [7:0] data_out_5 ;
wire [7:0] data_out_6 ;
wire [7:0] data_out_7 ;
wire [7:0] data_out_8 ;
wire [7:0] data_out_9 ;
reg [6:0] counterlr;
wire [6:0] contador;
wire [1:0] FSMedit;
wire [1:0] FSMpos;
wire [3:0] boton_ed;
wire [2:0] state;

reg [7:0] count0;
reg [7:0] count1;
reg [7:0] count2;
reg [7:0] count3;
reg [7:0] count4;
reg [7:0] count5;
reg [7:0] count6;
reg [7:0] count7;
reg [7:0] count8;

reg [7:0] edicion_out_1;
reg [7:0] edicion_out_2;
reg [7:0] edicion_out_3;

    always @(posedge clk)
    begin
        if (FSMedit == 3 && FSMpos == 1)//Editando_hora
            begin
                counterlr <= 35;    
            end 
        else if (FSMedit == 3 && FSMpos == 2)//
            begin
                counterlr <= 34; 
            end           
        else if (FSMedit == 3 && FSMpos == 3)//
            begin
                counterlr <= 33;
            end 
        else if (FSMedit == 2 && FSMpos == 1)//Editando_fecha
            begin
                counterlr <= 38; 
            end 
        else if (FSMedit == 2 && FSMpos == 2)//
            begin
                counterlr <= 37; 
            end           
        else if (FSMedit == 2 && FSMpos == 3)//
            begin
                counterlr <= 36; 
            end
        else if (FSMedit == 1 && FSMpos == 1)//Editando_timer
                begin
                counterlr <= 67;   
                end 
        else if (FSMedit == 1 && FSMpos == 2)//
            begin
                counterlr <= 66; 
            end           
        else if (FSMedit == 1 && FSMpos == 3)//
            begin
                counterlr <= 65;
            end   
        else 
            begin
                counterlr <= counterlr;
            end
    end
    
    always@(posedge clk)
    begin
        if (FSMedit == 3)   begin 
            edicion_out_1 <= count0; //segundos
            edicion_out_2 <= count1; //minutos
            edicion_out_3 <= count2; //horas 
            end
        else if (FSMedit == 2) begin
            edicion_out_1 <= count3; //año
            edicion_out_2 <= count4; //mes
            edicion_out_3 <= count5; //dia
            end
        else if (FSMedit == 1) begin
            edicion_out_1 <= count6; //segundos
            edicion_out_2 <= count7; //minutos
            edicion_out_3 <= count8; //horas
            end
        else begin
            edicion_out_1 <= edicion_out_1; //segundos
            edicion_out_2 <= edicion_out_2; //minutos
            edicion_out_3 <= edicion_out_3; //horas
            end
    end
    
    always @(posedge clk)
        if (state == 0 && FSMedit == 0)
        begin
            count0 <= data_out_1; //segundos
            count1 <= data_out_2; //minutos
            count2 <= data_out_3; //horas
            count3 <= data_out_4; //año
            count4 <= data_out_5; //mes
            count5 <= data_out_6; //dia
            count6 <= data_out_7;//seg
            count7 <= data_out_8;//min
            count8 <= data_out_9;//hor
        end
        else if (state == 2 && FSMedit != 0)
        begin
            if (FSMedit == 3) 
            begin
                if (boton_ed[0] == 1)
                begin
                    if (counterlr == 33)
                    begin
                        if (count0 < 59)
                        begin
                            count0 = count0 + 1;
                        end
                        else
                        begin
                            count0 = 0;
                        end                    
                    end
                    else if (counterlr == 34)
                    begin
                        if (count1 < 59)
                        begin
                            count1 = count1 + 1;
                        end
                        else
                        begin
                            count1 = 0;
                        end                    
                    end
                    else if (counterlr == 35)
                    begin
                        if (swformat == 1)
                        begin
                            if (count2 < 12)
                            begin
                                count2 = count2 + 1;
                            end
                            else 
                            begin
                                count2 = 1;
                            end
                        end
                        else 
                        begin
                            if (count2 < 23) 
                            begin
                                count2 = count2 + 1;
                            end
                            else 
                            begin
                                count2 = 0;
                            end
                        end
                    end
                end
                else if (boton_ed[1] == 1)
                begin
                    if (counterlr == 33)
                    begin
                        if (count0 > 0)
                        begin
                            count0 = count0 - 1;    
                        end
                        else
                        begin
                            count0 = 59;
                        end
                    end
                    else if (counterlr == 34)
                    begin
                        if (count1 > 0)
                        begin
                            count1 = count1 - 1;    
                        end
                        else
                        begin
                            count1 = 59;
                        end
                    end
                    else if (counterlr == 35)
                    begin
                        if (swformat == 1)
                        begin
                            if (count2 > 1)
                            begin
                                count2 = count2 - 1;
                            end
                            else 
                            begin
                                count2 = 12;
                            end
                        end
                        else 
                        begin
                            if (count2 > 0)
                            begin
                                count2 = count2 - 1;
                            end
                            else
                            begin
                                count2 = 23;
                            end
                        end
                    end
                end
                else begin
                    count2 <= count2;
                    count1 <= count1;
                    count0 <= count0; end
            end
            else if (FSMedit == 2) 
            begin
                if (boton_ed[0] == 1)
                begin
                    if (counterlr == 38)
                    begin
                        if (count5 < 31)
                        begin
                            count5 = count5 + 1;
                        end
                        else
                        begin
                            count5 = 1;
                        end                    
                    end
                    else if (counterlr == 37)
                    begin
                        if (count4 < 12)
                        begin
                            count4 = count4 + 1;
                        end
                        else 
                        begin
                            count4 = 1;
                        end
                    end
                    else if (counterlr == 36) 
                    begin
                        if (count3 < 99) 
                        begin
                            count3 = count3 + 1;
                        end
                        else 
                        begin
                            count3 = 0;
                        end
                    end
                end
                else if (boton_ed[1] == 1)
                begin
                    if (counterlr == 38)
                    begin
                        if (count5 > 1)
                        begin
                            count5 = count5 - 1;    
                        end
                        else
                        begin
                            count5 = 31;
                        end
                    end
                    else if (counterlr == 37)
                    begin
                        if (count4 > 1)
                        begin
                            count4 = count4 - 1;
                        end
                        else 
                        begin
                            count4 = 12;
                        end
                    end
                    else if (counterlr == 36) 
                    begin
                        if (count3 > 0) 
                        begin
                            count3 = count3 - 1;
                        end
                        else 
                        begin
                            count3 = 99;
                        end
                    end
                end
                else begin 
                    count3 <= count3;
                    count4 <= count4;
                    count5 <= count5;
                end
            end
            else if (FSMedit == 1) 
            begin
                if (boton_ed[0] == 1)
                begin
                    if (counterlr == 65)
                    begin
                        if (count6 < 59)
                        begin
                            count6 = count6 + 1;
                        end
                        else
                        begin
                            count6 = 0;
                        end                    
                    end
                    else if (counterlr == 66)
                    begin
                        if (count7 < 59)
                        begin
                            count7 = count7 + 1;
                        end
                        else
                        begin
                            count7 = 0;
                        end                    
                    end
                    else if (counterlr == 67)
                    begin
                        if (count8 < 23) 
                        begin
                            count8 = count8 + 1;
                        end
                        else 
                        begin
                            count8 = 0;
                        end
                    end
                end
                else if (boton_ed[1] == 1)
                begin
                    if (counterlr == 65)
                    begin
                        if (count6 > 0)
                        begin
                            count6 = count6 - 1;    
                        end
                        else
                        begin
                            count6 = 59;
                        end
                    end
                    else if (counterlr == 66)
                    begin
                        if (count7 > 0)
                        begin
                            count7 = count7 - 1;    
                        end
                        else
                        begin
                            count7 = 59;
                        end
                    end
                    else if (counterlr == 67)
                    begin
                        if (count8 > 0)
                        begin
                            count8 = count8 - 1;
                        end
                        else
                        begin
                            count8 = 23;
                        end
                    end
                end   
                else begin
                count7 <= count7;
                count8 <= count8;
                count6 <= count6;
                 end    
            end  
        end
        else
        begin
            count0 <= count0;
            count1 <= count1;
            count2 <= count2;
            count3 <= count3;
            count4 <= count4;
            count5 <= count5;
            count6 <= count6;
            count7 <= count7;
            count8 <= count8;
        end
        
endmodule
