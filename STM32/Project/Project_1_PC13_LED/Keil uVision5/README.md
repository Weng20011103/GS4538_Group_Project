# Project 1: 點亮 PC13 的 LED 燈    
此專案將把`STM32F103C8T6`的`PC13`的 LED 燈點亮  
  
## Keil µVision5  
`Keil µVision5`提示有文件缺失  
![1.png](pictures/1.png "1.png")
  
專案需要`Keil:STM32F1xx_DFP@2.3.1`  
![2.png](pictures/2.png "2.png")
  
選擇`OK`  
![3.png](pictures/3.png "3.png")
  
等待右下方進度條跑完  
![6.png](pictures/6.png "6.png")
  
安裝完成  
![7.png](pictures/7.png "7.png")
  
回到`Keil µVision5`點擊重新載入  
![8.png](pictures/8.png "8.png")
  
`Keil µVision5`介面如下  
![9.png](pictures/9.png "9.png")
  
點開`Application/User/Core`中的`main.c`  
![10.png](pictures/10.png "10.png")
  
操控 GPIO 的函數 `HAL_GPIO_WritePin` 位於 `Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c`中  
![11.png](pictures/11.png "11.png")
  
延遲時間的函數 `HAL_Delay` 位於 `Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c`中  
![12.png](pictures/12.png "12.png")
  
將下方程式寫入`main.c`中 **注意程式的位置**  
```c
HAL_GPIO_WritePin(GPIOC, GPIO_PIN_13, GPIO_PIN_SET);
HAL_Delay(500);
HAL_GPIO_WritePin(GPIOC, GPIO_PIN_13, GPIO_PIN_RESET);
HAL_Delay(500);
```
**圖中 GPIOC 打錯成 GPIOA**
![13.png](pictures/13.png "13.png")
  
按下`Build`的圖示  
![14.png](pictures/14.png "14.png")
  
出現`Target uses ARM-Compoler 'Default Compiler Version 5' which is not available`錯誤  
![15.png](pictures/15.png "15.png")
  
按下`Options for Target...`的圖示  
![16.png](pictures/16.png "16.png")
  
在`Target`中的`ARM Compiler`選擇`Use default compiler version 6`後重新`Build`一次  
![17.png](pictures/17.png "17.png")
  
按下`Load`的圖示  
![18.png](pictures/18.png "18.png")
  
出現`Not a genuine ST Device! Abort connection`錯誤 **看的懂英文應該知道意思吧**  
![19.png](pictures/19.png "19.png")
  
錯誤後續  
![20.png](pictures/20.png "20.png")
  
因錯誤停止下載  
![21.png](pictures/21.png "21.png")
  
按下`Options for Target...`的圖示  
![22.png](pictures/22.png "22.png")
  
在`Debug`中選擇右邊的`Settings`  
![23.png](pictures/23.png "23.png")
  
把`Enable`取消打勾    
![24.png](pictures/24.png "24.png")
  
重新按下`Load`的圖示後成功燒錄即可看到 LED 閃爍的效果  
![25.png](pictures/25.png "25.png")