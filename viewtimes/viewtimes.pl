#!/usr/bin/perl -w

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
