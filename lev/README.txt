Lev finds the Levenshtein distance between strings.

Run it from the command line like this (the dollar sign is the prompt):

$ java Lev <base-string>

Lev takes in variations on the base string from standard input, one
per line. You can feed the variations in from a file, or from the
output of another program.

$ java Lev <base-string> < <input-file>
$ cat <input-file> | java Lev <base-string>

For example, assume that test.txt contains:

SOAP
SLOP
POUR
NUTS

$ java Lev SOUP < test.txt
1
2
2
4

To save the output to a file, use the redirection operator.

$ java Lev SOUP < test.txt > distances.txt

Each line of the input file may be prefixed by a string followed by a
colon. Such a prefix is preserved in the output. For example, if
test.txt contains:

A:SOAP
B:SLOP
C:POUR
D:NUTS

the output for the execution above would be:

A:1
B:2
C:2
D:4
