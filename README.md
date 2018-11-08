# Project: Can you unscramble a blurry image? 
![image](figs/example.png)

### [Full Project Description](doc/project3_desc.md)

Term: Fall 2018

+ Team # 4
+ Team members
	+ Jay  Mu
	+ Fangqi  Ouyang
	+ Yang Yang
	+ Han Gao 
	+ Zuleimy Alcantara

+ Project summary: In this project, we created a classification engine for enhance the resolution of images. 
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement.

Jay  Mu - Baseline Super-resolution, Feature, writing images, tune model_values of GBM model.
Fangqi  Ouyang -Xgboost-implemention and parameter tuning, prepared presentation 
Yang Yang - team leader, parallel model, baseline model and model improvement, ESPCN model
Han Gao - Tune Baseline, conduct MSE-PSNR evaluation, build Nearest Neighbor, Bilinear and Bicubic model, prepared presentation materials. 
Zuleimy Alcantara - worked on presentation materials, readme file, and report summary. 

Our baseline model

We ran feature extraction by sampling 1000 points from the LR image pixels and takin the 8 neighboring pixels for each point as features. 

Our Extraction time is 27.994s with an optimal depth of 11. Our cross-validation error is 0.0024515.
It is faster than the nerest-neighbor method which uses the value of nearby translated pixel values for the output pixel values. There was a resolution time od 109.8 s and a MSE of 0.004035 and PSNR of 25.3926.
It is also faster than bilinear interpolation which uses the weighted average of two translated pixel values for each output pixel value. The extraction time for bileanear is 121.2 s and the MSE is 0.003277 and the PSNR is 26.3723.

Additionally, it is also faster than bicubic interpolation which uses the weighted average of four translated pixel values for each output pixel value. The extraction time for bileanear is 183.6 s and the MSE is 0.004927 and the PSNR is 24.1553. 
  
  
  
Our improved models

**XGBooost**-

Advantages: 

-More regularized model formation to control over-fitting 

-Extremely faster  training process 



Controlled parameters: depth={4,5,6,7,8,9,10,11), eta={0.02,0.04,0.06,0.08,0.1}

Largest Depth among 12 classifiers = 11

Largest eta among 12 classifiers= 0.08

Training Time: 303s



Feature Extraction Time 105.349s

Superresolution time 5043s

The MSE of this model is 0.004146

The psnr is 25.0000



**ESPCN**

ESPCN uses  subpixel convolutional neural network layer for upscaling. This layer essentially uses regular convolutional layers followed by a specific type of image reshaping called a phase shift. In other words, instead of putting zeros in between pixels and having to do extra computation, they calculate convolutions in lower resolution and resize the resulting map into an upscaled image in the end. This way, no meaningless zeros are necessary. This makes it faster than SRCNN Network. SRCNN Network does more convolutions in high resolution, as it goes through CNN; this is more costly.

The feature extraction  time for this model was

The training time

Super resolution time

The MSE  is  0.002452
The psnr is 28.11563

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
??? lib/
??? data/
??? doc/
??? figs/
??? output/
```
The **lib** directory contains various files with function definitions .

The **data** directory contains data used in the analysis. This is treated as read only. It has a file with set of test and training data.

The **doc** directory contains the project summary report. It has a summary html file with summary of the content of the files in lib.

The **figs** directory contains the example file.

The **output** directory contains simulation output and processed datasets.

Please see each subfolder for a README file.

## Running on High Performance Computing (Columbia Habanero)
After copy this project into HPC, `cd doc`  
In doc/   
```
sbatch knitrR.submit
```
See whether this submitted work is running, `squeue -u your_uni`.  

## Running Time Calculation
In R
```
> tm0=proc.time()
> dat_train <- feature(train_LR_dir, train_HR_dir)
> tm_feature_train=proc.time()-tm0
> print(tm_feature_train)
```
display
```
   user  system elapsed 
  12.68   10.70   78.61 
```

So we use elapsed time as our running time.
