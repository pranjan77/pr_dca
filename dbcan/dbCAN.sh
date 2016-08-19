#!/bin/sh
#Get path from standard input
currentpath=$1;
fastafilepath=$2
outputfilepath=$3
cd $currentpath;
databasepath="$currentpath/hmmmodel";

echo $currentpath
echo $fastafilepath
echo $outputfilepath
pwd
which hmmscan



if [ -z "$1" ]
then
echo "invalid input file!";
continue;
else
workpath="$currentpath/workspace";
cd $workpath;
foldName=$(date '+%Y%m%d%H%M%S');

mkdir $foldName; 
cd $foldName
mkdir family;
mkdir subfamily;

cd $workpath;
chmod -R 777 $foldName;

cp $fastafilepath "./$foldName/input.faa";
cd ..;

# family prediction;
hmmscan -o "$workpath/$foldName/family/output.txt" "$databasepath/cazy-family/all.hmm.ps" "$workpath/$foldName/input.faa" 2> "$workpath/$foldName/family/output.err";
perl ./hmm.pl "$workpath/$foldName/family/output.txt"  "$workpath/$foldName/family/output2.txt" 2> "$workpath/$foldName/family/output2.err";
sh ./rank.sh "$workpath/$foldName/family/output2.txt" 1> "$workpath/$foldName/family/result.txt" 2> "$workpath/$foldName/family/result.err";

cp "$workpath/$foldName/family/result.txt" $outputfilepath

echo $outputfilepath
cat $outputfilepath

# subfamily prediction;
#hmmscan -o "$workpath/$foldName/subfamily/output.txt" "$databasepath/cazy-subfamily/all.subfam.hmm" "$workpath/$foldName/input.faa" 2> "$workpath/$foldName/subfamily/output.err";
#perl ./hmm.pl "$workpath/$foldName/subfamily/output.txt"  "$workpath/$foldName/subfamily/output2.txt" 2> "$workpath/$foldName/subfamily/output2.err";
#sh ./rank.sh "$workpath/$foldName/subfamily/output2.txt" 1> "$workpath/$foldName/subfamily/result.txt" 2> "$workpath/$foldName/subfamily/result.err";
fi
