module vending_machine(
    input clk,
    input rst,
    input [1:0] coin, // 00: no coin, 01: 0.5 yuan, 10: 1 yuan
    output reg beverage,
    output reg [1:0] change // 00: no change, 01: 0.5 yuan, 10: 1 yuan
);

    // 状态定义
    parameter IDLE = 2'b00,
              HALF = 2'b01,
              ONE = 2'b10,
              ONE_HALF = 2'b11;

    reg [1:0] state, next_state;

    // 状态转移逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // 状态转移条件
    always @(*) begin
        next_state = state;
        beverage = 0;
        change = 2'b00;

        case (state)
            IDLE: begin
                if (coin == 2'b01)
                    next_state = HALF;
                else if (coin == 2'b10)
                    next_state = ONE;
            end
            HALF: begin
                if (coin == 2'b01)
                    next_state = ONE;
                else if (coin == 2'b10)
                    next_state = ONE_HALF;
            end
            ONE: begin
                if (coin == 2'b01) begin
                    next_state = IDLE;
                    beverage = 1;
                end else if (coin == 2'b10) begin
                    next_state = IDLE;
                    beverage = 1;
                    change = 2'b01; // 退还0.5元
                end
            end
            ONE_HALF: begin
                next_state = IDLE;
                beverage = 1;
                change = 2'b10; // 退还1元
            end
        endcase
    end

endmodule




