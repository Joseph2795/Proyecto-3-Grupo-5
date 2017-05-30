`timescale  1 ns / 1 ps
module FSM_pantalla(clk, reset, sw_timer, sw_fecha, sw_hora, boton_ed, FSMedit, FSMpos, switches);

input clk, reset, sw_timer, sw_fecha, sw_hora, boton_ed;
output FSMedit, FSMpos, switches;

wire [1:0] FSMedit;
wire [1:0] FSMpos; 

wire [2:0] switches;

wire [3:0] boton_ed;

parameter est1= 2'b00;
parameter est2 = 2'b01;
parameter est3 = 2'b10;
parameter est4 = 2'b11;

reg [1:0] estact;
reg [1:0] estactpos;

reg counter_edit = est1;

assign FSMpos = estactpos;
assign FSMedit = estact;

assign switches[0] = sw_timer;
assign switches[1] = sw_fecha;
assign switches[2] = sw_hora;

//EDICION

always @(posedge clk)
begin
    if (reset)
        begin
            estact <= est1;   
        end
    else
        case (estact)
           est1 : 
           begin
           if (switches != 3'b000)
                if (switches == 4)
                    estact <= est4;
                else if (switches == 2)
                    estact <= est3;
                else if (switches == 1)
                    estact <= est2;
           else
                estact <= est1; 
           end
           est2:
           begin
           if (switches == 3'b000) 
                estact <= est1;
           else
                estact <= est2;         
           end
           est3:
           begin
           if (switches == 3'b000) 
                estact <= est1;
           else
                estact <= est3;         
           end
           est4:
           begin
           if (switches == 3'b000)
                estact <= est1;
           else
                estact <= est4;
           end 
           default:
           begin
                estact <= est1; 
           end
       endcase
end

//boton[0] = Up
//boton[1] = Down
//boton[2] = pos_izq
//boton[3] = pos_der


always @(posedge clk)
begin
if (reset)
        begin
            estactpos <= est1;
        end
    case (estactpos)
       est1 : 
       begin
       if (estact == est4 || estact == est3 || estact == est2)
            estactpos <= est4; 
       else
            estactpos <= est1; 
       end
       est2:
       begin
       if (switches == 3'b000) 
            estactpos <= est1;
       else 
           if (boton_ed[2] == 1)
                estactpos <= est4;         
           else if (boton_ed[3] == 1)
                estactpos <= est3;      
           else
                estactpos <= est2;
       end
       est3:
       begin
       if (switches == 3'b000) 
            estactpos <= est1;
       else 
           if (boton_ed[2] == 1)
                estactpos <= est2;         
           else if (boton_ed[3] == 1)
                estactpos <= est4;      
           else
                estactpos <= est3;
       end
       est4:
       begin
       if (switches == 3'b000) 
            estactpos <= est1;
       else 
           if (boton_ed[2] == 1)
                estactpos <= est3;         
           else if (boton_ed[3] == 1)
                estactpos <= est2;      
           else
                estactpos <= est4;
       end
       default:
       begin
            estactpos <= est1; 
       end
   endcase
end

//boton[0] = Up
//boton[1] = Down
//boton[2] = pos_izq
//boton[3] = pos_der


endmodule




