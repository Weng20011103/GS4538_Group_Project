# GS4538 Group Project  
## 專題說明  
這份期末專題設計出一個自動化流程並以一款名為 Fate/Grand Order(FGO) 的遊戲為例子操作，以解決遊戲中一些重複且單一的問題。  
  
利用 PYNQ Z2 開發板的 HDMI 輸入以及 PMOD 功能結合影像處理、物件辨識以及滑鼠控制技術，打造出一個自動化流程可以根據畫面中內容決定目前行為，並且移動滑鼠以達到相對的功能。  
  
## 通識小組專題展示  
[專題展示](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/Demo#%E9%80%9A%E8%AD%98%E7%B5%90%E6%9E%9C%E5%B1%95%E7%A4%BA)的原理說明  
  
Youtube 示範影片:
[![YT 影片連接](demonstration.png)](https://youtu.be/71zMTQiaI8o?si=ugSa8jMhluuxNv8i)
  
## STM32 軟體安裝  
1. [STM32 ST-LINK utility](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/STM32%20%E8%BB%9F%E9%AB%94%E5%AE%89%E8%A3%9D/ST-LINK%20utility#stm32-st-link-utility-%E5%AE%89%E8%A3%9D)  
2. [STM32CubeMX](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/STM32%20%E8%BB%9F%E9%AB%94%E5%AE%89%E8%A3%9D/STM32CubeMX#stm32cubemx-%E5%AE%89%E8%A3%9D)  
3. [Keil µVision5](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/STM32%20%E8%BB%9F%E9%AB%94%E5%AE%89%E8%A3%9D/Keil%20uVision5#keil-%C2%B5vision5)  
  
## STM32F103C8T6 Project  
1. [點亮 PC13 的 LED 燈](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_1_PC13_LED#project-1-%E9%BB%9E%E4%BA%AE-pc13-%E7%9A%84-led-%E7%87%88)  
2. [USB 滑鼠模擬](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_2_USB_Mouse#project-2-usb-%E6%BB%91%E9%BC%A0%E6%A8%A1%E6%93%AC)  
3. [利用外部中斷翻轉 PC13 LED 狀態](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_3_EXTI_TogglePin#project-3-%E5%88%A9%E7%94%A8%E5%A4%96%E9%83%A8%E4%B8%AD%E6%96%B7%E7%BF%BB%E8%BD%89-pc13-led-%E7%8B%80%E6%85%8B)  
4. [利用外部中斷回報 USB 滑鼠狀態](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_4_EXTI_USB_Mouse#project-4-%E5%88%A9%E7%94%A8%E5%A4%96%E9%83%A8%E4%B8%AD%E6%96%B7%E5%9B%9E%E5%A0%B1-usb-%E6%BB%91%E9%BC%A0%E7%8B%80%E6%85%8B)  
5. [利用外部中斷回報 USB 滑鼠的任意位移狀態](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_5_EXTI_USB_Mouse_2#project-5-%E5%88%A9%E7%94%A8%E5%A4%96%E9%83%A8%E4%B8%AD%E6%96%B7%E5%9B%9E%E5%A0%B1-usb-%E6%BB%91%E9%BC%A0%E7%9A%84%E4%BB%BB%E6%84%8F%E4%BD%8D%E7%A7%BB%E7%8B%80%E6%85%8B)  
6. [利用外部中斷回報 USB 滑鼠的操作](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_6_EXTI_USB_Mouse_3#project-6-%E5%88%A9%E7%94%A8%E5%A4%96%E9%83%A8%E4%B8%AD%E6%96%B7%E5%9B%9E%E5%A0%B1-usb-%E6%BB%91%E9%BC%A0%E7%9A%84%E6%93%8D%E4%BD%9C)  
7. [編譯出來的程式大小說明](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/STM32/Project/Project_7_Program_Size#project-7-%E7%B7%A8%E8%AD%AF%E5%87%BA%E4%BE%86%E7%9A%84%E7%A8%8B%E5%BC%8F%E5%A4%A7%E5%B0%8F)  
  
## PYNQ Z2 Project  
1. [Lab 1: 安裝 Vivado 2022.1](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/PYNQ/Lab1#lab-1-%E5%AE%89%E8%A3%9D-vivado-20221)  
  
## FGO 流程  
1. [FGO 流程](https://github.com/Weng20011103/GS4538_Group_Project/tree/main/FGO#fgo-%E8%85%B3%E6%9C%AC%E6%B5%81%E7%A8%8B)  