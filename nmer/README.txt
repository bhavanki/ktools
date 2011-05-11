NMer counts the number of transitions between tokens of a given length
in a file of strings.

Run it from the command line like this to read from a file (the dollar
sign is the prompt):

$ java NMer <filename> <token-length>

You can also have it read from standard input:

$ java NMer <token-length> < <filename>

The file should contain strings representing state transitions. Here is an
example:

ABACADAC
BADACABD
CBABCADA
DACABACB

Each line of the input file may be prefixed by a string followed by a
colon. Such a prefix is preserved in the output.

The token length must be an integer less than the length of each string. For
example, if a string is eight characters, you can use token lengths up
to and including 8.

$ java NMer 1 < test1_prefix.txt
num     A       B       C       D
444-888 3       2       2       1
353-535 3       2       2       1
222-222 3       2       1       2
123-456 4       1       2       1

$ java NMer 2 < test1_prefix.txt
num     AB      AC      AD      BA      BC      BD      CA      CB      DA
444-888 1       2       0       1       0       0       1       1       1
353-535 1       0       1       1       1       0       1       1       1
222-222 1       1       1       1       0       1       1       0       1
123-456 1       2       1       1       0       0       1       0	1

To save the output to a file, use the redirection operator.

$ java NMer test1.txt 2 > nmer2.txt

or

$ java NMer 2 < test1.txt > nmer2.txt
