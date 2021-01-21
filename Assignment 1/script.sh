#!/bin/bash 
rm -rf allfiles
rm -rf Output
mkdir Output
mkdir allfiles
cp SubmissionsAll.zip allfiles
cd allfiles
unzip -o SubmissionsAll.zip
rm SubmissionsAll.zip ar

find . -type f -iname "*.rar"  | while read f
do 
    rm -f "$f"    
done

#absentlist
find . -type f -iname "*.zip" > names.txt
grep -o '[0-9][0-9]05[0-9][0-9][0-9]' names.txt > rolls.txt
grep -o '[0-9][0-9]05[0-9][0-9][0-9]' /media/mritunjoy/photos/assignment/CSE_322.csv > register.txt 
grep -v -F -x -f rolls.txt register.txt >absent.txt 

touch marks.txt
touch searchroll.txt

find . -type f -iname "*.zip" | while read f
do 
    mkdir tempo
    unzip -o "$f" -d tempo
    ziprol=$(echo "$f"| grep -o '[0-9][0-9]05[0-9][0-9][0-9]')
    cd tempo
    #number of directories in tempo
    x="$(ls)"
    var=0
    for i in $x
    do
        ((var++))
    done
    
    if [ $var -eq 1 ] #number of directories in tempo =1
    then
        patt="[0-9][0-9]05[0-9][0-9][0-9]"
        patt2="[0-9][0-9]05[0-9][0-9][0-9][_]*"
        rol=$(echo "$x"| grep -o '[0-9][0-9]05[0-9][0-9][0-9]')
        
        if [[ $x = $patt ]] #pattern roll  ,10 marks
        then
            mv $x /media/mritunjoy/photos/assignment/tempo /media/mritunjoy/photos/assignment/Output
            echo "$x -10" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt 
         elif [[ $x = $patt2 ]] #pattern roll_cseassignment_322 ,5 marks
         then
            mv $x $rol
            mv $rol /media/mritunjoy/photos/assignment/tempo /media/mritunjoy/photos/assignment/Output
            echo "$rol -5" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt 
         else
            if [[ -n $ziprol ]];then  #submitted by roll.zip,inner dir wrong ,0 marks
                mv $x $ziprol
                mv $ziprol /media/mritunjoy/photos/assignment/tempo /media/mritunjoy/photos/assignment/Output
                echo "$ziprol -0" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt  
            else        #not submitted by roll.zip,inner dir wrong ,0 marks
                nam=$(echo "$(basename "$f")" | cut -d "_" -f 1)
                             #echo "$nam" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt   
                field=$(grep -F -i "$nam" /media/mritunjoy/photos/assignment/CSE_322.csv)
                froll=$(echo "$field"| grep -o '[0-9][0-9]05[0-9][0-9][0-9]')
                             #echo "$froll" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt 
                mv $x $froll
                mv $froll /media/mritunjoy/photos/assignment/tempo /media/mritunjoy/photos/assignment/Output
                echo "$froll -0" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt 
                echo "$froll" >> /media/mritunjoy/photos/assignment/allfiles/searchroll.txt
            fi                         
         fi
    else    #number of directories in tempo >1
        if [[ -n $ziprol ]];then   #submitted by roll.zip
            mkdir $ziprol
            for file in $x
            do
                mv $file $ziprol
            done 
            mv $ziprol /media/mritunjoy/photos/assignment/tempo /media/mritunjoy/photos/assignment/Output
            echo "$ziprol -0" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt
        else     #not submitted by roll.zip
            nam=$(echo "$(basename "$f")" | cut -d "_" -f 1)
                         #echo "$nam" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt   
            field=$(grep -F -i "$nam" /media/mritunjoy/photos/assignment/CSE_322.csv)
            froll=$(echo "$field"| grep -o '[0-9][0-9]05[0-9][0-9][0-9]')
                         #echo "$froll" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt 
            for file in $x
            do
                mv $file $froll
            done 
            mv $fproll /media/mritunjoy/photos/assignment/tempo /media/mritunjoy/photos/assignment/Output
            echo "$froll -0" >>/media/mritunjoy/photos/assignment/allfiles/marks.txt
            echo "$froll" >> /media/mritunjoy/photos/assignment/allfiles/searchroll.txt             
        fi             
    fi        
    
    cd ..
    grep -v -F -x -f searchroll.txt absent.txt > absents.txt 
    cp absents.txt /media/mritunjoy/photos/assignment/Output
    cp marks.txt /media/mritunjoy/photos/assignment/Output
    
    rm -rf tempo
    rm -rf "$f"   
done


#trash empty
rm -rf /.local/share/Trash/*
