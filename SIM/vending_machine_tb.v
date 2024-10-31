module vending_machine_tb;

    reg clk;
    reg rst;
    reg [1:0] coin;
    wire beverage;
    wire [1:0] change;

    // 实例化被测模块
    vending_machine uut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .beverage(beverage),
        .change(change)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 时钟周期为10ns
    end

    // 仿真过程
    initial begin
        // 初始化输入信号
        rst = 1;
        coin = 2'b00;
        #10 rst = 0;

        // 插入0.5元
        #10 coin = 2'b01;
        #10 coin = 2'b00;

        // 再次插入0.5元，应该获得饮料
        #10 coin = 2'b01;
        #10 coin = 2'b00;

        // 插入1元
        #10 coin = 2'b10;
        #10 coin = 2'b00;

        // 再插入1元，应该获得饮料并找零0.5元
        #10 coin = 2'b10;
        #10 coin = 2'b00;

        // 停止仿真
        #50 $stop;
    end

endmodule


