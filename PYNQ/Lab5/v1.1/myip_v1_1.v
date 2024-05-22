
`timescale 1 ns / 1 ps

	module myip_v1_1 #
	(
		// Users to add parameters here
		
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface M_AXIS
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
		input wire PixelClk,
		input wire aPixelClkLckd,
		input wire pVDE,
		input wire pHSync,
		input wire pVSync,
		input wire [23:0] pData,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Master Bus Interface M_AXIS
		input wire  m_axis_aclk,
		input wire  m_axis_aresetn,
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
		output wire  m_axis_tlast,
		input wire  m_axis_tready
	);
// Instantiation of Axi Bus Interface M_AXIS
	myip_v1_1_M_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_AXIS_START_COUNT)
	) myip_v1_1_M_AXIS_inst (
		.PixelClk(PixelClk),
		.aPixelClkLckd(aPixelClkLckd),
		.pVDE(pVDE),
		.pHSync(pHSync),
		.pVSync(pVSync),
		.pData(pData),
		.M_AXIS_ACLK(m_axis_aclk),
		.M_AXIS_ARESETN(m_axis_aresetn),
		.M_AXIS_TVALID(m_axis_tvalid),
		.M_AXIS_TDATA(m_axis_tdata),
		.M_AXIS_TSTRB(m_axis_tstrb),
		.M_AXIS_TLAST(m_axis_tlast),
		.M_AXIS_TREADY(m_axis_tready)
	);

	// Add user logic here

	// User logic ends

	endmodule
