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
