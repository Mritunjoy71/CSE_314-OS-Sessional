#!/bin/bash 
mkdir Output
cd Output
mkdir Extra
cd ..
mkdir allfiles
cp SubmissionsAll.zip allfiles
cd allfiles
unzip -o SubmissionsAll.zip
rm SubmissionsAll.zip 

mkdir tempo
find . -type f -iname "*.zip"  | while read f
do 
    unzip -o "$f" -d tempo
    cd tempo
    
    x="$(ls)"
    var=0
    for i in $x
    do
    ((var++))
    done
    
    if [ $var -lt 2 ];
    then
    mv $x /media/mritunjoy/photos/offline/tempo /media/mritunjoy/photos/offline/Output
    fi
    
    cd ..
    rm /media/mritunjoy/photos/offline/allfiles/tempo/*.*
    rm -rf "$f"
    
    
    
done

find . -type f -iname "*.rar"  | while read f
do 
    rm -f "$f"    
done
#trash empty
rm -rf ~/.local/share/Trash/*
