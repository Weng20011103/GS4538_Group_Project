# 利用 STM32 模擬 USB 滑鼠  
利用官方的 STM32F103RB-Nucleo 倉庫範例改寫  
  
## USBD_HID_SendReport 程式  
位於`\Middlewares\ST\STM32_USB_Device_Library\Class\HID\Src\usbd_hid.c`中  
  
此函數能夠發送滑鼠的動作  
```c
/**
  * @brief  USBD_HID_SendReport
  *         Send HID Report
  * @param  pdev: device instance
  * @param  buff: pointer to report
  * @retval status
  */
uint8_t USBD_HID_SendReport(USBD_HandleTypeDef  *pdev,
                            uint8_t *report,
                            uint16_t len)
{
  USBD_HID_HandleTypeDef     *hhid = (USBD_HID_HandleTypeDef *)pdev->pClassData;

  if (pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    if (hhid->state == HID_IDLE)
    {
      hhid->state = HID_BUSY;
      USBD_LL_Transmit(pdev,
                       HID_EPIN_ADDR,
                       report,
                       len);
    }
  }
  return USBD_OK;
}
```
  
`USBD_LL_Transmit`位於`Middlewares\ST\STM32_USB_Device_Library\Core\Src`中的`usbd_conf_template.c`  
```c
/**
  * @brief  Transmits data over an endpoint.
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @param  pbuf: Pointer to data to be sent
  * @param  size: Data size
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_LL_Transmit(USBD_HandleTypeDef *pdev, uint8_t ep_addr,
                                    uint8_t *pbuf, uint16_t size)
{
  return USBD_OK;
}
```