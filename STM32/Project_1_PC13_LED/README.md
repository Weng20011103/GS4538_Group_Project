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