## Superresolution based on ESCPN

### Installation
```
pip3 install -r requirements.txt
```

### Usage

Train the model(after put the train_HR images in folder images/):
```
python3 train.py
```
Superresolution(after put the test_LR images in folder test_images/):
```
python3 rebuild.py
```
Evaluation(after put the test_HR images(jpg) in the folder result/):
```
python3 psnr.py
```

### Reference

Efficient Sub-Pixel Convolutional Neural Network(ESCPN)  
https://arxiv.org/pdf/1609.05158.pdf  
TensorFlow implementation of ESCPN  
https://github.com/kweisamx/TensorFlow-ESPCN  
https://github.com/Nyloner/TensorFlow-ESPCN  