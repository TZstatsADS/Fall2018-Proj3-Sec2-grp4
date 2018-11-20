import tensorflow as tf
import os

import prepare_data
from espcn import ESPCN


TEST_IMAGE_DIR = '../../data/test_set/LR/'
TEST_RESULT_DIR = '../../data/test_set/HR/'

def rebuild(img_list):
    """
    图像超分辨率重建
    :return:
    """
    
    with tf.Session() as sess:
        espcn = ESPCN(sess,
                      is_train=False,
                    #   image_height=image_height,
                    #   image_width=image_width,
                      image_channel=prepare_data.IMAGE_CHANNEl,
                      ratio=prepare_data.RATIO)
        espcn.generate(img_list)

if __name__ == '__main__':
    img_list = [filename for filename in os.listdir(
        TEST_IMAGE_DIR) if filename.endswith('jpg')]
    rebuild(img_list)
