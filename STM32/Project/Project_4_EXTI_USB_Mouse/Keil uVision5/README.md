# Project 4: 利用外部中斷模擬 USB 滑鼠  
## Keil µVision5  
開啟`Application/User/Core`中的`main.c`  
![1.png](pictures/1.png "1.png")
  
在`USER CODE BEGIN Includes`和`USER CODE END Includes`中新增下方程式碼  
```c
#include "usbd_hid.h"
```
![2.png](pictures/2.png "2.png")
  
在`USER CODE BEGIN PTD`和`USER CODE END PTD`中新增下方程式碼  
```c
uint8_t MouseData01[4] = {0,0,0,0};
extern USBD_HandleTypeDef hUsbDeviceFS;
```
![3.png](pictures/3.png "3.png")
  
在`/* USER CODE BEGIN 4 */`和`/* USER CODE END 4 */`中新增下方程式碼
```c
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  if(GPIO_Pin == GPIO_PIN_0) {
    MouseData01[1] = 0x32;
		MouseData01[2] = 0x00;
		USBD_HID_SendReport(&hUsbDeviceFS, (uint8_t*)&MouseData01, sizeof(MouseData01));
  } else if(GPIO_Pin == GPIO_PIN_1) {
    MouseData01[1] = 0x00;
		MouseData01[2] = 0x32;
		USBD_HID_SendReport(&hUsbDeviceFS, (uint8_t*)&MouseData01, sizeof(MouseData01));
  } else {
      __NOP();
  }
}
```
![4.png](pictures/4.png "4.png")
  
按下`Build`的圖示  
![5.png](pictures/5.png "5.png")
  
把板子接上燒錄器連接電腦進行燒錄  
![6.png](pictures/6.png "6.png")
  
此時`Keil µVision5`應用程式使用完畢可以關閉程式  