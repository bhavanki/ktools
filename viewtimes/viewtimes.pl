#!/usr/bin/perl -w

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

$firstfile = 1;
foreach $file (readdir DH) {
  next if $file eq "." or $file eq "..";
  $filename = "$dir/$file";
  open SRC, "<${filename}" or die "Cannot open $filename: $!";

  $participant = "?";
  $laststart = 0;
  %vt = ();
  while (<SRC>) {
    if (/^Participant:/) {
      @parts = split;
      $participant = $parts[1];
      next;
    }
    next if not (/ImageStart/ or /ImageEnd/);
    next if /FocusDot/;

    @parts = split;
    my $ts = $parts[0];
    my $desc = $parts[5];
    if (/ImageEnd/) {
      $vt{$desc} = $ts - $laststart;
    } else {
      $laststart = $ts;
    }
  } 

  if ($firstfile) {
    print "id";
    foreach $desc (sort keys %vt) {
      print "\t$desc";
    }
    print "\n";
    $firstfile = 0;
  }
  print $participant;
  foreach $desc (sort keys %vt) {
    $insec = $vt{$desc} / 1000;
    print "\t$insec";
  }
  print "\n";

  close SRC;
}
closedir DH;
