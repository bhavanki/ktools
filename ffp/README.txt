ffp.pl takes in an input nmer file and produces a new file listing only the
first fixation pattern. Run it from the command line like this (the
dollar sign is the prompt).

$ ./ffp.pl < <input-filename> > <output-filename>

The input file should contain one or more nmer strings, one per
line. Each string is expected to be prefixed by a subject ID followed
by a colon. The input file may be a result of running nmergen.pl.

The output file will contain the same number of lines as the input
file, and each line in the output file will hold the first fixation
pattern for the corresponding line in the input file. The subject ID
is preserved in each line.

For example, say you have a one-line nmer file and you want the first
fixation pattern for it. Here is how you could generate it. There is
no special meaning to the file names.

$ ./ffp.pl < foo_123-456.nmer > foo_123-456.ffp


