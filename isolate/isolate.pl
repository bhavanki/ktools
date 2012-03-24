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

die "Provide a set of letters to filter on" if scalar @ARGV == 0;
$letters = $ARGV[0];

$header = <STDIN>;
chomp $header;
@parts = split /\s+/, $header;
@saveCols = ();
for ($i = 1; $i < scalar @parts; $i++) {
  if ($parts[$i] =~ /^[$letters]+$/) {
    push @saveCols, $i;
  }
}
print $parts[0];
foreach $i (@saveCols) {
  print "\t$parts[$i]";
}
print "\n";

while (<STDIN>) {
  chomp;
  @parts = split;
  print $parts[0];
  foreach $i (@saveCols) {
    print "\t$parts[$i]";
  }
  print "\n";
}

