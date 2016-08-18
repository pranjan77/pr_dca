#!/usr/bin/env sh

# Yanbin Yin
# 08/18/2011
# remove overlapped/redundant hmm matches and keep the one with the lower e-values
currentpath=$PWD;
#echo $currentpath;
cat $1 | sort -k 1,1 -k 6,6n -k 7,7n | uniq | perl -e 'while(<>){chomp;@a=split;next if $a[-1]==$a[-2];push(@{$b{$a[0]}},$_);}foreach(sort keys %b){@a=@{$b{$_}};for($i=0;$i<$#a;$i++){@b=split(/\t/,$a[$i]);@c=split(/\t/,$a[$i+1]);$len1=$b[-1]-$b[-2];$len2=$c[-1]-$c[-2];$len3=$b[-1]-$c[-2];if($len3>0 and ($len3/$len1>0.5 or $len3/$len2>0.5)){if($b[2]<$c[2]){splice(@a,$i+1,1);}else{splice(@a,$i,1);}$i=$i-1;}}foreach(@a){print $_."\n";}}' \
        | uniq | perl -e 'open(IN,"./hmmmodel/cazy-family/all.hmm.ps.len1");while(<IN>){chomp;@a=split;$b{$a[0]}=$a[1];}while(<>){chomp;@a=split;$r=($a[4]-$a[3])/$b{$a[1]};print $_."\t".$r."\n";}' | perl -e 'while(<>){@a=split(/\t/,$_);if(($a[-1]-$a[-2])>80){print $_ if $a[2]<1e-5;}else{print $_ if $a[2]<1e-3;}}' | awk '$NF>0.3'
