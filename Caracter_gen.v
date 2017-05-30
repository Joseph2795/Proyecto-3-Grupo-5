`timescale  1 ns / 1 ps
module Caracter_gen(pixel_x, pixel_y, v_sync, clk, video_on_out, swcolors, sw_timer, sw_fecha, sw_hora, colors_out, boton_ed, switches, ctrl_ed, pos, dato_print, posicion, sw_formato, control_dato_lectura, reset, data_out, FSMedit, FSMpos, data_out_1, data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9, num1, num2, num3, control_screen);//, data_in_RTC);

input clk, video_on_out, sw_hora, sw_fecha, sw_timer, boton_ed, v_sync, posicion, sw_formato, control_dato_lectura, reset;
output [11:0] colors_out;
output switches, dato_print, FSMedit, FSMpos, data_out_1, data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7,data_out_8,data_out_9;
input [8:0] pixel_y;
input [9:0] pixel_x;
input [2:0] swcolors;
output ctrl_ed, pos;
input data_out, num1, num2, num3, control_screen;
//input [7:0] data_in_RTC;

parameter DATA_WIDTH = 8;
parameter hora = 2048;
parameter numero = 512;
parameter crono = 5120;
parameter fecha = 2560;

reg control_pm;
wire [2:0] switches;
reg font_bit;
wire font_bitw;
reg [11:0] colors;
reg ctrl_fondo = 0;
wire [1:0] FSMedit;
wire [1:0] FSMpos;
wire [3:0] boton_ed;
reg ctrl_edit;
wire ctrl_ed;
reg [3:0] pos;
wire [7:0] data_R;
reg [3:0] dato_print;
reg lectura;
reg [3:0] posi;
reg [10:0] actual_hora;
reg [8:0] actual_num;
wire [3:0] posicion;
wire [7:0] data_out;
wire [DATA_WIDTH-1:0] data_out_1 ;
wire [DATA_WIDTH-1:0] data_out_2 ;
wire [DATA_WIDTH-1:0] data_out_3 ;
wire [DATA_WIDTH-1:0] data_out_4 ;
wire [DATA_WIDTH-1:0] data_out_5 ;
wire [DATA_WIDTH-1:0] data_out_6 ;
wire [DATA_WIDTH-1:0] data_out_7 ;
wire [DATA_WIDTH-1:0] data_out_8 ;
wire [DATA_WIDTH-1:0] data_out_9 ;
reg [11:0] Dato_hora [0:hora-1];	
reg [11:0] Dato_crono [0:crono-1];	
reg [11:0] Dato_fecha [0:fecha-1];	
reg [11:0] Dato_0 [0:numero-1];
reg [11:0] Dato_1 [0:numero-1];
reg [11:0] Dato_2 [0:numero-1];
reg [11:0] Dato_3 [0:numero-1];
reg [11:0] Dato_4 [0:numero-1];
reg [11:0] Dato_5 [0:numero-1];
reg [11:0] Dato_6 [0:numero-1];
reg [11:0] Dato_7 [0:numero-1];
reg [11:0] Dato_8 [0:numero-1];
reg [11:0] Dato_9 [0:numero-1];
reg [11:0] Dato_num;//data of colours

wire [7:0] num1;
wire [7:0] num2;
wire [7:0] num3;
reg ctrl_imagen;
reg [11:0] actual_fecha;
reg [12:0] actual_crono;
 
ROM_RTC data_RTC (.address(posi),.data(data_out),.we(lectura),.data_out(data_R),.clk(clk),.data_out_1(data_out_1),.data_out_2(data_out_2),.data_out_3(data_out_3),.data_out_4(data_out_4),.data_out_5(data_out_5),.data_out_6(data_out_6),.data_out_7(data_out_7),.data_out_8(data_out_8),.data_out_9(data_out_9));

FSM_pantalla ctrl_p (.clk(clk),.reset(reset),.sw_timer(sw_timer),.sw_fecha(sw_fecha),.sw_hora(sw_hora),.boton_ed(boton_ed),.FSMedit(FSMedit),.FSMpos(FSMpos),.switches(switches));

initial begin
$readmemh ("Hora.list", Dato_hora);
$readmemh ("Cronometro.list", Dato_crono);
$readmemh ("Fecha.list", Dato_fecha);
$readmemh ("0.list", Dato_0);
$readmemh ("1.list", Dato_1);
$readmemh ("2.list", Dato_2);
$readmemh ("3.list", Dato_3);
$readmemh ("4.list", Dato_4);
$readmemh ("5.list", Dato_5);
$readmemh ("6.list", Dato_6);
$readmemh ("7.list", Dato_7);
$readmemh ("8.list", Dato_8);
$readmemh ("9.list", Dato_9);
end

assign colors_out = colors;

always @(posedge clk)
begin
    if ((pixel_x [9:6] == 1) && (pixel_y[8:5] == 3))
        actual_hora <= {pixel_x[5:0],pixel_y[4:0]};
    else 
        actual_hora <= 11'b0;
end

always @(posedge clk)
begin
    if ((pixel_x [9:6] == 1) && (pixel_y[8:5] == 6))
        actual_fecha <= {1'b0,pixel_x[5:0],pixel_y[4:0]};
    else if ((pixel_x [9:6] == 2) && (pixel_y[8:5] == 6))
        actual_fecha <= {1'b1,pixel_x[5:0],pixel_y[4:0]};
    else 
        actual_fecha <= 12'b0;
end

always @(posedge clk)
begin
    if ((pixel_x [9:6] == 1) && (pixel_y[8:5] == 9))
        actual_crono <= {1'b0,1'b0,pixel_x[5:0],pixel_y[4:0]};
    else if ((pixel_x [9:6] == 2) && (pixel_y[8:5] == 9))
        actual_crono <= {1'b0,1'b1,pixel_x[5:0],pixel_y[4:0]};
    else if ((pixel_x [9:6] == 3) && (pixel_y[8:5] == 9))
        actual_crono <= {1'b1,1'b0,pixel_x[5:0],pixel_y[4:0]};    
    else 
        actual_crono <= 13'b0;
end


always @(posedge clk)
begin
    if (((pixel_x [9:4] == 4 || pixel_x [9:4] == 5 || pixel_x [9:4] == 7 || pixel_x [9:4] == 8 || pixel_x [9:4] == 10 || pixel_x [9:4] == 11) && (pixel_y[8:5] == 4)) || ((pixel_x [9:4] == 4 || pixel_x [9:4] == 5 || pixel_x [9:4] == 7 || pixel_x [9:4] == 8 || pixel_x [9:4] == 10 || pixel_x [9:4] == 11) && (pixel_y[8:5] == 7)) || ((pixel_x [9:4] == 4 || pixel_x [9:4] == 5 || pixel_x [9:4] == 7 || pixel_x [9:4] == 8 || pixel_x [9:4] == 10 || pixel_x [9:4] == 11) && (pixel_y[8:5] == 10)))
        actual_num <= {pixel_x[3:0],pixel_y[4:0]};
    else 
        actual_num <= 9'b0;
end

always @*
begin
if (video_on_out == 0)
   colors <= 12'b000000000000;
else
    if ((pixel_x [9:6] == 1) && (pixel_y[8:5] == 3))
        colors <= Dato_hora[{actual_hora}];
    else if (((pixel_x [9:4] == 4 || pixel_x [9:4] == 5 || pixel_x [9:4] == 7 || pixel_x [9:4] == 8 || pixel_x [9:4] == 10 || pixel_x [9:4] == 11) && (pixel_y[8:5] == 4)) || ((pixel_x [9:4] == 4 || pixel_x [9:4] == 5 || pixel_x [9:4] == 7 || pixel_x [9:4] == 8 || pixel_x [9:4] == 10 || pixel_x [9:4] == 11) && (pixel_y[8:5] == 7)) || ((pixel_x [9:4] == 4 || pixel_x [9:4] == 5 || pixel_x [9:4] == 7 || pixel_x [9:4] == 8 || pixel_x [9:4] == 10 || pixel_x [9:4] == 11) && (pixel_y[8:5] == 10)))
        colors <= Dato_num;
    else if ((pixel_x [9:6] == 1 || pixel_x [9:4] == 8) && (pixel_y[8:5] == 6))
        colors <= Dato_fecha[{actual_fecha}];
    else if ((pixel_x [9:6] == 1 || pixel_x [9:6] == 2 || pixel_x[9:4] == 12 || pixel_x[9:4] == 13) && (pixel_y[8:5] == 9))
        colors <= Dato_crono[{actual_crono}];
    else
        colors <= 12'b111111111111;
end


always @*
begin
    if (v_sync == 1)
        posi <= pos;
    else 
        posi <= posicion;
end

always @*
begin
    if ((pixel_x[9:4] == 16 || pixel_x[9:4] == 17) && pixel_y[8:5] == 4 && FSMedit == 3 && FSMpos == 1)//Editando_hora
        begin
            ctrl_edit <= 1;   
        end 
    else if ((pixel_x[9:4] == 19 || pixel_x[9:4] == 20) && pixel_y[8:5] == 4 && FSMedit == 3 && FSMpos == 2)//
        begin
            ctrl_edit <= 1; 
        end           
    else if ((pixel_x[9:4] == 22 || pixel_x[9:4] == 23) && pixel_y[8:5] == 4 && FSMedit == 3 && FSMpos == 3)//
        begin
            ctrl_edit <= 1;
        end 
    else if ((pixel_x[9:4] == 5 || pixel_x[9:4] == 6) && pixel_y[8:5] == 11 && FSMedit == 2 && FSMpos == 1)//Editando_fecha
        begin
            ctrl_edit <= 1; 
        end 
    else if ((pixel_x[9:4] == 8 || pixel_x[9:4] == 9) && pixel_y[8:5] == 11 && FSMedit == 2 && FSMpos == 2)//
        begin
            ctrl_edit <= 1; 
        end           
    else if ((pixel_x[9:4] == 12 || pixel_x[9:4] == 11) && pixel_y[8:5] == 11 && FSMedit == 2 && FSMpos == 3)//
        begin
            ctrl_edit <= 1; 
        end
    else if ((pixel_x[9:4] == 26 || pixel_x[9:4] == 27) && pixel_y[8:5] == 11 && FSMedit == 1 && FSMpos == 1)//Editando_timer
            begin
            ctrl_edit <= 1;   
            end 
    else if ((pixel_x[9:4] == 29 || pixel_x[9:4] == 30) && pixel_y[8:5] == 11 && FSMedit == 1 && FSMpos == 2)//
        begin
            ctrl_edit <= 1; 
        end           
    else if ((pixel_x[9:4] == 32 || pixel_x[9:4] == 33) && pixel_y[8:5] == 11 && FSMedit == 1 && FSMpos == 3)//
        begin
            ctrl_edit <= 1;
        end
    else
        begin
            ctrl_edit <= 0;
        end
end

//BEGIN - CAMBIO DE CARACTER

always @* begin
        if (v_sync == 0 && control_dato_lectura == 1)
         begin
              pos <= 9;
              lectura <= 1;
              dato_print <= data_R[3:0];
         end   
        else if (pixel_x[9:4] == 4 && pixel_y[8:5] == 4)//Editando_hora
            begin 
            if (data_R[7] == 1 || num3[7] == 1)
                control_pm <= 1;
            else 
                control_pm <= 0;
            if (FSMedit == 3)begin
                pos <= 2;
                dato_print <= num3[6:4];
                lectura <= 0;
            end
            else begin
                 pos <= 2;
                 dato_print <= data_R[6:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 5 && pixel_y[8:5] == 4)//Editando_hora
            begin
            if (FSMedit == 3)begin
                pos <= 2;
                dato_print <= num3[3:0];
                lectura <= 0;
            end else begin
                 pos <= 2;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 7 && pixel_y[8:5] == 4)//Editando_hora
            begin
            if (FSMedit == 3)begin
                pos <= 1;
                dato_print <= num2[7:4];
                lectura <= 0;
            end else begin
                 pos <= 1;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 8 && pixel_y[8:5] == 4)//Editando_hora
            begin
            if (FSMedit == 3)begin
                pos <= 1;
                dato_print <= num2[3:0];
                lectura <= 0;
            end else begin
                 pos <= 1;  
                 dato_print <= data_R[3:0]; 
                 lectura <= 0;    end    
            end 
        else if (pixel_x[9:4] == 10 && pixel_y[8:5] == 4)//Editando_hora
            begin
                if (FSMedit == 3)begin
                pos <= 0;
                dato_print <= num1[7:4];
                lectura <= 0; end
                else begin
                 pos <= 0;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 11 && pixel_y[8:5] == 4)
            begin
            if (FSMedit == 3)begin
                pos <= 0;
                dato_print <= num1[3:0];
                lectura <= 0; end
            else begin
                 pos <= 0;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 4 && pixel_y[8:5] == 10)
            begin
            if (FSMedit == 1)begin
                pos <= 8;
                dato_print <= num3[7:4];
                lectura <= 0; end
            else begin
                 pos <= 8;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 5 && pixel_y[8:5] == 10)
            begin
            if (FSMedit == 1)begin
                pos <= 8;
                dato_print <= num3[3:0];
                lectura <= 0; end
            else begin
                 pos <= 8;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end
        else if (pixel_x[9:4] == 7 && pixel_y[8:5] == 10)
            begin
            if (FSMedit == 1)begin
                pos <= 7;
                dato_print <= num2[7:4];
                lectura <= 0; end
            else begin
                 pos <= 7;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 8 && pixel_y[8:5] == 10)
            begin
            if (FSMedit == 1)begin
                pos <= 7;
                dato_print <= num2[3:0];
                lectura <= 0; end
            else begin
                 pos <= 7;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 10 && pixel_y[8:5] == 10)
            begin
            if (FSMedit == 1)begin
                pos <= 6;
                dato_print <= num1[7:4];
                lectura <= 0; end
            else begin
                 pos <= 6;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 11 && pixel_y[8:5] == 10)
            begin
            if (FSMedit == 1)begin
                pos <= 6;
                dato_print <= num1[3:0];
                lectura <= 0; end
            else begin
                 pos <= 6;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 4 && pixel_y[8:5] == 7)
            begin
            if (FSMedit == 2)begin
                pos <= 5;
                dato_print <= num3[7:4];
                lectura <= 0; end
            else begin
                 pos <= 5;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 5 && pixel_y[8:5] == 7)
            begin
            if (FSMedit == 2)begin
                pos <= 5;
                dato_print <= num3[3:0];
                lectura <= 0; end
            else begin
                 pos <= 5;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 7 && pixel_y[8:5] == 7)
            begin
            if (FSMedit == 2)begin
                pos <= 4;
                dato_print <= num2[7:4];
                lectura <= 0; end
            else begin
                 pos <= 4;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 8 && pixel_y[8:5] == 7)
            begin
            if (FSMedit == 2)begin
                pos <= 4;
                dato_print <= num2[3:0];
                lectura <= 0; end
            else begin
                 pos <= 4;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end
        else if (pixel_x[9:4] == 10 && pixel_y[8:5] == 7)
            begin
            if (FSMedit == 2)begin
                pos <= 3;
                dato_print <= num1[7:4];
                lectura <= 0; end
            else begin
                 pos <= 3;
                 dato_print <= data_R[7:4];
                 lectura <= 0; end
            end 
        else if (pixel_x[9:4] == 11 && pixel_y[8:5] == 7)
            begin
            if (FSMedit == 2)begin
                pos <= 3;
                dato_print <= num1[3:0];
                lectura <= 0; end
            else begin
                 pos <= 3;
                 dato_print <= data_R[3:0];
                 lectura <= 0; end
            end
        else
            begin
                pos <= 9;
                dato_print <= data_R[3:0];
                lectura <= 0;
            end 
    end

//END - CAMBIO DE CARACTER

always @ (posedge clk)
begin
if (pos != 9)                       
    begin
    if (dato_print == 0)   
        begin
            Dato_num <= Dato_0[actual_num];
        end 
    else if (dato_print == 1)   
        begin
            Dato_num <= Dato_1[actual_num];
        end           
    else if (dato_print == 2)   
        begin
            Dato_num <= Dato_2[actual_num];
        end 
    else if (dato_print == 3)   
        begin
            Dato_num <= Dato_3[actual_num];
        end 
    else if (dato_print == 4)   
        begin
            Dato_num <= Dato_4[actual_num];
        end 
    else if (dato_print == 5)   
        begin
            Dato_num <= Dato_5[actual_num];
        end           
    else if (dato_print == 6)   
        begin
            Dato_num <= Dato_6[actual_num];
        end 
    else if (dato_print == 7)   
        begin
            Dato_num <= Dato_7[actual_num];
        end 
    else if (dato_print == 8)   
        begin
            Dato_num <= Dato_8[actual_num];
        end 
    else if (dato_print == 9)   
        begin
            Dato_num <= Dato_9[actual_num];
        end      
    else
        begin
           Dato_num <= 12'b111111111111;
        end    
    end
end

endmodule