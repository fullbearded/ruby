#!/bin/bash
# this is code diff for subl 
git pull origin master
old_version=`cat ./version.txt`
git log -1 --format="%H" > ./version.txt
git diff old_version `cat ./version.txt` | subl
