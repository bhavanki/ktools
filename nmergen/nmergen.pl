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
    if ($parts[3] eq "Content") {
      print FH '0';
    } else {
      print FH $aoi;
    }
  }
}
print FH "\n";
close FH;
