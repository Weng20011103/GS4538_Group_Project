# Lab 2: 設置 HDMI 輸入  
## ARM Cortex-A9  
程式碼只能在`PYNQ Z2`的`ARM A9`處理器上運行，該處理器是一種嵌入式處理器（Embedded Processor）  
  
參考: [Real-time video processing on PYNQ-Z2](https://discuss.pynq.io/t/real-time-video-processing-on-pynq-z2/7025)  
  
## 電源供應問題  
利用`USB-MICRO B`進行供電時，如果連接的是 Corsair Gaming 海盜電競 K65 RGB RAPIDFIRE 鍵盤的 USB 孔可能會有問題  
  
但是如果連接的是 Transcend 創見極速 USB 3.1 HUB 4埠集線器 (TS-HUB2K) 的話沒問題  
  
## Jupyter Notebook 程式碼  
```python
import cv2
import os
from pynq.overlays.base import BaseOverlay
from pynq.lib.video import *

base = BaseOverlay("base.bit")
hdmi_in = base.video.hdmi_in

hdmi_in.configure()
hdmi_in.start()

def cutPicture(image, x, y, x_end, y_end):
    return image[y:y_end, x:x_end]

Coordinate=[(235,770,305,840),(345,770,415,840),(840,770,905,840),(517,498,626,561),(1223,770,1293,840),(517,498,626,561),(1463,790,1670,868),(606,273,757,476)]

pictureNamesList=[]

folder_path = './process_gray'

for file_name in os.listdir(folder_path):
    image = cv2.imread(os.path.join(folder_path, file_name))
    
    if image is not None:
        pictureNamesList.insert(-1,image)
    else:
        print(f"Failed to load {file_name}")

grayscale = np.ndarray(shape=(hdmi_in.mode.height, hdmi_in.mode.width), dtype=np.uint8)

inframe = hdmi_in.readframe()

cv2.cvtColor(inframe,cv2.COLOR_BGR2GRAY, dst=grayscale)

for index,i in enumerate(Coordinate):
    for j in range(1):
        cropped_image = cutPicture(grayscale,i[0],i[1],i[2],i[3])
        gray_image = cv2.cvtColor(pictureNamesList[j], cv2.COLOR_BGR2GRAY)
        
        result = cv2.matchTemplate(cropped_image, gray_image, cv2.TM_CCOEFF_NORMED)
        min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

        if(max_val >= 0.8):
            print("work")

# Finally you must always stop the interfaces when you are done with them.
# Otherwise bad things can happen when the bitstream is reprogrammed.
hdmi_in.close()
```