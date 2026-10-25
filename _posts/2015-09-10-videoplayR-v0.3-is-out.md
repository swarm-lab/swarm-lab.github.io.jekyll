---
title: videoplayR v0.3 is out!
date: 2015-09-10
author: Simon Garnier
layout: post
type: post
category:
    - blog
    - r
published: true

---

The people who know me a bit are very much aware of the fact that I am an avid [R](http://www.r-project.org) user AND proselyte. I perform all my data processing and visualization in R; I write reports and presentations in R; I even write R packages just for the pleasure of doing it (for instance, I created the [`editR`](https://github.com/swarm-lab/editR) package essentially to see how easy it would be to build a complete web-application with R. Hint: it's not as hard as I thought it would be).

While R is serving me very well, it always had one big limitation: it cannot process videos. This forced me to use Matlab (ew!) to develop computer vision scripts and applications for processing the videos from our behavioral experiments. Now, I do not have anything against Matlab in particular (besides the fact that it is ridiculously expensive), but I would rather keep my entire data processing workflow within R as much as possible, which meant that I had to either wait for someone to finally develop a computer vision library for R, or develop it myself. And so, this is how [`videoplayR`](https://github.com/swarm-lab/videoplayR) came to be.

![Trajectories of three ants tracked with `videoplayR`](/img/posts/2015-09-10-videoplayR-v0.3-is-out/tracks.png){: .wrap-around-right}

`videoplayR` is an embryo of a computer vision library for R. It is built upon a powerful C++ image and video processing library called [OpenCV](http://opencv.org/). I used the fantastic [`Rcpp`](http://www.rcpp.org/) suite of R packages to interface `OpenCV` with R. And it's working! For instance, I managed to create and run successfully a basic particle tracker on one of our ant videos. You can see the result in the screen capture on the right. The software detected and tracked the three ants in the video (technically, there are 5 ants in this video, but 2 of them never moved). It's all done with a few lines of R code thanks to `videoplayR`. If you want to see for yourself how easy it is to use `videoplayR`, you can play with the different examples in the package vignette that I made available on [Rpubs](http://rpubs.com/) at: [http://rpubs.com/sjmgarnier/videoplayR](http://rpubs.com/sjmgarnier/videoplayR).

It is not perfect yet. It's lacking a lot of basic and advanced features that are normally found in a full-fledged computer vision library. It requires the installation of OpenCV, which is fairly standardized on Mac (thanks to [Homebrew](http://brew.sh/) and [MacPorts](https://www.macports.org/)) and Linux, but not so much on Windows. Because of that, `videoplayR` is not (yet) available on Windows, and is unlikely to end up on [CRAN](https://cran.r-project.org/) anytime soon, unless someone with a lot more experience than me can figure out how to ship OpenCV alongside `videoplayR` in a way that can compile (I tried, I failed). All the functions could probably be more optimized, but that too will require the help of a C++ guru.

However what is currently available in the package works, and it works pretty well. I believe that it is intuitive enough for most people to get started with image and video processing with R. And it is fairly fast; I have created a basic particle detector that ran at about 21 images per second on my laptop with HD videos. This number can certainly be improved, but it is not bad at all for a first try. I will keep improving it over time following the needs of my laboratory, but I welcome comments, bug reports and feature requests - or, better, pull requests - that can be made directly on the [Github](https://github.com/) repository of the package at [https://github.com/swarm-lab/videoplayR](https://github.com/swarm-lab/videoplayR).

---

<small>I should mention that I am certainly not the only R user who is desperate enough to have developed a computer vision library for his favorite language. A number of packages have been created to read, process and write images with R. For instance, you can find the  [`EBImage`](http://bioconductor.org/packages/release/bioc/html/EBImage.html) package on BioConductor, or the [`ripa`](https://cran.r-project.org/web/packages/ripa/ripa.pdf) package on CRAN. However good these two packages are at processing images (they are very good), they cannot read videos, which is deal breaker for me.</small>

<small>Very recently, a new package called [`imager`](http://dahtah.github.io/imager/) has been released that is capable of reading videos. It is a fantastic package with a lot of very well thought out functions that I recommend you try. However it has the big disadvantage of loading all the frames of a video directly in R's memory, making it virtually unusable with the large HD videos that we are used to handle in the laboratory. The same developer also released an experimental package called [`imagerstreams`](https://github.com/dahtah/imagerstreams) that is capable of performing "out-of-R-memory" video processing using OpenCV, like `videoplayR`. But a few tests showed that it was not capable of very high processing speeds with HD videos (about 4.5 times slower than `videoplayR`). However I am in contact with the developer to find a way to make `videoplayR` and `imager` talk to each other in order to offer R users the best experience possible when developing computer vision software with R.</small>
