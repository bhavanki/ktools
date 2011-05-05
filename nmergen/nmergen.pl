#!/usr/bin/perl

$ncomp = $ARGV[0];

while (<STDIN>) {
  if (/^Subject:/) {
    @parts = split;
    open FH, '>', $ncomp . "_" . $parts[1] . ".nmer" or die "Cannot open output file";
  }
  if (/jpg/) {
    @parts = split;
    my $aoi = $parts[3];
    if ($parts[3] =~ /_/) {
      print FH substr ($aoi, -1)
    } else {
      print FH '0';
    }
  }
}
print FH "\n";
close FH;
