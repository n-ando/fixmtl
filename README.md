# fixmtl
Fixing obj file without usemtl tag

YCB Object "obj" model files does not specify "usemtl" tag. According to this, some obj loaders (ex. three.js) cannot load texsture properly.
- "The YCB Object and Model Set": http://ycb-benchmarks.s3-website-us-east-1.amazonaws.com/

This script add "usemtl" tag to the obj file from the mlt file information.

## Usage:

1. Entering a dir with only one .obj file and one .mtl file

```shell
$ cd <dir include .obj/.mtl files>
$ ls
hoge.mtl hoge.obj ...
```

2. Run command

```shell
$ fixmtl.sh
$ ls
hoge.mtl hoge.obj hoge.obj.old ...
$ diff -u hoge.obj.old hoge.obj
--- hoge.obj.old	2021-12-23 12:47:31.000000000 +0900
+++ hoge.obj	2021-12-23 19:33:53.000000000 +0900
@@ -1,4 +1,5 @@
mtllib hoge.mtl
+usemtl texture_hoge.png
 v -0.033268 -0.0314803 0.0097847
 v -0.0334465 -0.031311 0.0097847
 v -0.033268 -0.031311 0.0095008
 ```
 
