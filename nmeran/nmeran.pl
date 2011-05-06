#!/usr/bin/perl

%seenChars = ();
@allsubjs = ();
@alllens = ();
@alllen0s = ();
@allCharCts = ();
@allRuns = ();
@allffps = ();

$num = 0;
while (<STDIN>) {
  @parts = split /:/, $_, 2;
  push @allsubjs, $parts[0];
  $_ = $parts[1];

  my %charCts = ();
  my %runs = ();
  $ffp = "";
  chomp;
  push @alllens, length;
  $len0 = 0;
  $lastch = "~";
  for ($i = 0; $i < length; $i++) {
    $ch = substr $_, $i, 1;

    if (not exists $seenChars{$ch}) {
      $seenChars{$ch} = 1;
    }

    $len0++ if not $ch eq "0";

    if (not exists $charCts{$ch}) {
      $ffp .= $ch if not $ch eq "0";
      $charCts{$ch} = 1;
    } else {
      $charCts{$ch} += 1;
    }

    if ($ch ne $lastch) {
      if (not exists $runs{$ch}) {
	$runs{$ch} = 1;
      } else {
	$runs{$ch} += 1;
      }
      $lastch = $ch;
    }
  }

  push @alllen0s, $len0;
  push @allCharCts, \%charCts;
  push @allRuns, \%runs;
  push @allffps, $ffp;
  $num++;
}

$header = "num\tlen\tlen0\t";
@seenCharsList = sort keys %seenChars;
foreach $ch (@seenCharsList) {
  $header .= "${ch}c\t${ch}\%\t${ch}0%\t${ch}r\t";
}
$header .= "ffp";
print "$header\n";

for ($i = 0; $i < $num; $i++) {
  $subj = $allsubjs[$i];
  print "$subj\t";
  $len = $alllens[$i];
  print "$len\t";
  $len0 = $alllen0s[$i];
  print "$len0\t";
  $charCtsRef = $allCharCts[$i];
  %charCts = %{$charCtsRef};
  foreach $ch (@seenCharsList) {
    if (exists $charCts{$ch}) {
      $ct = $charCts{$ch};
      $p = 100 * ($ct / $len);
      $p0 = 100 * ($ct / $len0);
      $r = ${$allRuns[$i]}{$ch};
      print "$ct\t";
      printf "%.2f\t", $p;
      printf "%.2f\t", $p0;
      print "$r\t";
    } else {
      print "0\t0\t0\t0\t";
    }
  }
  print "$allffps[$i]\n";
}

