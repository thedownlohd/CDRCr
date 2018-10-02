---
title: "HW_02"
author: "Kendall Loh"
date: "10/1/2018"
output:
  html_document:
    keep_md: yes
---


# Homework 02 - Data Wrangling

## Kendall Loh

### Library Setup




### Read In Data






### Selection of Data and Tidying

#### 1. Remove all columns you do not need for the analysis.








#### 2. Select the following variables and remove all others: Binge Drinking (Overall, Male, Female), and Poverty (Overall)



#### 3. Convert the dataset to a tidy data set using the commands from the tidyr package



#### 4. Rename the variables to follow the format below. `state`, `stateabb`, `year`, `binge_all`, `binge_male`, `binge_female`, `poverty`]. Save the cleaned dataset as binge_clean.csv.



### Data Transformation and Summary Results

#### 5. Produce a table that shows the `overall`, `female` and `male` binge drinking prevalences across U.S. states in the most recent year of data for the Top 10 binge drinking states. (i.e., the ones with the highest prevalence in the overall population).




```r
print(Top_10_Drinking_Table)
```

```
## 
## 
## state                  stateabb    year   binge_all   binge_female   binge_male
## ---------------------  ---------  -----  ----------  -------------  -----------
## District of Columbia   DC          2016        25.6           21.3         30.5
## North Dakota           ND          2016        24.8           17.2         32.1
## Wisconsin              WI          2016        24.6           19.5         29.7
## Minnesota              MN          2016        21.3           16.2         26.5
## Iowa                   IA          2016        21.2           15.4         27.1
## Guam                   GU          2016        20.7           11.2         29.8
## Nebraska               NE          2016        20.0           13.1         27.2
## Illinois               IL          2016        19.9           14.5         25.6
## Pennsylvania           PA          2016        19.4           13.8         25.3
## Montana                MT          2016        18.9           13.0         24.9
```

#### 6. Make a scatterplot showing the correlation between the overall `poverty` prevalence in a state, and the prevalence of binge drinking in the `overall` population. *Comment Briefly*





![](KendalL_Loh_HW2_files/figure-html/unnamed-chunk-11-1.png)<!-- -->![](KendalL_Loh_HW2_files/figure-html/unnamed-chunk-11-2.png)<!-- -->

Above are two plots, one for the correlation between poverty rates and binge drinking across all 50 states and one for the poverty rate of a single state, which in this case is Alaska. As you can see, there does not appear to be a correlation between poverty drinking and binge drinking. Interestingly, judging from the top 5 and 10 tables, the top binge drinking states vary widely, from rural to urban, different environments, weather, etc. 

#### 7. Calculate the average annual growth rates (in percent) of `overall` binge drinking across states for the years the data is available. 

##### Suggestion: group the data by state, and use the `first()` and `last()` commands in the `summarize` command followed by dividing the calculated percentage increase by the number of years. provide a table of the **5 states with the largest increases** and the **5 states with the largest decreases** in `overall` binge drinking prevalence over the time period.





```r
k_large_inc
```



state             ave_growth
---------------  -----------
Tennessee          0.5166667
Guam               0.4000000
South Carolina     0.2333333
West Virginia      0.2000000
Pennsylvania       0.1833333

```r
k_small_inc
```



state           ave_growth
-------------  -----------
Oklahoma        -0.7833333
Rhode Island    -0.6333333
Delaware        -0.5500000
Georgia         -0.5500000
Illinois        -0.5166667


