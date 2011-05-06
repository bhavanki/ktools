// Based on public domain code from http://www.merriampark.com/ld.htm

import java.io.*;

public class Lev {

    /**
     * Finds the minimum of three values.
     */
    private static int min (int a, int b, int c) {
	int m = a;
	if (b < m) m = b;
	if (c < m) m = c;
	return m;
    }

    public static int lev (String s, String t) {
	// Step 1
	int n = s.length();
	int m = t.length();
	if (n == 0) return m;
	if (m == 0) return n;
	int d[][] = new int [m + 1][n + 1];  // m + 1 rows, n + 1 columns

	// Step 2
	// - first row = 0 through n
	for (int i = 0; i <= n; i++) {
	    d[0][i] = i;
	}
	// - first column = 0 through m
	for (int i = 0; i <= m; i++) {
	    d[i][0] = i;
	}

	// Step 3
	for (int i = 1; i <= n; i++) {
	    char sc = s.charAt (i - 1);

	    // Step 4
	    for (int j = 1; j <= m; j++) {
		char tc = t.charAt (j - 1);

		// Step 5
		int cost = (sc == tc ? 0 : 1);
				
		// Step 6
		d[j][i] = min
		    (d[j - 1][i] + 1,  // cell above + 1
		     d[j][i - 1] + 1,   // cell to left + 1
		     d[j - 1][i - 1] + cost);   // cell above and left + cost
	    }
	}
		
	// Step 7
	return d[m][n];
    }
	
    public static void main (String args[]) throws Exception {
	String base = args[0];
	InputStreamReader isr = null;
	BufferedReader br = null;
	try {
	    isr = new InputStreamReader (System.in);
	    br = new BufferedReader (isr);

	    String line;
	    while ((line = br.readLine()) != null) {
		if (line.trim().equals ("")) continue;
		if (line.indexOf (":") >= 0) {
		    String[] lparts = line.split (":", 2);
		    System.out.print (lparts[0] + ":");
		    line = lparts[1];
		}
		System.out.println (lev (base, line));
	    }
	} finally {
	    if (br != null) { br.close(); }
	    if (isr != null) { isr.close(); }
	}
    }

}
