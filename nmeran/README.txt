nmeran.pl conducts various analyses on nmer strings in the given input file. Run it like this (the dollar sign is the command prompt):

$ ./nmeran.pl < <input-filename> > <output-filename>

The input file should contain one or more nmer strings, one per
line. Each string is expected to be prefixed by a subject ID followed
by a colon. The input file may be a result of running nmergen.pl.

The output file contains a table with a header row and one line for each line in the input file. Each line in the table begins with the subject ID for the corresponding input line.

The next two columns are the nmer string length ("len") and the nmer string length not including any zeroes ("len0").

The next set of columns provide data for each AOI ID found in the nmer string. For some ID "X", the following three columns are provided:

* Xc = the count for "X" in the nmer string
* X% = the percentage of the nmer string occupied by "X"
* X% = the percentage of the nmer string, not including any zeroes, occupied by "X"

The sets of AOI ID columns are sorted alphanumerically, but since the variety of IDs can change for each input file, the number of columns varies as well.

The last column, "ffp", provides the first fixation pattern for the nmer string.
