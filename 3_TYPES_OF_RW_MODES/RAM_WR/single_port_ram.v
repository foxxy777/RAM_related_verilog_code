//µ¥¶ËRAM
module memory_16x4 #(
    parameter DATA_W    = 4,
    parameter ADDR_W = 4,
    parameter RAM_D     =(1<<DATA_W)
)
(
    inout    [DATA_W-1:0]      data_w,
    input     [ADDR_W-1:0]   address,
    input                           wr_en,
    input rd_en,
    input clk
);
reg [DATA_W] mem [DATA_D];
reg [DATA_W] data_buffer;
always @(posedge clk)begin
    if(wr_en)
        mem[address]<=data_w;
end
always @(posedge clk)begin
    if(rd_en)
        data_buffer <= mem[address];
end
assign data_w = (rd_en)? data_buffer:DATA_W'hz;
endmodule
*/
