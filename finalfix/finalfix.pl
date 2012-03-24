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

foreach $file (readdir DH) {
  next if $file eq "." or $file eq "..";
  $filename = "$dir/$file";
  open SRC, "<${filename}" or die "Cannot open $filename: $!";

  my $durtotal = 0;
  my $ct = 0;
  $lastts = "whatever";
  $lastdur = "?";
  $lastaoi = "?";
  while (<SRC>) {
    if (/^Subject:/) {
      @parts = split;
      print "$parts[1]\t";
      next;
    }
    next if not /jpg/;

    @parts = split;
    my $ts = $parts[0];
    next if $ts eq $lastts;
    $lastts = $ts;
    my $dur = $parts[1];
    my $aoi = $parts[3];
    #next if $aoi eq "Content";
    #next if $aoi =~ /[0123456789]/;

    $durtotal += $dur;
    $lastdur = $dur;
    $lastaoi = $aoi;
    $ct++;
  } 

  my $avg = ($durtotal - $lastdur) / ($ct - 1);
  print "${lastdur}\t${avg}\t${lastaoi}\n";

  close SRC;
}
closedir DH;
