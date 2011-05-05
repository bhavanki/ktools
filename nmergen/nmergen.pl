#!/usr/bin/perl

while (<STDIN>) {
  if (/^Subject:/) {
    @parts = split;
    print "$parts[1]:";
    next;
  }
  if (/jpg/) {
    @parts = split;
    my $aoi = $parts[3];
    if ($parts[3] eq "Content") {
      print '0';
    } else {
      print $aoi;
    }
  }
}
print "\n";

