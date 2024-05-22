module Buffer(
    input wire PixelClk,
    input wire aPixelClkLckd,
    input wire pVDE,
    input wire [23:0] pData
);

reg [95:0] buffer;

always @(posedge PixelClk or negedge aPixelClkLckd) begin
    if (!aPixelClkLckd) begin
        buffer <= 96'b0;
    end else begin
        if (pVDE) begin
            buffer <= {buffer[71:0], pData};
        end else begin
            buffer <= buffer;
        end
    end
end

endmodule