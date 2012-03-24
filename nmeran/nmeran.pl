#!/usr/bin/perl

# This file is part of ktools.
#
# ktools is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ktools is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ktools.  If not, see <http://www.gnu.org/licenses/>.

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
  $header .= "${ch}c\t${ch}\p\t${ch}0p\t${ch}r\t";
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

