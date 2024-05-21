# Project 2: USB 滑鼠模擬  
此專案參考[基于STM32CubeMX的USB鼠标例程](http://www.mcublog.cn/software/2020_03/stm32cube-mouse/)這篇文章將`STM32F103C8T6`模擬成一個`USB`滑鼠  
  
## STM32CubeMX  
開啟一個關於`STM32F103C8T6`的 STM32CubeMX Project  
![1.png](pictures/1.png "1.png")
  
在`System Core`中的`RCC`選項把`High Speed Clock (HSE)`改成`Crystal/Ceramic Resonator`  
![2.png](pictures/2.png "2.png")
  
在`System Core`中的`SYS`選項把`Debug`改成`Serial Wire`  
![3.png](pictures/3.png "3.png")
  
在`Connectivity`中的`USB_DEVICE`選項把`Device`打勾  
![4.png](pictures/4.png "4.png")
  
在`Middleware and S....`中的`USB`選項把`Class For FS IP`改成`Human Interface Device Class (HID)`  
![5.png](pictures/5.png "5.png")
  
`Device Descriptor`中有關於`USB`設備的訊息  
![6.png](pictures/6.png "6.png")
  
點擊`Clock Configuration`選項，出現`Do you want to run automatic clock issues solver ?`訊息選`OK`  
![7.png](pictures/7.png "7.png")
  
等待一段時間完成時鐘的配置  
![8.png](pictures/8.png "8.png")
  
開啟`Project Manager`，自訂`Project Name`和`Project Location`並將`Toolchain / IDE`選擇`MDK-ARM`  
![9.png](pictures/9.png "9.png")
  
開啟`Code Generator`，選擇`Copy only the necessary library files`  
![10.png](pictures/10.png "10.png")
  
開啟`GENERATE CODE`等待程式碼完成  
![11.png](pictures/11.png "11.png")
  
按`Open Folder`會切換到專案的位置  
![12.png](pictures/12.png "12.png")
  
此時`STM32CubeMX`已經使用完畢可以關閉程式  