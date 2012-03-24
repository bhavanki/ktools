isolate.pl
==========

isolate.pl cuts down output files from the NMer tool, which counts the number
of transitions between tokens of a given length in strings. Only columns that
include some combination (of any length) of specific input characters are
retained. Run it from the command line like this (the dollar sign is the
prompt):

$ ./isolate.pl <characters> < <input file> > <output file>

The characters are given in one string, e.g., ABCD.

The output file has the same format as the input file, but only retaining
columns (besides the first, which is expected to contain the subject ID) whose
headers consist solely of characters in the given string. Characters may be
repeated, and any length is permitted.

For example, with this input file:

num     AB      AC      AD      BA      BC      BD      CA      CB      DA
444-888 1       2       0       1       0       0       1       1       1
353-535 1       0       1       1       1       0       1       1       1
222-222 1       1       1       1       0       1       1       0       1
123-456 1       2       1       1       0       0       1       0       1

the following output is generated for characters "ABC".

num     AB      AC      BA      BC      CA      CB      DA
444-888 1       2       1       0       1       1       1
353-535 1       0       1       1       1       1       1
222-222 1       1       1       0       1       0       1
123-456 1       2       1       0       1       0       1
