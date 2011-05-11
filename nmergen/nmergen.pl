#!/usr/bin/perl

if (scalar @ARGV > 0 and $ARGV[0] eq "-n") {
  $skipNumbers = 1;
} else {
  $skipNumbers = 0;
}
print $skipNumbers;

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
      if (not $skipNumbers) {
	print '0';
      }
    } else {
      if (not $skipNumbers or $parts[3] !~ /[0123456789]/) {
	print $aoi;
      }
    }
  }
}
print "\n";

