# Lab 7: Vivado 一端 M_AXIS IP 範例新增        
## 開啟 Vivado 應用程式  
點擊`Manage IP`  
![1.png](pictures/1.png "圖一")
  
點擊`New IP Location...`  
![2.png](pictures/2.png "圖二")
  
點擊`Next`  
![3.png](pictures/3.png "圖三")
  
點擊 Part 旁的`...`圖示  
![4.png](pictures/4.png "圖四")
  
點擊`Boards`  
![5.png](pictures/5.png "圖五")
  
選擇`PYNQ Z2`板子選項後點擊`OK`  
![6.png](pictures/6.png "圖六")
  
點擊 IP location 旁的`...`圖示  
![7.png](pictures/7.png "圖七")
  
自訂 IP location 後點擊`Select`選項  
![8.png](pictures/8.png "圖八")
  
點擊`Finish`  
![9.png](pictures/9.png "圖九")
  
## 創建 IP  
在`Tools`中選擇`Create and Package New IP...`  
![10.png](pictures/10.png "圖十")
  
點擊`Next`  
![11.png](pictures/11.png "圖十一")
  
選擇`Create a new AXI4 peripheral`選項後點擊`Next`  
![12.png](pictures/12.png "圖十二")
  
維持預設狀態，點擊`Next`  
![13.png](pictures/13.png "圖十三")
  
此時頁面如圖十四
![14.png](pictures/14.png "圖十四")
  
## 調整 IP 設定  
將`Interface Type`改成`Stream`  
![15.png](pictures/15.png "圖十五")
  
將`Interface Mode`改成`Master`  
![16.png](pictures/16.png "圖十六")
  
此時頁面如圖十七
![17.png](pictures/17.png "圖十七")
  
將`Name`改成`M_AXIS`後點擊`Next`  
![18.png](pictures/18.png "圖十八")
  
點擊`Finish`  
![19.png](pictures/19.png "圖十九")
  
此時可以離開 Vivado 應用程式  
![20.png](pictures/20.png "圖二十")
  
## IP 程式碼  
在指定的 IP 位置會產生三個資料夾  
![21.png](pictures/21.png "圖二十一")
  
程式碼位於`ip_repo/myip_1.0/hdl`之中  
![22.png](pictures/22.png "圖二十二")
  
在`myip_v1_0_M_AXIS.v`已經有示範的程式碼  
![23.png](pictures/23.png "圖二十三")
  
## 參考影片  
[ZYNQ Training - session 07](https://www.youtube.com/playlist?list=PL_FtLeLH_hY2Q3E4mTT9W5ebPao6uwkC4)  