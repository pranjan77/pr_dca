#!/usr/bin/perl

open IN_FILE,"$ARGV[0]";
open OUT,">$ARGV[1]";
 while(1)
 {
    $line1=<IN_FILE>;
       if (not defined($line1)){
         last;
         }
         chomp($line1);
        if($line1=~/^Query:/)
        {
         @array1=split /\s+/,$line1;
        }
        if($line1=~ /^>> /)
        {
        @a=split /\s+/,$line1;
        $hit=$a[1];
        $line1=<IN_FILE>;
        $line1=<IN_FILE>;
        chomp($line1);

       while($line1!~"^  Alignments for each domain:")
        {


        $line1=<IN_FILE>;
        @d=split /\s+/,$line1;
        if($d[6]<1&&defined($d[6]))
        {
        print OUT $array1[1]."\t".$hit."\t$d[6]\t$d[7]\t$d[8]\t$d[10]\t$d[11]\t\n";
        }


       }
      }
     }