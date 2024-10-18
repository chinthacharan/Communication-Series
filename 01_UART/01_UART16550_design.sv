`timescale 1ns/1ps

///FIFO

module fifo_top(
    input rst, clk, en, push_in, pop_in,
    input [7:0] din,
    output [7:0] dout,
    output empty, full, overrun, underrun,
    input [3:0] threshold,
    output thre_trigger
);

    reg [7:0] mem[16];
    reg [3:0] waddr = 0;

    logic push, pop;

    ///empty flag
    reg empty_t;
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            empty_t <= 1'b0;
        end
        else begin
            case({push, pop})
            2'b01: empty_t <= ( ~|(waddr) | ~en)
            2'b10: empty_t <= 1'b0;
            default : ;
            endcase
        end
    end

    ///full flag
    reg full_t;
    always @(posedge clk, posedge rst) begin
        if(rst)
            full_t <= 1'b0;
        else begin
            case ({push, pop})
             2'b10: full_t <= (&(waddr) | ~en);
             2'b01: full_t <= 1'b0;
             default : ;
            endcase
        end
    end
endmodule