---
title: "hw 03 old r"
author: "Kendall Loh"
date: "October 8, 2018"
output: 
  html_document: 
    keep_md: yes
---


---
title: "Final HW#3"
author: "Kendall Loh"
date: "10/7/2018"
output: html_document
editor_options: 
  chunk_output_type: console
---



## 1a) Write a loop
Write a for loop that will iterate the main verse from 99 to 1. End with the last verse.

Print steps 99 to 95 (that is from 99 bottles to 95 bottles) to the console. Show the loop code and the print output in your solution. (Hint: the cat() function may be useful to concatenate the output you want.)

```r
loopvec <- 0:99

for(i in length(loopvec):96){
    if(i > 1){
    cat(loopvec[i], "bottles of beer on the wall\n", loopvec[i], "bottles of beer!\n If one of those bottles should happen to fall\n", loopvec[i]-1, "bottles of beer on the wall\n\n")
  }
    else{
    print('No more bottles of beer on the wall, no more bottles of beer. Go to the store and buy some more, 99 bottles of beer on the wall...')
  }
}
```

```
## 99 bottles of beer on the wall
##  99 bottles of beer!
##  If one of those bottles should happen to fall
##  98 bottles of beer on the wall
## 
## 98 bottles of beer on the wall
##  98 bottles of beer!
##  If one of those bottles should happen to fall
##  97 bottles of beer on the wall
## 
## 97 bottles of beer on the wall
##  97 bottles of beer!
##  If one of those bottles should happen to fall
##  96 bottles of beer on the wall
## 
## 96 bottles of beer on the wall
##  96 bottles of beer!
##  If one of those bottles should happen to fall
##  95 bottles of beer on the wall
## 
## 95 bottles of beer on the wall
##  95 bottles of beer!
##  If one of those bottles should happen to fall
##  94 bottles of beer on the wall
```


Showing the 'full' loop per the TA comments on piaza that we should copy paste.

```r
loopvec <- 0:99
output <- str(length(loopvec))
for(i in length(loopvec):1){
    if(i > 1){
    cat(loopvec[i], "bottles of beer on the wall\n", loopvec[i], "bottles of beer!\n If one of those bottles should happen to fall\n", loopvec[i]-1, "bottles of beer on the wall\n\n")
  }
    else{
    cat('No more bottles of beer on the wall, no more bottles of beer. Go to the store and buy some more, 99 bottles of beer on the wall...')
  }
}
```



## 1b) Convert loop to a function
Now convert the loop into a function. Generalize to any type of liquid and a variable number of bottles (but assume the number of bottles entered is larger or equal to 3). Set the default values of your function arguments to the original song. Show the function code in your solution and print the output using the following values: `3`, `Whiskey`.

```r
print_lyrics <- function(x, y){
  for (x in x:3)
   cat(x, "bottles of", y, "on the walls\n", x, "bottles of", y, "!\n If one of those bottles should happen to fall\n", (x-1), "bottles of", y, "on the wall\n\n")
  }


print_lyrics(3, 'whiskey')
```

```
## 3 bottles of whiskey on the walls
##  3 bottles of whiskey !
##  If one of those bottles should happen to fall
##  2 bottles of whiskey on the wall
```


## 1c) Add error check
Add an error check to produce a warning when a user passes a non-numeric input to the number of bottles.


```r
print_lyrics1 <- function(x, y) {
  if (is.numeric(x)){
    print(print_lyrics(x, y))}
    else {
      print('ERROR - NON NUMERIC INPUT')
    }
  }


print_lyrics1('six', 'whiskey')
```

```
## [1] "ERROR - NON NUMERIC INPUT"
```

## 2) Draw a plot using a loop
### a) Plot with horizontal lines
### b) Add vertical lines
### c) Add points
### d) Convert to function




```r
plot(1, type="n", main="Static Example", xlab="X AXIS LABEL", ylab="Y AXIS LABEL", xlim = c(0, 10), ylim = c(0, 10))

length_x <- c(0:10)
length_x1 <- 10
#horizontal
for (val in (length_x)) {
  lines(x = c(0, 10), y = c(val, val))
}
#vertical
for (i in (length_x)) {
  lines(x = c(i,i), y = c(0,10))
}

#right hand
for(i in (length_x)) {
  points(x = i, y = i)
}
#left hand
for(i in (length_x)) {
  points(x = i, y = length_x1-i)
}
```

![](hw03_FINAL_files/figure-html/unnamed-chunk-5-1.png)<!-- -->



```r
convert_plot <- function(x, y) {
  plot(1, type="n", main="Generalized function", xlab="X LABEL", ylab="Y LABEL", xlim = c(0, x), ylim = c(0, y)) 

for (i in 0:x){
  lines(x = c(0, x), y = c(i, i))
}
for(i in 0:x) {
  lines(x = c(i, i), y = c(0,x))
}
for(i in 0:x) {
  points(x = i, y = i)
}
for(i in 0:x) {
  points(x = i, y = x-i)}
}


convert_plot(13, 13)
```
