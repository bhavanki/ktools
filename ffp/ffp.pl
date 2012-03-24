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
