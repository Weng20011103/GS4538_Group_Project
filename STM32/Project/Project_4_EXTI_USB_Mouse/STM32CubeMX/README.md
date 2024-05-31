# Project 4: 利用外部中斷模擬 USB 滑鼠  
## STM32CubeMX  
在`System Core`中的`SYS`選項把`Debug`改成`Serial Wire`  
![1.png](pictures/1.png "1.png")
  
在`Pinout view`中完成下面兩項操作  
1. 在`PB0`腳位上左鍵選擇`GPIO_EXTI0`  
2. 在`PB1`腳位上左鍵選擇`GPIO_EXTI1`  
![2.png](pictures/2.png "2.png")
  
點擊`System Core`中的`GPIO`選項  
1. 把`PB0`的 GPIO mode 改為`External Interrupt Mode with Falling edge trigger detection`  
2. 把`PB1`的 GPIO mode 改為`External Interrupt Mode with Falling edge trigger detection`  
![3.png](pictures/3.png "3.png")
  
點擊`NVIC`選項  
1. 將`EXTI line0 interrupt`的 Enabled 打勾  
2. 將`EXTI line1 interrupt`的 Enabled 打勾  
![4.png](pictures/4.png "4.png")
  
在`System Core`中的`RCC`選項把`High Speed Clock (HSE)`改成`Crystal/Ceramic Resonator`  
![5.png](pictures/5.png "5.png")
  
在`Connectivity`中的`USB_DEVICE`選項把`Device (FS)`打勾  
![6.png](pictures/6.png "6.png")
  
在`Middleware and S....`中的`USB`選項把`Class For FS IP`改成`Human Interface Device Class (HID)`  
![7.png](pictures/7.png "7.png")
  
點擊`Clock Configuration`選項，出現`Do you want to run automatic clock issues solver ?`訊息選`Yes`  
![8.png](pictures/8.png "8.png")
  
等待一段時間完成時鐘的配置  
![9.png](pictures/9.png "9.png")
  
開啟`Project Manager`，自訂`Project Name`和`Project Location`並將`Toolchain / IDE`選擇`MDK-ARM`  
![10.png](pictures/10.png "10.png")
  
開啟`Code Generator`，選擇`Copy only the necessary library files`  
![11.png](pictures/11.png "11.png")
  
開啟`GENERATE CODE`等待程式碼完成，按`Open Project`使用`Keil µVision5`開啟專案  
![12.png](pictures/12.png "12.png")
  
此時`STM32CubeMX`應用程式使用完畢可以關閉程式  