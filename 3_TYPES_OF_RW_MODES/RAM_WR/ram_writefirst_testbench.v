`timescale 1ns/100ps
module ram_writefirst_testbench();
parameter addressWidth = 5;
parameter dataWidth = 32;
reg clk,en,we;
reg [addressWidth-1:0] address;
reg [dataWidth-1:0] din;
wire [dataWidth-1:0] dout;
wire [addressWidth-1:0] address_delay_w;
wire [dataWidth-1:0] mem_0;
ram_writefirst 
#(
    .addressWidth(addressWidth),
    .dataWidth(dataWidth)
) ram_writefirst_inst
(
    .clk(clk),
    .we (we),
    .en (en),
    .address(address),
    .din(din),
    .address_delay_w(address_delay_w),
    .mem_0(mem_0),
    .dout(dout)
);
parameter PERIOD = 10;
initial begin
    clk = 1'b0;
    forever #(PERIOD/2) clk = ~clk;
end
initial begin
    en = 1;
    we = 1;
    din = 32'b1;
    address = 5'b0;
    #20;
    din = 32'b0;
    address = 5'd1;
    #50;
    $finish;
end
endmodule
