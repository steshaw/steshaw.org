---
layout: post
title: "Hello MathJax"
date: 2012-02-09 12:46
comments: true
categories: 
---

MathJax isn't currently supported out-of-the-box with Octopress. The main reason seems to be that the Markdown processor — rdiscount — doesn't deal with the MathJax escaping very well. However, since [Maruku supports it](http://maruku.rubyforge.org/math.xhtml), I thought I'd try switching over.


I made the following two changes:

```yml switch Markdown processors in _config.yml
markdown: maruku
```

``` html enable MathJax in source/_includes/custom/head.html http://www.mathjax.org/docs/1.1/start.html
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
      tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
      });
</script>
<script type="text/javascript" src="path-to-mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

This allows for inline $\TeX$ expressions between dollar signs e.g. `$\TeX$`. MathJax _display_ expressions (i.e. non-inline) are delimited by double dollar signs:

``` tex example expression from Paul Snivey's article http://psnively.github.com/2010/03/13/100-proof.html
$$\forall x, y : \mathbb{Z}, x > 3 \land y < 2 \Rightarrow x^2 - 2y > 5$$
```

renders as:

$$\forall x, y : \mathbb{Z}, x > 3 \land y < 2 \Rightarrow x^2 - 2y > 5$$

## Right-click issue

There was also a problem with the theme. When right clicking a MathJax expression, the whole page goes blank! Zete has a great fix for this:

``` diff fix for right-click http://luikore.github.com/2011/09/good-things-learned-from-octopress/
diff --git a/sass/base/_theme.scss b/sass/base/_theme.scss
index 9a50a8b..fc9dc37 100644
--- a/sass/base/_theme.scss
+++ b/sass/base/_theme.scss
@@ -75,7 +75,7 @@ html {
   background: $page-bg image-url('line-tile.png') top left;
 }
 body {
-  > div {
+  > div#main {
     background: $sidebar-bg $noise-bg;
     border-bottom: 1px solid $page-border-bottom;
     > div {
```

## Futher reading

* [Starting from Octopress](http://luikore.github.com/2011/09/good-things-learned-from-octopress/)
* [MathJax in Markdown](http://doswa.com/2011/07/20/mathjax-in-markdown.html)
* [LaTeX Math Magic](http://cwoebker.com/posts/latex-math-magic/)
