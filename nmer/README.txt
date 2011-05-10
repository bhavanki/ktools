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

The token length must be an integer factor of the length of each string. For
example, if a string is eight characters, you can use token lengths of 1, 2,
or 4.

$ java NMer test1.txt 1
AB      4
AC      5
AD      3
BA      4
BC      1
BD      1
CA      4
CB      2
DA      4
$ java NMer test1.txt 2
ABAC    1
ABCA    1
ACAD    1
ADAC    1
BACB    1
BADA    1
CABA    1
CABD    1
CADA    1
CBAB    1
DACA    2

To save the output to a file, use the redirection operator.

$ java NMer test1.txt 2 > nmer2.txt

or

$ java NMer 2 < test1.txt > nmer2.txt
