#!/bin/bash
#
# Script to fix obj-file without "usemtl" tag
#
# Copyright 2021, Noriaki Ando <noriaki.ando@gmail.com>
#
# Usage:
#
# 1. Entering a dir with only one .obj file and one .mtl file
# $ cd <dir include .obj/.mtl files>
# $ ls
# hoge.mtl hoge.obj ...
#
# 2. Run command
# $ fixmtl.sh
# $ ls
# hoge.mtl hoge.obj hoge.obj.old ...
# $ diff -u hoge.obj.old hoge.obj
# --- hoge.obj.old	2021-12-23 12:47:31.000000000 +0900
# +++ hoge.obj	2021-12-23 19:33:53.000000000 +0900
# @@ -1,4 +1,5 @@
# mtllib hoge.mtl
# +usemtl texture_hoge.png
#  v -0.033268 -0.0314803 0.0097847
#  v -0.0334465 -0.031311 0.0097847
#  v -0.033268 -0.031311 0.0095008
#


objfile=`ls *.obj`
if test ! `echo $objfile | wc -w` -eq 1 ; then
    echo "One or more obj files exist. Aborting."
    exit 1
fi

mtlfile=`ls *.mtl`
if test ! `echo $mtlfile | wc -w` -eq 1 ; then
    echo "One or more mtl files exist. Aborting."
    exit 1
fi

usemtl=`grep usemtl $objfile`
if test ! "x" = "x$usemtl" ; then
    echo "usemtl tags exist. Aborting."
    exit 1
else
    echo "usemtl tag does not exist. Fixing."
fi

newmtl=`grep newmtl $mtlfile`
mtlname=`awk '/newmtl/{print $2;}' $mtlfile`
echo "newmtl tag is: " $newmtl
echo "matelialname is:" $mtlname

mv $objfile $objfile.old
awk -v mtlname=$mtlname \
    '/^mtllib/{printf("%s\nusemtl %s\n",$0,mtlname);}
    !/^mtllib/{print $0;}' $objfile.old > $objfile
