viewtimes.pl
============

viewtimes.pl reports on the viewing times for descriptors in a set of input
event files. Run it from the command line like this (the dollar sign is the
prompt):

$ ./viewtimes.pl <directory> > <output file>

The directory should contain files that each contain the results from a
single event recording for a single subject. It is expected that each file
contains the same set of descriptors to be reported on. The script
automatically skips events pertaining to any "FocusDot" descriptor.

The output file will first contain a header line, with one header for
participant IDs and one header for each descriptor. Each remaining line will
contain data for a subject, starting with the participant ID, and followed by
the elapsed viewing time for each topic, in seconds. Columns are
tab-delimited.
