#!/usr/bin/perl

while (<STDIN>) {
  @parts = split /:/, $_, 2;
  print "$parts[0]:";
  $_ = $parts[1];
  %chars = ();
  chomp;
  for ($i = 0; $i < length; $i++) {
    $ch = substr $_, $i, 1;
    if (not exists $chars{$ch}) {
      print $ch if not $ch eq "0";
      $chars{$ch} = 1;
    }
  }
  print "\n";
}
