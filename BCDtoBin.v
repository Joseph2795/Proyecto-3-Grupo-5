`timescale 1ns / 1ps

module BCDtoBin(clk, bcd, binario);

input [7:0]bcd;
input clk;
output reg[7:0]binario;

always @(posedge clk)
begin
case(bcd)
8'h00: binario <= 0;
8'h01: binario <= 1;
8'h02: binario <= 2;
8'h03: binario <= 3;
8'h04: binario <= 4;
8'h05: binario <= 5;
8'h06: binario <= 6;
8'h07: binario <= 7;
8'h08: binario <= 8;
8'h09: binario <= 9;
8'h10: binario <= 10;
8'h11: binario <= 11;
8'h12: binario <= 12;
8'h13: binario <= 13;
8'h14: binario <= 14;
8'h15: binario <= 15;
8'h16: binario <= 16;
8'h17: binario <= 17;
8'h18: binario <= 18;
8'h19: binario <= 19;
8'h20: binario <= 20;
8'h21: binario <= 21;
8'h22: binario <= 22;
8'h23: binario <= 23;
8'h24: binario <= 24;
8'h25: binario <= 25;
8'h26: binario <= 26;
8'h27: binario <= 27;
8'h28: binario <= 28;
8'h29: binario <= 29;
8'h30: binario <= 30;
8'h31: binario <= 31;
8'h32: binario <= 32;
8'h33: binario <= 33;
8'h34: binario <= 34;
8'h35: binario <= 35;
8'h36: binario <= 36;
8'h37: binario <= 37;
8'h38: binario <= 38;
8'h39: binario <= 39;
8'h40: binario <= 40;
8'h41: binario <= 41;
8'h42: binario <= 42;
8'h43: binario <= 43;
8'h44: binario <= 44;
8'h45: binario <= 45;
8'h46: binario <= 46;
8'h47: binario <= 47;
8'h48: binario <= 48;
8'h49: binario <= 49;
8'h50: binario <= 50;
8'h51: binario <= 51;
8'h52: binario <= 52;
8'h53: binario <= 53;
8'h54: binario <= 54;
8'h55: binario <= 55;
8'h56: binario <= 56;
8'h57: binario <= 57;
8'h58: binario <= 58;
8'h59: binario <= 59;
8'h60: binario <= 60;
8'h61: binario <= 61;
8'h62: binario <= 62;
8'h63: binario <= 63;
8'h64: binario <= 64;
8'h65: binario <= 65;
8'h66: binario <= 66;
8'h67: binario <= 67;
8'h68: binario <= 68;
8'h69: binario <= 69;
8'h70: binario <= 70;
8'h71: binario <= 71;
8'h72: binario <= 72;
8'h73: binario <= 73;
8'h74: binario <= 74;
8'h75: binario <= 75;
8'h76: binario <= 76;
8'h77: binario <= 77;
8'h78: binario <= 78;
8'h79: binario <= 79;
8'h80: binario <= 80;
8'h81: binario <= 81;
8'h82: binario <= 82;
8'h83: binario <= 83;
8'h84: binario <= 84;
8'h85: binario <= 85;
8'h86: binario <= 86;
8'h87: binario <= 87;
8'h88: binario <= 88;
8'h89: binario <= 89;
8'h90: binario <= 90;
8'h91: binario <= 91;
8'h92: binario <= 92;
8'h93: binario <= 93;
8'h94: binario <= 94;
8'h95: binario <= 95;
8'h96: binario <= 96;
8'h97: binario <= 97;
8'h98: binario <= 98;
8'h99: binario <= 99;
default: binario <= 0;
endcase

end
endmodule
