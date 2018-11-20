import numpy as np
import math
from PIL import Image
import os

TEST_IMAGE_DIR = '../../data/test_set/LR/'
TEST_RESULT_DIR = '../../data/test_set/HR/'

def psnr(image_a, image_b):
    image_a_data = np.asarray(image_a).astype('float32')
    image_b_data = np.asarray(image_b).astype('float32')
    diff = image_a_data - image_b_data
    diff = diff.flatten('C')
    rmse = math.sqrt(np.mean(diff ** 2.))
    return 20*math.log10(255.0/rmse)


if __name__ == '__main__':
    img_list = [filename for filename in os.listdir(
        TEST_IMAGE_DIR) if filename.endswith('jpg')]
    
    hr_sr_num=0
    hr_sr_sum=0
    for img_name in img_list:
        try:
            hr_image = Image.open(
                TEST_RESULT_DIR+img_name.replace('.jpg', '.jpg'))
            sr_image = Image.open(
                TEST_RESULT_DIR+img_name.replace('.jpg', '.png'))
            # lr_image = Image.open(
            #     TEST_RESULT_DIR+img_name.replace('.jpg', '_lr.png'))
        except:
            continue
        # bi_image = lr_image.resize(sr_image.size, Image.BICUBIC)
        # lr_image = lr_image.resize(sr_image.size)

        # hr_lr_value = psnr(hr_image, lr_image)
        hr_sr_value = psnr(hr_image, sr_image)
        hr_sr_sum+=hr_sr_value
        hr_sr_num+=1
        # hr_bi_value = psnr(hr_image, bi_image)
    print("Average PSNR for ESPCN: %f" %(hr_sr_sum/hr_sr_num))
