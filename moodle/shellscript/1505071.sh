#!/bin/bash 
rm -rf allfiles
rm -rf Output
mkdir Output
mkdir Output/Extra
mkdir allfiles
cp SubmissionsAll.zip allfiles
cd allfiles
unzip -o SubmissionsAll.zip
rm SubmissionsAll.zip ar

find . -type f -iname "*.rar"  | while read f
do 
    rm -f "$f"    
done

#initial absentlist
find . -type f -iname "*.zip" > names.txt
grep -o '[0-9][0-9]05[0-9][0-9][0-9]' names.txt > rolls.txt
grep -o '[0-9][0-9]05[0-9][0-9][0-9]' /media/mritunjoy/photos/OSoffline/CSE_322.csv > register.txt 
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
            mv $x /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output
            echo "$x -10" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt 
         elif [[ $x = $patt2 ]] #pattern roll_cseOSoffline_322 ,5 marks
         then
            mv $x $rol
            mv $rol /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output
            echo "$rol -5" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt 
         else
            if [[ -n $ziprol ]];then  #submitted by roll.zip,inner dir wrong ,0 marks
                mv $x $ziprol
                mv $ziprol /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output
                echo "$ziprol -0" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt  
            else        #not submitted by roll.zip,inner dir wrong ,0 marks
                nam="$(echo "$(basename "$f")" | cut -d "_" -f 1)"
                             #echo "$nam" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt   
                field=$(grep -F -i "$nam" /media/mritunjoy/photos/OSoffline/CSE_322.csv)
                if [[ -n "$field" ]];then  #search found
                    froll=$(echo "$field"| grep -o '[0-9][0-9]05[0-9][0-9][0-9]')
                                 #echo "$froll" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt 
                    mv $x $froll
                    mv $froll /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output
                    echo "$froll -0" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt 
                    echo "$froll" >> /media/mritunjoy/photos/OSoffline/allfiles/searchroll.txt
                else      #search  not found
                    #mv $x $nam
                    mv $x /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output/Extra 
                    #echo "$x" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt   
                fi    
            fi                         
         fi
    else    #number of directories in tempo >1
        if [[ -n $ziprol ]];then   #submitted by roll.zip
            mkdir $ziprol
            for file in $x
            do
                mv $file $ziprol
            done 
            mv $ziprol /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output
            echo "$ziprol -0" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt
        else     #not submitted by roll.zip
            nam=$(echo "$(basename "$f")" | cut -d "_" -f 1)
                         #echo "$nam" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt   
            field=$(grep -F -i "$nam" /media/mritunjoy/photos/OSoffline/CSE_322.csv)
            if [[ -n "$field" ]];then  #search found
                froll=$(echo "$field"| grep -o '[0-9][0-9]05[0-9][0-9][0-9]')
                             #echo "$froll" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt 
                for file in $x
                do
                    mv $file $froll
                done 
                mv $fproll /media/mritunjoy/photos/OSoffline/tempo /media/mritunjoy/photos/OSoffline/Output
                echo "$froll -0" >>/media/mritunjoy/photos/OSoffline/allfiles/marks.txt
                echo "$froll" >> /media/mritunjoy/photos/OSoffline/allfiles/searchroll.txt 
            else
                for file in $x
                do
                    mv $file /media/mritunjoy/photos/OSoffline/Output/Extra
                done 
            fi                
        fi             
    fi        
    
    cd ..
    
    rm -rf tempo
    rm -rf "$f"   
done

grep -v -F -x -f searchroll.txt absent.txt > absents.txt 

input="/media/mritunjoy/photos/OSoffline/allfiles/absents.txt"
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$line -0" >> /media/mritunjoy/photos/OSoffline/allfiles/marks.txt
done < "$input"

sort -n -k 4 absents.txt > absents_roll.txt
sort -n -k 4 marks.txt > sub_marks.txt

cp absents_roll.txt /media/mritunjoy/photos/OSoffline/Output
cp sub_marks.txt /media/mritunjoy/photos/OSoffline/Output


#trash empty
rm -rf ~/.local/share/Trash/*
