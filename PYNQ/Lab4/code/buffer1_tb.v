`timescale 1ns / 1ps

module Buffer_tb;

    reg PixelClk;
    reg aPixelClkLckd;
    reg pVDE;
    reg [23:0] pData;

    Buffer u1 (
        .PixelClk(PixelClk), 
        .aPixelClkLckd(aPixelClkLckd), 
        .pVDE(pVDE), 
        .pData(pData)
    );

    initial begin
        PixelClk = 0;
        aPixelClkLckd = 0;
        pVDE = 0;
        pData = 24'hFFFFFF;
        #100; aPixelClkLckd = 1;
        #50; pVDE = 1; pData = 24'hAAAAAA;
        #100; pData = 24'hBBBBBB;
        #100; pData = 24'hCCCCCC;
        #100; pData = 24'hDDDDDD;
        #100; pData = 24'hEEEEEE;
        #100; pVDE = 0; pData = 24'hAAAAAA;
        #100; pVDE = 1; pData = 24'hABCDEF;
        #100; pVDE = 0;
        #100;
    end

    always #50 PixelClk = ~PixelClk; // Clock generator

endmodule
