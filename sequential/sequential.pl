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

$dir = $ARGV[0];
opendir DH, $dir or die "Cannot open dir: $!";

if (scalar @ARGV > 1 and $ARGV[1] eq "-a") {
  $aggregate = 1;
} else {
  $aggregate = 0;
}

# Scan 1: For each file, generate individual duration file.
%maxes = ();
foreach $file (readdir DH) {
  next if $file eq "." or $file eq "..";
  $filename = "$dir/$file";
  open SRC, "<${filename}" or die "Cannot open $filename: $!";
  open DUR, ">${filename}.dur"
    or die "Cannot open ${filename}.dur for writing: $!";

  $lastts = "whatever";
  $lastaoi = "whatever";
  $lastdur = 0;
  my %cts = ();
  while (<SRC>) {
    if (/^Subject:/) {
      @parts = split;
      print DUR "! $parts[1]\n";
      next;
    }
    next if not /jpg/;

    @parts = split;
    my $ts = $parts[0];
    next if $ts eq $lastts;
    $lastts = $ts;
    my $dur = $parts[1];
    my $aoi = $parts[3];
    next if $aoi eq "Content";
    next if $aoi =~ /[0123456789]/;

    if (not $aggregate or $aoi ne $lastaoi) {
      if (exists $cts{$aoi}) {
        $cts{$aoi} = $cts{$aoi} + 1;
      } else {
        $cts{$aoi} = 1;
      }
    }
    if ($aggregate and $aoi eq $lastaoi) {
      $lastdur += $dur;
      next;
    }

    print DUR "${lastaoi} ${lastdur}\n" if $lastaoi ne "whatever";
    $lastaoi = $aoi;
    $lastdur = $dur;
  } 
  print DUR "${lastaoi} ${lastdur}\n" if $lastaoi ne "whatever";

  close DUR;
  close SRC;

  foreach $seenaoi (keys %cts) {
    if (not exists $maxes{$seenaoi} or
        $maxes{$seenaoi} < $cts{$seenaoi}) {
      $maxes{$seenaoi} = $cts{$seenaoi};
    }
  }
}
closedir DH;

# Intermission: Stable sort each duration file by AOI.

opendir DH, $dir;
foreach $file (readdir DH) {
  next if $file !~ /\.dur$/;
  $filename = "$dir/$file";
  !system "sort -k 1,1 -s \'$filename\' > \'$filename.sorted\'"
    or die "Failed to sort $filename: $!";
}
closedir DH;

# Scan 2: Merge duration files, making sparse as needed.

%headers = ();
foreach $seenaoi (keys %maxes) {
  $numplaces = length $maxes{$seenaoi};
  $headers{$seenaoi} = "\t%s%0${numplaces}d";
}
@expectedaois = sort keys %maxes;

print "Subj";
foreach $seenaoi (@expectedaois) {
  $ct = $maxes{$seenaoi};
  $header = $headers{$seenaoi};
  for ($i = 1; $i <= $ct; $i++) {
    printf $header, $seenaoi, $i;
  }
}
print "\n";

opendir DH, $dir;
foreach $file (readdir DH) {
  next if $file !~ /\.dur.sorted$/;
  $filename = "$dir/$file";
  open DUR, "<${filename}" or die "Cannot open $filename for reading: $!";

  $subj = <DUR>;
  chomp $subj;
  print substr $subj, 2;

  my $curraoi = "whatever";
  my $currct = 0;
  my $eaidx = -1;
  my $expectedaoi;
  while (<DUR>) {
    ($aoi, $dur) = split;

    if ($aoi ne $curraoi and $curraoi ne "whatever") {
      for ($i = $currct; $i < $maxes{$curraoi}; $i++) {
        print "\t";
      }
      $currct = 0;
    }
    if ($aoi ne $curraoi) {
      $eaidx++;
      $expectedaoi = $expectedaois[$eaidx];
      while ($aoi ne $expectedaoi) {
        print "\t" x $maxes{$expectedaoi};
        $eaidx++;
        $expectedaoi = $expectedaois[$eaidx]; 
      }
    }

    print "\t$dur";
    $curraoi = $aoi;
    $currct++;
  }
  print "\n";

  close DUR;
}
closedir DH;
