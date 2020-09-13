`timescale 1ns/1ps
module sync_fifo_tb;
reg [3:0]  data_in;
reg        clk,rst_a,wr_en,rd_en;
wire [3:0] data_out;
wire    full,empty;

sync_fifo u1 (.data_out(data_out),.full(full), .empty(empty), .wr_en(wr_en), .rd_en(rd_en), .clk(clk), .rst_a(rst_a), .data_in(data_in));

initial
begin
clk=1'b1;
forever #50 clk=~clk;
end

initial
begin
   rst_a=1'b1;
   data_in=4'b0000;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0001;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0010;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0011;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0100;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0101;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

      rst_a=1'b0;
   data_in=4'b0110;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

      rst_a=1'b0;
   data_in=4'b0111;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;


   data_in=4'b1000;
   #100;


   data_in=4'b1001;
   #100;


   data_in=4'b1010;
   #100;


   data_in=4'b1011;
   #100;

   data_in=4'b1100;
   #100;

   data_in=4'b1101;
   #100;

   data_in=4'b1110;
   #100;

   data_in=4'b1111;
   #100;

   rd_en=1'b1;
   wr_en=1'b0;
   #1600;
  
   rst_a=1'b1;
   data_in=4'b0101;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0101;
   wr_en=1'b1;
   rd_en=1'b0;
   #100;

   rst_a=1'b0;
   data_in=4'b0110;
   wr_en=1'b0;
   rd_en=1'b1;
   #400;

  
$stop;
end
endmodule
