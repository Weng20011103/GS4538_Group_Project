# Lab 8: Vivado 一端 M_AXIS IP 範例模擬  
## 開啟 Vivado 應用程式  
點擊`Create Project`  
![1.png](pictures/1.png "圖一")
  
點擊`Next`  
![2.png](pictures/2.png "圖二")
  
自訂`Project name`和`Project location`後點擊`Next`  
![3.png](pictures/3.png "圖三")
  
勾選`Do not specify sources at this time`後點擊`Next`  
![4.png](pictures/4.png "圖四")
  
選擇`PYNQ Z2`板子選項後點擊`Next`  
![5.png](pictures/5.png "圖五")
  
點擊`Finsih`  
![6.png](pictures/6.png "圖六")
  
## Block Design 創建  
點擊`Create Block Design`  
![7.png](pictures/7.png "圖七")
  
維持預設狀態，點擊`OK`  
![8.png](pictures/8.png "圖八")
  
點擊`Settings`  
![9.png](pictures/9.png "圖九")
  
將 IP 選項展開後選`Repository`  
![10.png](pictures/10.png "圖十")
  
點擊`Add`圖標  
![11.png](pictures/11.png "圖十一")
  
選擇`myip_1.0`資料夾後按`Select`  
![12.png](pictures/12.png "圖十二")
  
點擊`OK`  
![13.png](pictures/13.png "圖十三")
  
點擊`OK`  
![14.png](pictures/14.png "圖十四")
  
在`Diagram`中右鍵點擊`Add IP...`  
![15.png](pictures/15.png "圖十五")
  
找到`myip_v1.0`後左鍵點擊兩下加入 Diagram 中  
![16.png](pictures/16.png "圖十六")
  
此時頁面如圖十七
![17.png](pictures/17.png "圖十七")
  
在`m_axis_aclk`上點擊右鍵，點擊`Create Port...`  
![18.png](pictures/18.png "圖十八")
  
維持預設，點擊`OK`  
![19.png](pictures/19.png "圖十九")
  
在`m_axis_aresetn`上點擊右鍵，點擊`Create Port...`  
![20.png](pictures/20.png "圖二十")
  
維持預設，點擊`OK`  
![21.png](pictures/21.png "圖二十一")
  
在`M_AXIS`上點擊右鍵，點擊`Create Interface Port...`  
![22.png](pictures/22.png "圖二十二")
  
維持預設，點擊`OK`  
![23.png](pictures/23.png "圖二十三")
  
此時 Vivado 頁面如圖二十四  
![24.png](pictures/24.png "圖二十四")
  
## 進行模擬設定  
切換至`Sources`，展開`Design Sources`  
![25.png](pictures/25.png "圖二十五")
  
在`design_1.bd`上點擊右鍵，點擊`Create HDL Wrapper...`  
![26.png](pictures/26.png "圖二十六")
  
選擇`Let Vivado manage wrapper and auto-update`選項，點擊`OK`  
![27.png](pictures/27.png "圖二十七")
  
點擊`Add Sources`  
![28.png](pictures/28.png "圖二十八")
  
選擇`Add or create simulation sources`選項，點擊`Next`  
![29.png](pictures/29.png "圖二十九")
  
點擊`Create File`  
![30.png](pictures/30.png "圖三十")
  
自訂檔案名稱後點擊`OK`  
![31.png](pictures/31.png "圖三十一")
  
點擊`Finish`  
![32.png](pictures/32.png "圖三十二")
  
點擊`OK`  
![33.png](pictures/33.png "圖三十三")
  
點擊`Yes`  
![34.png](pictures/34.png "圖三十四")
  
將`Simulation Sources`和`sim_1`展開  
![35.png](pictures/35.png "圖三十五")
  
在剛剛新增的檔案上右鍵，選擇`Set as Top`  
![36.png](pictures/36.png "圖三十六")
  
在剛剛新增的檔案上左鍵兩下來開啟檔案  
![37.png](pictures/37.png "圖三十七")
  
把下方的程式碼貼到檔案中，按 Ctrl + S 存檔  
```v
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
```

出現提示訊息，選擇`Automatically pick new top module`後點擊`OK`  
![38.png](pictures/38.png "圖三十八")
  
點擊`Run Simulation`  
![39.png](pictures/39.png "圖三十九")
  
點擊`Run Behavioral Simulation`  
![40.png](pictures/40.png "圖四十")
  
如果出現此訊息點`允許`  
![41.png](pictures/41.png "圖四十一")
  
點擊`Float`圖示將模擬視窗彈出  
![42.png](pictures/42.png "圖四十二")
  
點擊放大視窗圖示調整大小  
![43.png](pictures/43.png "圖四十三")
  
點擊`Zoom Fit`圖示調整波形  
![44.png](pictures/44.png "圖四十四")
  
圖四十五即為`Run Behavioral Simulation`的結果  
![45.png](pictures/45.png "圖四十五")
  
自行摸索模擬結果  
![46.png](pictures/46.png "圖四十六")
  
## 參考影片  
[ZYNQ Training - session 07](https://www.youtube.com/playlist?list=PL_FtLeLH_hY2Q3E4mTT9W5ebPao6uwkC4)  