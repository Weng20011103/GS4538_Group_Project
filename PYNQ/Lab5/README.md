# Lab 5: M_AXIS.v 分析    
## Verilog 程式  
```v
`timescale 1 ns / 1 ps

	module myip_v1_0_M_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
		parameter integer C_M_START_COUNT	= 32
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Global ports
		input wire  M_AXIS_ACLK,
		// 
		input wire  M_AXIS_ARESETN,
		// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		output wire  M_AXIS_TVALID,
		// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		// TLAST indicates the boundary of a packet.
		output wire  M_AXIS_TLAST,
		// TREADY indicates that the slave can accept a transfer in the current cycle.
		input wire  M_AXIS_TREADY
	);
	// Total number of output data                                                 
	localparam NUMBER_OF_OUTPUT_WORDS = 8;                                               
	                                                                                     
	// function called clogb2 that returns an integer which has the                      
	// value of the ceiling of the log base 2.                                           
	function integer clogb2 (input integer bit_depth);                                   
	  begin                                                                              
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                                      
	      bit_depth = bit_depth >> 1;                                                    
	  end                                                                                
	endfunction                                                                          
	                                                                                     
	// WAIT_COUNT_BITS is the width of the wait counter.                                 
	localparam integer WAIT_COUNT_BITS = clogb2(C_M_START_COUNT-1);                      
	                                                                                     
	// bit_num gives the minimum number of bits needed to address 'depth' size of FIFO.  
	localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS);                                
	                                                                                     
	// Define the states of state machine                                                
	// The control state machine oversees the writing of input streaming data to the FIFO,
	// and outputs the streaming data from the FIFO                                      
	parameter [1:0] IDLE = 2'b00,        // This is the initial/idle state               
	                                                                                     
	                INIT_COUNTER  = 2'b01, // This state initializes the counter, once   
	                                // the counter reaches C_M_START_COUNT count,        
	                                // the state machine changes state to SEND_STREAM     
	                SEND_STREAM   = 2'b10; // In this state the                          
	                                     // stream data is output through M_AXIS_TDATA   
	// State variable                                                                    
	reg [1:0] mst_exec_state;                                                            
	// Example design FIFO read pointer                                                  
	reg [bit_num-1:0] read_pointer;                                                      

	// AXI Stream internal signals
	//wait counter. The master waits for the user defined number of clock cycles before initiating a transfer.
	reg [WAIT_COUNT_BITS-1 : 0] 	count;
	//streaming data valid
	wire  	axis_tvalid;
	//streaming data valid delayed by one clock cycle
	reg  	axis_tvalid_delay;
	//Last of the streaming data 
	wire  	axis_tlast;
	//Last of the streaming data delayed by one clock cycle
	reg  	axis_tlast_delay;
	//FIFO implementation signals
	reg [C_M_AXIS_TDATA_WIDTH-1 : 0] 	stream_data_out;
	wire  	tx_en;
	//The master has issued all the streaming data stored in FIFO
	reg  	tx_done;


	// I/O Connections assignments

	assign M_AXIS_TVALID	= axis_tvalid_delay;
	assign M_AXIS_TDATA	= stream_data_out;
	assign M_AXIS_TLAST	= axis_tlast_delay;
	assign M_AXIS_TSTRB	= {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};


	// Control state machine implementation                             
	always @(posedge M_AXIS_ACLK)                                             
	begin                                                                     
	  if (!M_AXIS_ARESETN)                                                    
	  // Synchronous reset (active low)                                       
	    begin                                                                 
	      mst_exec_state <= IDLE;                                             
	      count    <= 0;                                                      
	    end                                                                   
	  else                                                                    
	    case (mst_exec_state)                                                 
	      IDLE:                                                               
	        // The slave starts accepting tdata when                          
	        // there tvalid is asserted to mark the                           
	        // presence of valid streaming data                               
	        //if ( count == 0 )                                                 
	        //  begin                                                           
	            mst_exec_state  <= INIT_COUNTER;                              
	        //  end                                                             
	        //else                                                              
	        //  begin                                                           
	        //    mst_exec_state  <= IDLE;                                      
	        //  end                                                             
	                                                                          
	      INIT_COUNTER:                                                       
	        // The slave starts accepting tdata when                          
	        // there tvalid is asserted to mark the                           
	        // presence of valid streaming data                               
	        if ( count == C_M_START_COUNT - 1 )                               
	          begin                                                           
	            mst_exec_state  <= SEND_STREAM;                               
	          end                                                             
	        else                                                              
	          begin                                                           
	            count <= count + 1;                                           
	            mst_exec_state  <= INIT_COUNTER;                              
	          end                                                             
	                                                                          
	      SEND_STREAM:                                                        
	        // The example design streaming master functionality starts       
	        // when the master drives output tdata from the FIFO and the slave
	        // has finished storing the S_AXIS_TDATA                          
	        if (tx_done)                                                      
	          begin                                                           
	            mst_exec_state <= IDLE;                                       
	          end                                                             
	        else                                                              
	          begin                                                           
	            mst_exec_state <= SEND_STREAM;                                
	          end                                                             
	    endcase                                                               
	end                                                                       


	//tvalid generation
	//axis_tvalid is asserted when the control state machine's state is SEND_STREAM and
	//number of output streaming data is less than the NUMBER_OF_OUTPUT_WORDS.
	assign axis_tvalid = ((mst_exec_state == SEND_STREAM) && (read_pointer < NUMBER_OF_OUTPUT_WORDS));
	                                                                                               
	// AXI tlast generation                                                                        
	// axis_tlast is asserted number of output streaming data is NUMBER_OF_OUTPUT_WORDS-1          
	// (0 to NUMBER_OF_OUTPUT_WORDS-1)                                                             
	assign axis_tlast = (read_pointer == NUMBER_OF_OUTPUT_WORDS-1);                                
	                                                                                               
	                                                                                               
	// Delay the axis_tvalid and axis_tlast signal by one clock cycle                              
	// to match the latency of M_AXIS_TDATA                                                        
	always @(posedge M_AXIS_ACLK)                                                                  
	begin                                                                                          
	  if (!M_AXIS_ARESETN)                                                                         
	    begin                                                                                      
	      axis_tvalid_delay <= 1'b0;                                                               
	      axis_tlast_delay <= 1'b0;                                                                
	    end                                                                                        
	  else                                                                                         
	    begin                                                                                      
	      axis_tvalid_delay <= axis_tvalid;                                                        
	      axis_tlast_delay <= axis_tlast;                                                          
	    end                                                                                        
	end                                                                                            


	//read_pointer pointer

	always@(posedge M_AXIS_ACLK)                                               
	begin                                                                            
	  if(!M_AXIS_ARESETN)                                                            
	    begin                                                                        
	      read_pointer <= 0;                                                         
	      tx_done <= 1'b0;                                                           
	    end                                                                          
	  else                                                                           
	    if (read_pointer <= NUMBER_OF_OUTPUT_WORDS-1)                                
	      begin                                                                      
	        if (tx_en)                                                               
	          // read pointer is incremented after every read from the FIFO          
	          // when FIFO read signal is enabled.                                   
	          begin                                                                  
	            read_pointer <= read_pointer + 1;                                    
	            tx_done <= 1'b0;                                                     
	          end                                                                    
	      end                                                                        
	    else if (read_pointer == NUMBER_OF_OUTPUT_WORDS)                             
	      begin                                                                      
	        // tx_done is asserted when NUMBER_OF_OUTPUT_WORDS numbers of streaming data
	        // has been out.                                                         
	        tx_done <= 1'b1;                                                         
	      end                                                                        
	end                                                                              


	//FIFO read enable generation 

	assign tx_en = M_AXIS_TREADY && axis_tvalid;   
	                                                     
	    // Streaming output data is read from FIFO       
	    always @( posedge M_AXIS_ACLK )                  
	    begin                                            
	      if(!M_AXIS_ARESETN)                            
	        begin                                        
	          stream_data_out <= 1;                      
	        end                                          
	      else if (tx_en)// && M_AXIS_TSTRB[byte_index]  
	        begin                                        
	          stream_data_out <= read_pointer + 32'b1;   
	        end                                          
	    end                                              

	// Add user logic here

	// User logic ends

	endmodule
```
  
## myip_v1_0_M_AXIS 模組定義  
在這個模組中有兩個參數：  
1. `C_M_AXIS_TDATA_WIDTH`: S_AXIS 地址匯流排的寬度。這個參數表示從屬設備接受的讀取和寫入地址的寬度。在這個例子中，它被設定為 32。  
2.  `C_M_START_COUNT`: 主設備在開始/發出任何交易之前將等待的時鐘週期數。在這個例子中，它被設定為 32。  
  
這些參數可以在模組實例化時被賦予特定的值，以便在不同的情況下重用同一個模組。在這個模組中，這些參數被用來配置地址匯流排的寬度和主設備的開始計數。  
```v
module myip_v1_0_M_AXIS #(
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line

    // Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
    parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
    // Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
    parameter integer C_M_START_COUNT	= 32
)
```
  
## myip_v1_0_M_AXIS 模組的端口定義部分  
各個端口的功能：  
1. `M_AXIS_ACLK`: 輸入線路，用於提供模組的時鐘信號。  
2. `M_AXIS_ARESETN`: 輸入線路，用於提供模組的異步重設信號。  
3. `M_AXIS_TVALID`: 輸出線路，表示主設備正在驅動一個有效的傳輸。當`TVALID`和`TREADY`都被置位(asserted)時，一個傳輸就會發生。  
4. `M_AXIS_TDATA`: 輸出線路，寬度為`C_M_AXIS_TDATA_WIDTH`，用於從主設備傳遞數據。  
5. `M_AXIS_TSTRB`: 輸出線路，寬度為`C_M_AXIS_TDATA_WIDTH/8`，用於指示`TDATA`相關的字節(byte)的內容是否被處理為數據字節或位置字節。  
6. `M_AXIS_TLAST`: 輸出線路，用於指示一個封包(packet)的邊界。  
7. `M_AXIS_TREADY`: 輸入線路，表示從屬設備可以在當前週期接受一個傳輸。  
```v
(
    // Users to add ports here

    // User ports ends
    // Do not modify the ports beyond this line

    // Global ports
    input wire  M_AXIS_ACLK,
    // 
    input wire  M_AXIS_ARESETN,
    // Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
    output wire  M_AXIS_TVALID,
    // TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
    output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
    // TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
    output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
    // TLAST indicates the boundary of a packet.
    output wire  M_AXIS_TLAST,
    // TREADY indicates that the slave can accept a transfer in the current cycle.
    input wire  M_AXIS_TREADY
);
```
  
## 定義一些參數和一個函數 clogb2  
1. `NUMBER_OF_OUTPUT_WORDS`: 這是一個本地參數，表示輸出數據的總數。在這個例子中，它被設定為 8。  
2. `clogb2`: 這是一個函數，輸入一個整數 bit_depth，返回該整數的以 2 為底的對數的天花板值(ceiling)。它返回的是大於或等於 bit_depth 的最小的 2 的冪次。  
3. `WAIT_COUNT_BITS`: 這是一個本地參數，表示等待計數器的寬度。它的值是 C_M_START_COUNT-1 的以 2 為底的對數的天花板值。  
4. `bit_num`: 這是一個本地參數，表示需要多少位來處理`depth`大小的 FIFO。它的值是 NUMBER_OF_OUTPUT_WORDS 的以 2 為底的對數的天花板值。  
```v
// Total number of output data                                                 
localparam NUMBER_OF_OUTPUT_WORDS = 8;                                               
	                                                                                     
// function called clogb2 that returns an integer which has the                      
// value of the ceiling of the log base 2.                                           
function integer clogb2 (input integer bit_depth);
    begin                                                                              
        for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                                      
            bit_depth = bit_depth >> 1;                                                    
    end                                                                                
endfunction                                                                          
	                                                                                     
// WAIT_COUNT_BITS is the width of the wait counter.                                 
localparam integer WAIT_COUNT_BITS = clogb2(C_M_START_COUNT-1);                      
	                                                                                     
// bit_num gives the minimum number of bits needed to address 'depth' size of FIFO.  
localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS);    
```
  
bit_depth 右移一位，這相當於將 bit_depth 除以 2。  
```v
bit_depth = bit_depth >> 1;
```
  
## 定義一個狀態機的狀態  
狀態機的狀態:  
1. `IDLE`: 這是初始/閒置狀態，狀態機在開始時會處於此狀態。  
2. `INIT_COUNTER`: 這個狀態會初始化計數器，一旦計數器達到 C_M_START_COUNT 的計數，狀態機就會變為 SEND_STREAM 狀態。　　
3. `SEND_STREAM`: 在這個狀態下，流數據(stream data)會通過 M_AXIS_TDATA 輸出。  
```v
// Define the states of state machine                                                
// The control state machine oversees the writing of input streaming data to the FIFO,
// and outputs the streaming data from the FIFO                                      
parameter [1:0] IDLE = 2'b00,   // This is the initial/idle state               
	                                                                                     
                INIT_COUNTER  = 2'b01,  // This state initializes the counter, once   
	                                // the counter reaches C_M_START_COUNT count,        
	                                // the state machine changes state to SEND_STREAM     
                SEND_STREAM   = 2'b10;  // In this state the                          
	                                // stream data is output through M_AXIS_TDATA   
```
## 內部信號  
1. `count`: 等待計數器。主設備會等待用戶定義的時鐘週期數量，然後再開始傳輸。  
2. `axis_tvalid`: 流數據有效信號。  
3. `axis_tvalid_delay`: 流數據有效信號延遲一個時鐘週期。  
4. `axis_tlast`: 流數據的最後一個信號。  
5. `axis_tlast_delay`: 流數據的最後一個信號延遲一個時鐘週期。  
```v
// State variable                                                                    
reg [1:0] mst_exec_state;                                                            
// Example design FIFO read pointer                                                  
reg [bit_num-1:0] read_pointer;                                                      

// AXI Stream internal signals
//wait counter. The master waits for the user defined number of clock cycles before initiating a transfer.
reg [WAIT_COUNT_BITS-1 : 0] 	count;
//streaming data valid
wire  	axis_tvalid;
//streaming data valid delayed by one clock cycle
reg  	axis_tvalid_delay;
//Last of the streaming data 
wire  	axis_tlast;
//Last of the streaming data delayed by one clock cycle
reg  	axis_tlast_delay;
```
  
## FIFO 的實現信號  
1. `stream_data_out`: 流數據輸出。  
2. `tx_en`: 傳輸使能信號。  
3. `tx_done`: 主設備已經發出所有存儲在 FIFO 中的流數據的信號。  
```v
//FIFO implementation signals
reg [C_M_AXIS_TDATA_WIDTH-1 : 0] 	stream_data_out;
wire  	tx_en;
//The master has issued all the streaming data stored in FIFO
reg  	tx_done;
```
  
## 內部信號連接到模組的輸出端口  
```v
// I/O Connections assignments
//將 axis_tvalid_delay 信號連接到 M_AXIS_TVALID 端口。
//表示流數據的有效性信號會被延遲一個時鐘週期後輸出。
assign M_AXIS_TVALID	= axis_tvalid_delay;
//將 stream_data_out 信號連接到 M_AXIS_TDATA 端口。
//表示流數據會被直接輸出。
assign M_AXIS_TDATA	= stream_data_out;
//將 axis_tlast_delay 信號連接到 M_AXIS_TLAST 端口。
//表示流數據的最後一個信號會被延遲一個時鐘週期後輸出。
assign M_AXIS_TLAST	= axis_tlast_delay;
////將一個值為全 1 的向量連接到 M_AXIS_TSTRB 端口。
//向量的長度為 C_M_AXIS_TDATA_WIDTH/8，這表示每個字節都是有效的。
assign M_AXIS_TSTRB	= {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};
```
  
## 實現一個控制狀態機  
狀態機監控從 FIFO 寫入輸入流數據以及從 FIFO 輸出流數據。  
```v
// Control state machine implementation                             
always @(posedge M_AXIS_ACLK) begin //在 M_AXIS_ACLK 的上升沿觸發。                                                
    if (!M_AXIS_ARESETN) begin
    //如果 M_AXIS_ARESETN 為低（即異步重設被觸發）
    // Synchronous reset (active low)                                       
        mst_exec_state <= IDLE; //將 mst_exec_state 設置為 IDLE
        count    <= 0; //將 count 設置為 0。
    end                                                                   
    else
        //根據 mst_exec_state 的值來執行不同的操作。                                             
        case (mst_exec_state)
            IDLE:
            //在此狀態下，當 count 為 0 時，狀態機將轉換到 INIT_COUNTER 狀態。
            //否則，它將保持在 IDLE 狀態。
	        // The slave starts accepting tdata when                          
	        // there tvalid is asserted to mark the                           
	        // presence of valid streaming data                               
	            //if ( count == 0 ) begin                                                           
                mst_exec_state  <= INIT_COUNTER;                              
                //  end                                                             
                //else begin                                                           
                    //mst_exec_state  <= IDLE;                                      
                //  end                                                             
	                                                                          
            INIT_COUNTER:
            //在此狀態下，如果 count 達到 C_M_START_COUNT - 1，則狀態機將轉換到 SEND_STREAM 狀態。
            //否則，count 將增加 1，並且狀態機將保持在 INIT_COUNTER 狀態。
	        // The slave starts accepting tdata when                          
	        // there tvalid is asserted to mark the                           
	        // presence of valid streaming data                               
                if ( count == C_M_START_COUNT - 1 ) begin                                                           
                    mst_exec_state  <= SEND_STREAM;                               
                end                                                             
                else begin                                                           
                    count <= count + 1;                                           
                    mst_exec_state  <= INIT_COUNTER;                              
                end                                                             
	                                                                          
                SEND_STREAM:
                //在此狀態下，如果 tx_done 為真（即所有存儲在 FIFO 中的流數據已經被主設備發出），則狀態機將轉換到 IDLE 狀態。
                //否則，它將保持在 SEND_STREAM 狀態。
                // The example design streaming master functionality starts       
                // when the master drives output tdata from the FIFO and the slave
                // has finished storing the S_AXIS_TDATA                          
                    if (tx_done) begin                                                           
                        mst_exec_state <= IDLE;                                       
                    end                                                             
                    else begin                                                           
                        mst_exec_state <= SEND_STREAM;                                
                    end                                                             
        endcase                                                               
end                                                    
```
  
## AXI 流信號生成
`axis_tvalid`是一個有效性信號，當控制狀態機的狀態為 SEND_STREAM 且輸出流數據的數量小於 NUMBER_OF_OUTPUT_WORDS 時，該信號會被置位。這表示只有在發送流數據且數據數量未達到最大值時，數據才是有效的。  
```v
//tvalid generation
//axis_tvalid is asserted when the control state machine's state is SEND_STREAM and
//number of output streaming data is less than the NUMBER_OF_OUTPUT_WORDS.
assign axis_tvalid = ((mst_exec_state == SEND_STREAM) && (read_pointer < NUMBER_OF_OUTPUT_WORDS));
```
  
`axis_tlast`是一個表示流數據結束的信號，當輸出流數據的數量等於 NUMBER_OF_OUTPUT_WORDS-1 時，該信號會被置位。這表示當所有的數據都已經發送完畢時，會發出一個信號來表示數據流的結束。  
```v
// AXI tlast generation                                                                        
// axis_tlast is asserted number of output streaming data is NUMBER_OF_OUTPUT_WORDS-1          
// (0 to NUMBER_OF_OUTPUT_WORDS-1)                                                             
assign axis_tlast = (read_pointer == NUMBER_OF_OUTPUT_WORDS-1);       
```
  
## 匹配 M_AXIS_TDATA 的延遲  
實現了`axis_tvalid`和`axis_tlast`信號的一個時鐘週期的延遲。  
  
如果`M_AXIS_ARESETN`為高（即沒有重設），`axis_tvalid_delay`和`axis_tlast_delay`的值就會在下一個時鐘週期與`axis_tvalid`和`axis_tlast`的當前值相同，從而實現了一個時鐘週期的延遲。  
```v
// Delay the axis_tvalid and axis_tlast signal by one clock cycle                              
// to match the latency of M_AXIS_TDATA                                                        
always @(posedge M_AXIS_ACLK)                                                                  
	begin                                                                                          
        if (!M_AXIS_ARESETN) begin                                                                                      
            axis_tvalid_delay <= 1'b0;                                                               
            axis_tlast_delay <= 1'b0;                                                                
	    end                                                                                        
        else begin                                                                                      
            axis_tvalid_delay <= axis_tvalid;                                                        
            axis_tlast_delay <= axis_tlast;                                                          
	    end                                                                                        
	end                                                                                            
```
  
## read_pointer 指針和 tx_done 信號的更新  
如果`M_AXIS_ARESETN`為高（即沒有重設），則根據 read_pointer 的值來更新 read_pointer 和 tx_done。  
1. 如果 read_pointer 小於等於 NUMBER_OF_OUTPUT_WORDS-1，並且 tx_en 為真（即 FIFO 讀取信號被使能），則 read_pointer 會增加 1，並將 tx_done 設置為 0。  
2. 如果 read_pointer 等於 NUMBER_OF_OUTPUT_WORDS（即所有的流數據都已經發出），則將 tx_done 設置為 1。  
```v
//read_pointer pointer
always@(posedge M_AXIS_ACLK) begin                                                                            
    if(!M_AXIS_ARESETN) begin                                                                        
        read_pointer <= 0;                                                         
        tx_done <= 1'b0;                                                           
    end                                                                          
    else                                                                           
        if (read_pointer <= NUMBER_OF_OUTPUT_WORDS-1) begin                                                                      
            if (tx_en) begin
                // read pointer is incremented after every read from the FIFO          
                // when FIFO read signal is enabled.                                                                                           
                read_pointer <= read_pointer + 1;                                    
	            tx_done <= 1'b0;                                                     
            end                                                                    
        end                                                                        
	    else if (read_pointer == NUMBER_OF_OUTPUT_WORDS) begin                                                                      
            // tx_done is asserted when NUMBER_OF_OUTPUT_WORDS numbers of streaming data
	        // has been out.                                                         
	        tx_done <= 1'b1;                                                         
        end                                                                        
end  
```
  
## FIFO 讀取使能信號的生成以及從 FIFO 讀取流數據  
```v
//FIFO read enable generation 
//將 M_AXIS_TREADY 和 axis_tvalid 的邏輯與結果賦給 tx_en。
//這表示只有當 M_AXIS_TREADY 和 axis_tvalid 都為真時，才會使能 FIFO 的讀取。
assign tx_en = M_AXIS_TREADY && axis_tvalid;   
	                                                     
// Streaming output data is read from FIFO       
    always @( posedge M_AXIS_ACLK ) begin                                            
    if(!M_AXIS_ARESETN) begin                                        
        stream_data_out <= 1;                      
    end
    else if (tx_en) begin// && M_AXIS_TSTRB[byte_index]  
    //如果 tx_en 為真（即 FIFO 讀取被使能），則將 read_pointer + 1 的值賦給 stream_data_out。
    //這表示每次讀取 FIFO 時，都會讀取下一個數據。                        
    stream_data_out <= read_pointer + 32'b1;   
    end                                          
end        
```