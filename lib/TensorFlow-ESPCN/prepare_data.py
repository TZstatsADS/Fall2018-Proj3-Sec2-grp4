import numpy as np
import os
import glob
from PIL import Image
import h5py
import argparse
import random

RATIO = 2  # 放大比例
IMAGE_SIZE = 17  # 训练图片大小
STRIDE = 10  # 裁剪步长
IMAGE_CHANNEl = 3  # 图片通道
TRAIN_NUM=50 # 默认用于train的图片数
TRAIN_PATH='../../data/train_set/HR/' # 用于train的HR图像路径

def get_arguments():
    """ 
    传入参数
    """
    parser = argparse.ArgumentParser(description='EspcnNet generation script')
    parser.add_argument('--train_num', type=int, default=TRAIN_NUM,
                        help='Which model checkpoint to generate from')
    return parser.parse_args()

def show_img_from_array(img_data):
    """
    显示图片
    :param img_data:
    :return:
    """
    img = Image.fromarray(img_data)
    img.show()


def preprocess_img(file_path):
    """
    处理图片
    高清变低清，by RATIO
    :param file_path:
    :return:
    """
    img = Image.open(file_path)
    img_label = img.resize(
        ((img.size[0] // RATIO) * RATIO, (img.size[1] // RATIO) * RATIO))
    img_input = img_label.resize(
        (img_label.size[0] // RATIO, img_label.size[1] // RATIO))
    return np.asarray(img_input), np.asarray(img_label)


def make_sub_data(img_list):
    """
    将大图裁剪为小图
    :param img_list:
    :return:
    """
    sub_input_sequence = []
    sub_label_sequence = []
    num=0
    
    random.shuffle(img_list)
    for file_path in img_list:
        num+=1
        if num >args.train_num:
            break
        input_, label_ = preprocess_img(file_path)
        h, w, c = input_.shape
        if c != IMAGE_CHANNEl:
            continue
        # 裁剪图片
        for x in range(0, h - IMAGE_SIZE + 1, STRIDE):
            for y in range(0, w - IMAGE_SIZE + 1, STRIDE):
                sub_input = input_[x: x + IMAGE_SIZE,
                                   y: y + IMAGE_SIZE]
                """ useless
                sub_input = sub_input.reshape(
                    [IMAGE_SIZE, IMAGE_SIZE, IMAGE_CHANNEl]) 
                """
                sub_input = sub_input / 255.0
                sub_input_sequence.append(sub_input)

                label_x = x * RATIO
                label_y = y * RATIO
                sub_label = label_[label_x: label_x + IMAGE_SIZE * RATIO,
                                   label_y: label_y + IMAGE_SIZE * RATIO]
                """ useless 
                sub_label = sub_label.reshape(
                    [IMAGE_SIZE * RATIO, IMAGE_SIZE * RATIO, IMAGE_CHANNEl]) 
                """
                sub_label = sub_label / 255.0
                sub_label_sequence.append(sub_label)

    return sub_input_sequence, sub_label_sequence


def make_data_hf(input_, label_):
    """
    保存训练数据
    """
    h5data_dir = 'h5data'
    if not os.path.isdir(os.path.join(os.getcwd(), h5data_dir)):
        os.makedirs(os.path.join(os.getcwd(), h5data_dir))
    savepath = os.path.join(
        os.getcwd(), h5data_dir + '/train_data.h5')
    with h5py.File(savepath, 'w') as hf:
        hf.create_dataset('input', data=input_)
        hf.create_dataset('label', data=label_)


def prepare_data(dataset=TRAIN_PATH):
    """
    :param dataset:
    :return:
    """
    data_dir = os.path.join(os.getcwd(), dataset)
    filenames = glob.glob(os.path.join(data_dir, "*.jpg"))
    sub_input_sequence, sub_label_sequence = make_sub_data(filenames)

    arrinput = np.asarray(sub_input_sequence)
    arrlabel = np.asarray(sub_label_sequence)
    make_data_hf(arrinput, arrlabel)

args=get_arguments()
if __name__ == '__main__':
    prepare_data()
