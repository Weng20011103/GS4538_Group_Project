# Project 3: 利用外部中斷翻轉 PC13 LED 狀態  
此專案參考[Getting started with EXTI](https://wiki.st.com/stm32mcu/wiki/Getting_started_with_EXTI)  
  
## STM32CubeMX  
開啟`STM32CubeMX`應用程式，點擊`File`中的`New Project`  
![1.png](pictures/1.png "1.png")
  
在 Commercial Part Number 輸入`stm32f103c8t6`並在右邊選擇`stm32f103c8t6`選項，點擊右上角的`Start Project`  
![2.png](pictures/2.png "2.png")
  
在`System Core`中的`SYS`選項把`Debug`改成`Serial Wire`  
![3.png](pictures/3.png "3.png")
  
Pinout view 中在`PC13`腳位上左鍵選擇`GPIO_Output`  
![4.png](pictures/4.png "4.png")
  
Pinout view 中在`PB0`腳位上左鍵選擇`GPIO_EXTI0`  
![5.png](pictures/5.png "5.png")
  
點擊`System Core`中的`GPIO`選項  
![6.png](pictures/6.png "6.png")
  
點擊`PB0`中確保 GPIO mode 為 External Interrupt Mode with Rising edge trigger detection    
![7.png](pictures/7.png "7.png")
  
點擊`NVIC`選項將 EXTI line0 interrupt 的 Enabled 打勾  
![8.png](pictures/8.png "8.png")
  
點擊`System Core`中的`NVIC`選項，確保 EXTI line0 interrupt 的 Enabled 打勾  
![9.png](pictures/9.png "9.png")
  
點擊`Code generation`選項將 EXTI line0 interrupt 的後三項打勾  
![10.png](pictures/10.png "10.png")
  
開啟`Project Manager`，填寫 Project Name，選擇檔案位置以及將 Toolchain / IDE 選擇`MDK-ARM`  
![11.png](pictures/11.png "11.png")
  
開啟`Code Generator`，選擇`Copy only the necessary library files`  
![12.png](pictures/12.png "12.png")
  
等待程式生成完成  
![13.png](pictures/13.png "13.png")
  
按`Open Project`使用 Keil µVision5 開啟專案  
![14.png](pictures/14.png "14.png")
  
此時`STM32CubeMX`應用程式使用完畢可以關閉程式  