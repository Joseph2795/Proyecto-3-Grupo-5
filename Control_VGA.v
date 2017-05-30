`timescale  1 ns / 1 ps
module Control_VGA(/*data_in_RTC,*/ clk, reset, swcolors, sw_timer, sw_fecha, sw_hora, sw_formato, boton_edit, h_sync, v_sync, colors_out, data_out, control, stop);//, counter_x_sync);//, stop, bit_addr_2);//, dato_print, state, contador, counter_x_sync, data_out_1, data_out_2, num1, num2, num3, char_addr);//, counter_x_sync,);//, counter_x_sync, switches, boton_ed, ctrl_ed, pixel_x, pixel_y, dato_print, char_addr, pos);

input clk, reset, swcolors, sw_timer, sw_formato, sw_fecha, sw_hora, boton_edit, stop;
output  h_sync, v_sync, colors_out, control;//, counter_x_sync;//, dato_print, state, contador, counter_x_sync, data_out_1, data_out_2, num1, num2, num3, char_addr;
inout data_out; //, switches, boton_ed, ctrl_ed, pixel_x, pixel_y, dato_print, char_addr, pos;
//input data_in_RTC;
//output [4:0] bit_addr_2;

parameter DATA_WIDTH = 8;

wire control_screen;
reg [1:0] r_reg;
wire [2:0] switches;
wire [1:0] r_nxt;
reg clk_track;
wire [8:0] pixel_y;
wire [9:0] pixel_x;
reg [9:0] counter_x;
reg [8:0] counter_y;
wire clk_out;
reg [9:0] counter_x_sync;
reg [9:0] counter_y_sync;
reg video_on;
wire stop_s;
wire v_sync, h_sync, video_on_out;
wire [2:0] swcolors;
wire clk_cnt, font_bitw;
wire [11:0] colors_out;
reg font_bit;
wire [9:0] a;
wire [9:0] b;
reg comp;
wire [3:0] boton_ed;
wire [3:0] boton_edit;
wire ctrl_ed;
wire [3:0] dato_print;
wire [3:0] pos;
wire [3:0] control;
wire [2:0] state;
wire [3:0] posicion;
wire control_dato_lectura;
wire [7:0] contador;
wire [7:0] data_in_RTC;
wire [7:0] data_out;
wire [1:0] FSMedit;
wire [1:0] FSMpos;
wire [DATA_WIDTH-1:0] data_out_1 ;
wire [DATA_WIDTH-1:0] data_out_2 ;
wire [DATA_WIDTH-1:0] data_out_3 ;
wire [DATA_WIDTH-1:0] data_out_4 ;
wire [DATA_WIDTH-1:0] data_out_5 ;
wire [DATA_WIDTH-1:0] data_out_6 ;
wire [DATA_WIDTH-1:0] data_out_7 ;
wire [DATA_WIDTH-1:0] data_out_8 ;
wire [DATA_WIDTH-1:0] data_out_9 ;

wire [7:0] num1;
wire [7:0] num2;
wire [7:0] num3;

//boton[0] = Up                     
//boton[1] = Down
//boton[2] = pos_izq
//boton[3] = pos_der

Caracter_gen generator (.sw_formato(sw_formato),.pixel_x(pixel_x),.pixel_y(pixel_y),.v_sync(v_sync),.clk(clk),.video_on_out(video_on_out),.swcolors(swcolors),.sw_timer(sw_timer),.sw_fecha(sw_fecha),.sw_hora(sw_hora),.boton_ed(boton_ed),.colors_out(colors_out),.switches(switches),.ctrl_ed(ctrl_ed),.pos(pos),.dato_print(dato_print),.posicion(posicion),.control_dato_lectura(control_dato_lectura),.reset(reset),.data_out(data_out),.FSMedit(FSMedit),.FSMpos(FSMpos),.num1(num1),.num2(num2),.num3(num3),.data_out_1(data_out_1),.data_out_2(data_out_2),.data_out_3(data_out_3),.data_out_4(data_out_4),.data_out_5(data_out_5),.data_out_6(data_out_6),.data_out_7(data_out_7),.data_out_8(data_out_8),.data_out_9(data_out_9),.control_screen(control_screen));//,.data_in_RTC(data_in_RTC));

debounce deb1(.clk(clk),.signalInput(boton_edit[0]),.signalOutput(boton_ed[0]));
debounce deb2(.clk(clk),.signalInput(boton_edit[1]),.signalOutput(boton_ed[1]));
debounce deb3(.clk(clk),.signalInput(boton_edit[2]),.signalOutput(boton_ed[2]));
debounce deb4(.clk(clk),.signalInput(boton_edit[3]),.signalOutput(boton_ed[3]));
debounce deb5(.clk(clk),.signalInput(stop),.signalOutput(stop_s));
//debounce deb5(.clk(clk),.signalInput(reset2),.signalOutput(reset));

RTC principal (.swformat(sw_formato),.clk(clk), .swdate(sw_fecha), .swtime(sw_hora), .swtimer(sw_timer), .swreset(reset), .state(state), .v_sync(v_sync), .ADo(data_out), .control(control),.posicion(posicion),.control_dato_lectura(control_dato_lectura),.contador(contador),.FSMedit(FSMedit),.FSMpos(FSMpos),.data_out_1(data_out_1),.data_out_2(data_out_2),.data_out_3(data_out_3),.data_out_4(data_out_4),.data_out_5(data_out_5),.data_out_6(data_out_6),.data_out_7(data_out_7),.data_out_8(data_out_8),.data_out_9(data_out_9),.num1(num1),.num2(num2),.num3(num3),.boton_ed(boton_ed),.stop_s(stop_s),.control_screen(control_screen));


always @(posedge clk or posedge reset)
 
begin

  if (reset)
     begin
        r_reg <= 2'b0;
	    clk_track <= 1'b0;  
     end
  else
  begin 
      if (r_nxt == 2'b10)
           begin
             r_reg <= 0;
             clk_track <= ~clk_track;
             comp <= ~clk_track;
           end
      else
      begin 
          r_reg <= r_nxt;
          comp <= 0;
      end
    end
end

assign r_nxt = r_reg+1;   	      
assign clk_out = clk_track;
assign clk_cnt = comp;

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        counter_x_sync <= 10'b0;
        counter_y_sync <= 10'b0; 
        video_on <= 1'b0;      
    end
    else
    begin
        if (clk_out && clk_cnt)	
        begin
            counter_x_sync <= counter_x_sync + 1;
            if (counter_x_sync == 799)
            begin
                if (counter_y_sync == 524)
                begin
                    counter_y_sync <= 10'b0;
                    counter_x_sync <= 10'b0;
                end
                else
                begin
                    counter_y_sync <= counter_y_sync + 1;
                    counter_x_sync <= 10'b0;   
                end         
            end     
        end
        
    end
end
 
assign a = counter_x_sync;
assign b = counter_y_sync;
assign h_sync = ~(counter_x_sync >= 703 && counter_x_sync <= 799);
assign v_sync = ~(counter_y_sync > 522 && counter_y_sync <= 524);  
assign video_on_out = ((counter_y_sync >= 33 && counter_y_sync <= 512)&&(counter_x_sync >= 48 && counter_x_sync <= 687)); 

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        counter_x <= 10'b0;
        counter_y <= 9'b0;   
    end
    else 
    begin
        if (clk_out && video_on_out && clk_cnt)
        begin
            counter_x = counter_x + 1;
            if (counter_x == 640)
            begin
                if (counter_y== 479)
                begin
                    counter_y <= 10'b0;
                    counter_x <= 10'b0;
                end
                else
                begin
                    counter_y <= counter_y+ 1;
                    counter_x <= 10'b0;   
                end 
            end               
        end
    end 
end

assign pixel_x = counter_x;
assign pixel_y = counter_y;

endmodule
