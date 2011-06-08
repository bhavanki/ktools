#!/usr/bin/perl

$numberCt = 0;
@numbers = ();
@positions = ();
@fixationCountBefore = ();
@fixationRunCountBefore = ();
@uniqueFixationCountBefore = ();
@beforeChars = ();
@afterChars = ();
@fixationDurations = ();

$lastts = "whatever";
$pos = 0;
$currentFixations = ();
$lastChar = '-';
$needAfterChar = 0;
$currentFixationDuration = 0;
while (<STDIN>) {
  if (/^Subject:/) {
    @parts = split;
    print "$parts[1]";
    next;
  }
  if (/jpg/) {
    @parts = split;
    my $ts = $parts[0];
    next if $ts eq $lastts;
    $lastts = $ts;
    my $aoi = $parts[3];
    if ($aoi eq "Content") {
      $aoi = '0';
    }

    if ($needAfterChar) {
      push @afterChars, ($aoi);
      $needAfterChar = 0;
    }

    $aoiNonFixating = ($aoi =~ /[0123456789]/);
    if ($aoiNonFixating) {
      # no longer fixating
      push @numbers, ($aoi);
      push @positions, ($pos);

      push @fixationCountBefore, (scalar @currentFixations);
      $lilNmer = join '', @currentFixations;
      $lilNmer =~ tr///cs;  # removes duplicates - from perlfaq4
      push @fixationRunCountBefore, (length $lilNmer);
      $lilNmer = join '', sort @currentFixations;
      $lilNmer =~ tr///cs;  # removes duplicates - from perlfaq4
      push @uniqueFixationCountBefore, (length $lilNmer);
      @currentFixations = ();

      push @fixationDurations, ($currentFixationDuration);
      $currentFixationDuration = 0;

      push @beforeChars, ($lastChar);
      $needAfterChar = 1;
    } else {
      # now fixating
      push @currentFixations, ($aoi);
      $currentFixationDuration += $parts[1];
    }

    $pos++;
    $lastChar = $aoi;
  }
}

while (scalar @afterChars < scalar @numbers) {
  push @afterChars, ('-');
}

$numberCt = scalar @numbers;
print "\t$numberCt";
for ($i = 0; $i < $numberCt; $i++) {
  print "\t$numbers[$i]";
  print "\t$positions[$i]";
  print "\t$fixationCountBefore[$i]";
  print "\t$fixationRunCountBefore[$i]";
  print "\t$uniqueFixationCountBefore[$i]";
  print "\t$beforeChars[$i]";
  print "\t$afterChars[$i]";
  print "\t$fixationDurations[$i]";
}
print "\n";
