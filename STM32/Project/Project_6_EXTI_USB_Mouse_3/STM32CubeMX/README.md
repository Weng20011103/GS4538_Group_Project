# Project 6: 利用外部中斷回報 USB 滑鼠的操作  
## STM32CubeMX  
在`System Core`中的`SYS`選項把`Debug`改成`Serial Wire`  
![1.png](pictures/1.png "1.png")
  
在`System Core`中的`RCC`選項把`High Speed Clock (HSE)`改成`Crystal/Ceramic Resonator`  
![2.png](pictures/2.png "2.png")
  
在`Pinout view`中完成下面三項操作  
1. 在`PB0`腳位上左鍵選擇`GPIO_EXTI0`  
2. 在`PB1`腳位上左鍵選擇`GPIO_EXTI1`  
3. 在`PB5`腳位上左鍵選擇`GPIO_EXTI5`  
  
![3.png](pictures/3.png "3.png")
  
在`Pinout view`中完成下面八項操作  
1. 在`PA0`腳位上左鍵選擇`GPIO_Input`  
2. 在`PA1`腳位上左鍵選擇`GPIO_Input` 
3. 在`PA2`腳位上左鍵選擇`GPIO_Input`  
4. 在`PA3`腳位上左鍵選擇`GPIO_Input` 
5. 在`PA4`腳位上左鍵選擇`GPIO_Input`  
6. 在`PA5`腳位上左鍵選擇`GPIO_Input` 
7. 在`PA6`腳位上左鍵選擇`GPIO_Input`  
8. 在`PA7`腳位上左鍵選擇`GPIO_Input` 
  
![4.png](pictures/4.png "4.png")
  
點擊`System Core`中的`GPIO`選項  
1. 把`PB0`的 GPIO mode 改為`External Interrupt Mode with Falling edge trigger detection`  
2. 把`PB1`的 GPIO mode 改為`External Interrupt Mode with Falling edge trigger detection`  
3. 把`PB5`的 GPIO mode 改為`External Interrupt Mode with Falling edge trigger detection`  
  
![5.png](pictures/5.png "5.png")
  
點擊`NVIC`選項  
1. 將`EXTI line0 interrupt`的 Enabled 打勾  
2. 將`EXTI line1 interrupt`的 Enabled 打勾  
3. 將`EXTI line[9:5] interrupts`的 Enabled 打勾  
  
![6.png](pictures/6.png "6.png")
  
在`Connectivity`中的`USB_DEVICE`選項把`Device (FS)`打勾  
![7.png](pictures/7.png "7.png")
  
在`Middleware and S....`中的`USB`選項把`Class For FS IP`改成`Human Interface Device Class (HID)`  
![8.png](pictures/8.png "8.png")
  
點擊`Clock Configuration`選項，出現`Do you want to run automatic clock issues solver ?`訊息選`Yes`  
![9.png](pictures/9.png "9.png")
  
等待一段時間完成時鐘的配置  
![10.png](pictures/10.png "10.png")
  
開啟`Project Manager`，自訂`Project Name`和`Project Location`並將`Toolchain / IDE`選擇`MDK-ARM`  
![11.png](pictures/11.png "11.png")
  
開啟`Code Generator`，選擇`Copy only the necessary library files`  
![12.png](pictures/12.png "12.png")
  
開啟`GENERATE CODE`等待程式碼完成，按`Open Project`使用`Keil µVision5`開啟專案  
![13.png](pictures/13.png "13.png")
  
此時`STM32CubeMX`應用程式使用完畢可以關閉程式  