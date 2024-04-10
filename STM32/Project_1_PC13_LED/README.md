# Project 1: 點亮 PC13 的 LED 燈    
此專案將把`STM32F103C8T6`的`PC13`的 LED 燈點亮  
  
## STM32CubeMX  
開啟`STM32CubeMX`點擊`New Project`  
![1.png](pictures/1.png "1.png")
  
出現`Error during Data Refresh`報錯  
![2.png](pictures/2.png "2.png")
  
等待一段時間會跳出此頁面  
![3.png](pictures/3.png "3.png")
  
在 Commercial Part Number 輸入`stm32f103c8t6`並在右邊選擇`stm32f103c8t6`選項  
![4.png](pictures/4.png "4.png")
  
點擊右上角的 Start Project  
![5.png](pictures/5.png "5.png")
  
會出現下圖  
![6.png](pictures/6.png "6.png")
  
展開`System Core`之中的`SYS`選擇`Serial Wire`選項
![7.png](pictures/7.png "7.png")
  
將`System Core`之中的`RCC`的 High Speed Clock 選擇`Crystal/Ceramic Resonator`選項
![8.png](pictures/8.png "8.png")
  
Pinout view 中在`PC13`腳位上左鍵選擇`GPIO_Output`  
![9.png](pictures/9.png "9.png")
  
此時 Pinout view 如下所示  
![10.png](pictures/10.png "10.png")
  
右鍵在`PC13`腳位選擇`Enter User Label`  
![11.png](pictures/11.png "11.png")
  
輸入自己想要的名稱  
![12.png](pictures/12.png "12.png")
  
改名成功  
![13.png](pictures/13.png "13.png")
  
在`System Core`選擇`GPIO`能看到 GPIO 配置  
![14.png](pictures/14.png "14.png")
  
開啟`Clock Configuration`  
![15.png](pictures/15.png "15.png")
  
改紅框中的東西  
![16.png](pictures/16.png "16.png")
  
開啟`Project Manager`  
![17.png](pictures/17.png "17.png")
  
填寫 Project Name，選擇檔案位置以及將 Toolchain / IDE 選擇`MDK-ARM`  
![18.png](pictures/18.png "18.png")
  
開啟`Code Generator`  
![19.png](pictures/19.png "19.png")
  
選擇`Copy only the necessary library files`  
![20.png](pictures/20.png "20.png")
  
開啟`GENERATE CODE`  
![21.png](pictures/21.png "21.png")
  
按`Yes`安裝依賴文件  
![22.png](pictures/22.png "22.png")
  
跳出登入要求  
![23.png](pictures/23.png "23.png")
  
登入帳號  
![24.png](pictures/24.png "24.png")
  
等待下載完成  
![25.png](pictures/25.png "25.png")
  
按`Open Project`使用 Keil µVision5 開啟專案  
![26.png](pictures/26.png "26.png")