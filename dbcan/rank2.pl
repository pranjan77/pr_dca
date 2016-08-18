#!/usr/bin/perl
$name="";
open IN_FILE,"$ARGV[0]";
open OUT,">$ARGV[1]";
 while(1)
 {
    $line1=<IN_FILE>;
       if (not defined($line1)){
         last;
         }

  @array1=split /\s+/,$line1;
  $aa=$array1[5]*1;
  $bb=$array1[6]*1;
  if($array1[0] ne $name)
  {
   $k=1;
   $m=0;

   $name=$array1[0];
   print OUT $line1;
   for($i=0;$i<$k;$i++)
   {
    $a[$i][0]=$aa;
    $a[$i][1]=$bb;
   }
   $k=1;
 #  print OUT $a[0][0]."\n";
  }
  else
  {
  $m=0;
   for($i=0;$i<$k;$i++)
   {
    if($aa>=$a[$i][0]&&$aa<=$a[$i][1])
    { $range=($a[$i][1]-$aa)*5;
      $range2=$bb-$aa;
      if($range>$rang1)
      { $m=1;}
    }
    if($bb>=$a[$i][0]&&$bb<=$a[$i][1])
    { $range=($bb-$a[$i][0])*5;
      $range2=$bb-$aa;
      if($range>$rang1)
      { $m=1;}
      }
    if($aa<=$a[$i][0]&&$bb>=$a[$i][1])
    { $range=($a[$i][1]-$a[$i][0])*5;
      $range2=$bb-$aa;
      if($range>$rang1)
      { $m=1;}
      }

   }
   if($m==0)
   {
    $a[$k][0]=$array1[5];
    $a[$k][1]=$array1[6];
    $k++;
    print OUT $line1;
   }
  }


 }
  close IN_FILE;
  close OUT;