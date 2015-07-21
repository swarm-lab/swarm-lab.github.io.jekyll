---
title: A new website!
date: 2015-06-30
author: Simon Garnier
layout: post
type: post
category: 
    - blog
published: true

---

The Swarm Lab will be 3 year old tomorrow, July 1st, 2015. To celebrate the event, I decided to redo our website from scratch. It has now a new interface and, more importantly, a new backend. 

**Goodbye [Wordpress](https://wordpress.org/), and hello [Jekyll](http://jekyllrb.com/)!!!** 

<br>

![Wordpress to Jekyll](/img/posts/2015-06-30-a-new-website/wp_to_jekyll.png){: .full }

<br>

I have wanted to make this move for a long time now. Wordpress has served me very well for many years but I have grown increasingly frustrated with a number of things it does and things it cannot do. And while Jekyll might not be for everyone, I quickly learned to like it because of the following reasons (among many others):

1. **Jekyll is fast.** Contrary to Wordpress that relies on [PHP](https://en.wikipedia.org/wiki/PHP) and [MySQL](https://en.wikipedia.org/wiki/MySQL) to build webpages, [Jekyll generates static webpages directly](http://jekyllrb.com/docs/home/). This improves loading times and server use significantly because the webpages do not need to be generated each time they are called by users. Technically generation and loading times can be improved in Wordpress by using caching plugins (or even plugins generating static webpages). However I find that they often conflict with other plugins, in particular plugins creating dynamic content. And since dynamic content is not really necessary on a website like ours, there was no reason to stick with Wordpress any longer (or any other advanced [CMS](https://en.wikipedia.org/wiki/Web_content_management_system) as a matter of fact). 

1. **Jekyll is easy.** Well, this is a matter of interpretation. If you know nothing about [HTML](https://en.wikipedia.org/wiki/HTML), [CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets), [JavaScript](https://en.wikipedia.org/wiki/JavaScript), etc., then Wordpress and other similar CMS are probably easier for you. You install it, you click a few buttons and, there, you have your website. However if you are like me and you like to tinker with the code of your webpages because you are never happy with the way other people have designed them, then Wordpress is definitely a difficult beast to take on at times. Every change to the PHP code might break a plugin, and debugging can quickly turn into a nightmare because of the complexity of the underlying Wordpress machinery. In contrast Jekyll is a much nicer and simpler environment to work and tinker with, and while knowledge of HTML, CSS and JavaScript is still necessary, at least I will no need to deal with PHP and MySQL anymore (phew!). 

1. **Jekyll is better integrated into my workflow.** A large portion of my computer time is spent coding and writing. I use the command line a lot more that before, and most of my work is done using text/code editors, and pushed to GitHub and GitHub-like servers. In addition I use more and more often the [Markdown](https://en.wikipedia.org/wiki/Markdown) markup language to quickly write and format documents. And Markdown is central to Jekyll: all content is written in Markdown, and Jekyll converts it into webpages. All these new habits are perfectly compatible with the Jekyll way of developing, populating and maintaining websites. The more I improved my coding skills, the more it became obvious that Jekyll was the perfect platform for me to develop websites.

Jekyll has a lot more to offer, especially if you have some basic skills in HTML and CSS. And even if you do not, there is a growing community of users out there, and a number of tutorials on how to setup, generate and publish a Jekyll website. 

Now I hope you will enjoy our new website! I have imported a few posts from the old websites ([R vs Python challenges](/category/rvspython/), [\#AntsVsTheWorld](/category/antsvstheworld/), and [\#SlimeLapseGallery](/category/slimelapsegallery/)) to get things started, and I hope to provide new content later when the summer grant writing craze dies down. 

Comments and suggestions for improvement are very welcome!



