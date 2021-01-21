touch /home/azman/L3T2/OperatingSystem/OS/marks.txt
chmod 777 /home/azman/L3T2/OperatingSystem/OS/t.txt
mkdir -m777 /home/azman/L3T2/OperatingSystem/OS/output
mkdir -m777 /home/azman/L3T2/OperatingSystem/OS/output/Extra
mkdir -m777 /home/azman/L3T2/OperatingSystem/OS/temp
for file in /home/azman/L3T2/OperatingSystem/OS/uzip/*; do
file2=$(echo "$(basename "$file")")
file3=$(echo "$(basename "$file")" | cut -d "_" -f 5)
file7=$(echo "$(basename "$file")" | cut -d "_" -f 1)
 file4=$(echo "$file3" | cut -d "." -f 1)
echo $file2
echo "here"
unzip "$file" -d   /home/azman/L3T2/OperatingSystem/OS/temp
number=$(find /home/azman/L3T2/OperatingSystem/OS/temp -maxdepth 1  -type d | wc -l)



for file5 in /home/azman/L3T2/OperatingSystem/OS/temp/*; do
chmod 777 "$file5"
file6=$(echo "$(basename "$file5")")
tempdiv=$(echo  "$file6" | cut -d "_" -f 1)
var=2
if [ $number -eq $var ]; then



if [[ $file4 == [0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
 if [[ $file6 == [0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
mv /home/azman/L3T2/OperatingSystem/OS/temp/"$file6"  /home/azman/L3T2/OperatingSystem/OS/output

echo $file5
echo "hello2"
fi
elif [[ $file4 == [0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
if [[ $tempdiv == [0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
 mv /home/azman/L3T2/OperatingSystem/OS/temp/"$file6"  /home/azman/L3T2/OperatingSystem/OS/temp/"$tempdiv"
mv /home/azman/L3T2/OperatingSystem/OS/temp/"$tempdiv"  /home/azman/L3T2/OperatingSystem/OS/output
echo "hello"
fi

else




if [[ $file4 == [0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
mv /home/azman/L3T2/OperatingSystem/OS/temp/"$file6"  /home/azman/L3T2/OperatingSystem/OS/temp/"$file4"
mv  /home/azman/L3T2/OperatingSystem/OS/temp/"$file4"  /home/azman/L3T2/OperatingSystem/OS/output
echo "hello4"
else
echo "hello5"
echo $file7
echo "$file7"
awk -v myvar="$file7"
multiple=$(awk -v myvar="$file7" -F',' 'BEGIN{ORS="=";} $2 == myvar' /home/azman/L3T2/OperatingSystem/OS/ShellScript/new.csv)
i=0
IFS=$'='
echo $multiple

for multpart in $multiple; do
echo $multpart >> te.txt
(( i++ ))
done
IFS=$' '

echo "hello6"

instance1=1
instance2=2

if [[ $i -eq $instance1 ]]; then
echo "delete it from absentee file"
echo $multiple
#single=$(echo "$mutiple" | cut -d "=" -f 1)
single=$(echo "$multiple" | cut -d "," -f 1)
echo $single
echo $(awk -F, '$1!='$single'' /home/azman/L3T2/OperatingSystem/OS/ShellScript/new.csv > /home/azman/L3T2/OperatingSystem/OS/ShellScript/nett.csv)
cp /home/azman/L3T2/OperatingSystem/OS/ShellScript/nett.csv /home/azman/L3T2/OperatingSystem/OS/ShellScript/new.csv

elif [[ $i -eq $instance2 ]]; then
echo "search it in two files"
else
echo "move to extra ,more than two instance"
fi



fi




fi

else


if [[ $file4 == [0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
 mkdir -m777 /home/azman/L3T2/OperatingSystem/OS/output/Extra/"$file4"
 mv /home/azman/L3T2/OperatingSystem/OS/temp/* /home/azman/L3T2/OperatingSystem/OS/output/Extra/"$file4"
else
name=$file7
mkdir -m777 /home/azman/L3T2/OperatingSystem/OS/output/Extra/"$file7"
 mv /home/azman/L3T2/OperatingSystem/OS/temp/* /home/azman/L3T2/OperatingSystem/OS/output/Extra/"$file7"


fi



fi
done
echo $file6
echo $number


rm -r /home/azman/L3T2/OperatingSystem/OS/temp/*
done
echo  $hh
echo $name
echo $flag
echo $flag2
echo $i
echo $instance1

echo $multiple
echo $single
