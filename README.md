# Project: Can you unscramble a blurry image? 
![image](figs/example.png)

### [Full Project Description](doc/project3_desc.md)

Term: Fall 2018

+ Team #
+ Team members
	+ team member 1
	+ team member 2
	+ team member 3
	+ team member 4
	+ team member 5

+ Project summary: In this project, we created a classification engine for enhance the resolution of images. 
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.


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