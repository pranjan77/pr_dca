#!/usr/bin/perl
my %gene;
$name="";
open IN_FILE,"$ARGV[0]";
open OUT,">$ARGV[1]";
 while(1)
 {
    $line1=<IN_FILE>;
       if (not defined($line1)){
         last;
         }

  @array1=split /\s+/,$line1,4;
 if($array1[0] eq $name)
   {
   $gene{$line1}=$array1[2];
   $name=$array1[0];
   }
   else
   {
  my @keys = sort { $gene{$a} <=> $gene{$b} } keys %gene;  #sort the hash table
    for (@keys){print OUT "$_"};
    undef %gene;
    my %gene;
    $gene{$line1}=$array1[2];
   $name=$array1[0];
   }
 }
  my @keys = sort { $gene{$a} <=> $gene{$b} } keys %gene;  #sort the hash table
    for (@keys){print OUT "$_"};
  close IN_FILE;
  close OUT;