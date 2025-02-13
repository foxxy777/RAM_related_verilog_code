module sync_fifo #( parameter DATA_W    = 4,
    parameter ADDR_W = 4,
    parameter RAM_D     =16
)
(
    output reg [DATA_W-1:0] data_out,
    output full,
    output empty,
    input [DATA_W-1:0] data_in,
    input clk,
    input rst_a,
    input wr_en,
    input rd_en
);
reg [ADDR_W-1:0]    wr_pointer;
reg [ADDR_W-1:0]    rd_pointer;
reg [ADDR_W :0]     status_count;
//reg [DATA_W-1:0]       data_out ;
wire [DATA_W-1:0]      data_ram ;
always @ (posedge clk,posedge rst_a)
begin
    if(rst_a)
        wr_pointer = 0;
    else begin
        if(wr_en)
            wr_pointer = wr_pointer+1;
    end
end
always @ (posedge clk,posedge rst_a)
begin
    if(rst_a)
        rd_pointer = 0;
    else begin
        if(rd_en)
            rd_pointer = rd_pointer+1;
    end
end
always @ (posedge clk,posedge rst_a)
begin
    if(rst_a)
        data_out <=0;
    else begin
        if(rd_en)
            data_out <=data_ram;
    end
end
always @ (posedge clk,posedge rst_a)
begin
    if(rst_a)
        status_count = 0;
    else begin
        if(wr_en && !rd_en && (status_count != RAM_D))
            status_count = status_count + 1;
        else
            if(rd_en && !wr_en && (status_count != 0))
                status_count = status_count - 1;
        end // always @ (posedge clk,posedge rst_a)
    end
    assign full = (status_count == (RAM_D-1));
    assign empty = (status_count == 0);
    memory_16x4 #(DATA_W,ADDR_W,RAM_D) u1 (.address_1(wr_pointer),.address_2(rd_pointer),.data_1(data_in),.data_2(data_ram),.wr_en1(wr_en),.rd_en2(rd_en),.clk(clk));
    endmodule // sync_fifo
    //伪双端RAM，
    module memory_16x4 #(
        parameter DATA_W    = 4,
        parameter ADDR_W = 4,
        parameter RAM_D     =16
    )
    (
        input     [DATA_W-1:0]      data_1,
        output    [DATA_W-1:0]      data_2,
        input     [ADDR_W-1:0]   address_1,
        input     [ADDR_W-1:0]   address_2,
        input                           wr_en1,clk,rd_en2//总之1就是写，2就是读
    );
    reg [ADDR_W-1:0]     memory[0:RAM_D-1];
    reg [DATA_W-1:0]        data_2_out;
    //wire [DATA_W-1:0]  data_2;//不用了，默认wire
    //并没有对同时读写做保护
    always @(posedge clk)
    begin
        if (wr_en1)
            memory[address_1]=data_1;
    end
    always @(posedge clk)
    begin
        if (rd_en2)
            data_2_out=memory[address_2];
    end
    assign data_2=(rd_en2)?data_2_out:8'b0;
    endmodule // memory_16x4

