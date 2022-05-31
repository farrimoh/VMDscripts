#!/bin/bash

for i in `ls *tga`
do
    TARGET=${i%.tga}.jpg
    echo "convert $i $TARGET"
    convert -quality 100 $i $TARGET 
done

