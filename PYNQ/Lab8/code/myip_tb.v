`timescale 1ns / 1ps
module tb1();

    reg m_axis_aclk;
    reg m_axis_aresetn;

    reg M_AXIS_tready;

    wire [31:0] M_AXIS_tdata;
    wire M_AXIS_tlast;
    wire [3:0] M_AXIS_tstrb;
    wire M_AXIS_tvalid;

    design_1_wrapper dut(
        .M_AXIS_tdata(M_AXIS_tdata),
        .M_AXIS_tlast(M_AXIS_tlast),
        .M_AXIS_tready(M_AXIS_tready),
        .M_AXIS_tstrb(M_AXIS_tstrb),
        .M_AXIS_tvalid(M_AXIS_tvalid),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_aresetn(m_axis_aresetn)
    );

    initial begin
        M_AXIS_tready = 0;
        #200;
        M_AXIS_tready = 1;
    end

    initial begin
        m_axis_aresetn = 0;
        #100;
        m_axis_aresetn = 1;
    end

    initial begin
        m_axis_aclk = 0;
    end

    always #5 m_axis_aclk = ~m_axis_aclk; // Clock generator

endmodule