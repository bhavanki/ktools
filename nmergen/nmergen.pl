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

if (scalar @ARGV > 0 and $ARGV[0] eq "-n") {
  $skipNumbers = 1;
} else {
  $skipNumbers = 0;
}

$lastts = "whatever";
while (<STDIN>) {
  if (/^Subject:/) {
    @parts = split;
    print "$parts[1]:";
    next;
  }
  if (/jpg/) {
    @parts = split;
    my $ts = $parts[0];
    next if $ts eq $lastts;
    $lastts = $ts;
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

