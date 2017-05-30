`timescale 1ns / 1ps
module ROM_RTC (
clk, // Clock Input
address     , // Address Input
data        , // Data bi-directional
data_out,
data_out_1,
data_out_2,
data_out_3,
data_out_4,
data_out_5,
data_out_6,
data_out_7,
data_out_8,
data_out_9,
we           // Write Enable/Read Enable
); 

parameter DATA_WIDTH = 8 ;
parameter ADDR_WIDTH = 4 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 

input [ADDR_WIDTH-1:0] address     ;
input                  we          ;
//--------------Inout Ports----------------------- 
input data       ;
output data_out       ;
output data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7, data_out_8, data_out_9;
input clk;


//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] data_out_1 ;
reg [DATA_WIDTH-1:0] data_out_2 ;
reg [DATA_WIDTH-1:0] data_out_3 ;
reg [DATA_WIDTH-1:0] data_out_4 ;
reg [DATA_WIDTH-1:0] data_out_5 ;
reg [DATA_WIDTH-1:0] data_out_6 ;
reg [DATA_WIDTH-1:0] data_out_7 ;
reg [DATA_WIDTH-1:0] data_out_8 ;
reg [DATA_WIDTH-1:0] data_out_9 ;

wire [DATA_WIDTH-1:0] data ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg                  oe_r;

initial begin
    mem[0] <= 8'h12;
    mem[1] <= 8'h12;
    mem[2] <= 8'h12;
    mem[3] <= 8'h12;
    mem[4] <= 8'h12;
    mem[5] <= 8'h12;
    mem[6] <= 8'h12;
    mem[7] <= 8'h12;
    mem[8] <= 8'h12;
    mem[9] <= 8'h12;
end

//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When we = 0, oe = 1, cs = 1


// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @(posedge clk)
begin : MEM_WRITE
   if (we ) begin
       mem[address] <= data;  
   end
   else
   begin
       data_out <= mem[address];
       case (address)
       0:data_out_1 <= mem[address];
       1:data_out_2 <= mem[address];
       2:data_out_3 <= mem[address];
       3:data_out_4 <= mem[address];
       4:data_out_5 <= mem[address];
       5:data_out_6 <= mem[address];
       6:data_out_7 <= mem[address];
       7:data_out_8 <= mem[address];
       8:data_out_9 <= mem[address];
       endcase
   end
end

endmodule