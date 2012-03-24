#!/usr/bin/perl -w

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

