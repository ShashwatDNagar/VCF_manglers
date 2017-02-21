#!/usr/bin/env perl

# Shashwat Deepali Nagar, 2017
# Jordan Lab, Georgia Tech

use strict;

my $fileLoc = $ARGV[0];
my $chrs = $ARGV[1];
my $usage = "\nUsage: $0 <input file> <number of chromosomes>\n\nExample:\n$0 testFile.vcf 22\n\n";

die $usage if @ARGV != 2;

my (@allLines, $fileLoc, @splitLine);


for(1..$chrs){
  open(my $ofh, '>', "SA_$_.vcf") or die "Can't open new file! $!";
  chomp(@allLines = `cat $fileLoc | awk 'BEGIN{OFS="\t"; FS=" ";  } {if(\$1 == $_) {print;}}' | sort -k4n`);
  foreach my $line (@allLines) {
    @splitLine = split(" ", $line);
    print $line."\n";
    print $ofh "$splitLine[0]\t$splitLine[1]\t$splitLine[2]\t$splitLine[3]\t";
    for (my $i = 4; $i < scalar @splitLine; $i++) {
      if ($i % 2 == 0) {
        print $ofh " $splitLine[$i]\|";
      }
      else {print $ofh "$splitLine[$i] "};
    }
    print $ofh "\n";
  }

}
