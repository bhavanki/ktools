import java.io.*;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class NMer {

    private static class IntHolder {
	int i = 0;		
	void incr() { i++; }
    }

    Map<String,IntHolder> tab = new java.util.HashMap<String,IntHolder>();
    int tokenLen;

    public NMer (int tl) { tokenLen = tl; }

    public void processStdin() throws IOException {
	InputStreamReader isr = null;
	BufferedReader br = null;
	try {
	    isr = new InputStreamReader (System.in);
	    br = new BufferedReader (isr);
	    processBR (br);
	} finally {
	    if (br != null) br.close();
	    if (isr != null) isr.close();
	}
    }
	
    public void process (String fn) throws IOException {
	FileReader fr = null;
	BufferedReader br = null;
	try {
	    fr = new FileReader (fn);
	    br = new BufferedReader (fr);
	    processBR (br);
	} finally {
	    if (br != null) br.close();
	    if (fr != null) fr.close();
	}
    }

    private void processBR (BufferedReader br) throws IOException {
	String line;
	int lineNo = 0;
	while ((line = br.readLine()) != null) {
	    lineNo++;
	    if (line.length() % tokenLen != 0) {
		throw new IllegalArgumentException
		    ("Line " + lineNo + " has " + line.length() +
		     " characters, not divisible by token length " + tokenLen);
	    }
	    for (int i = 0; i < line.length() - tokenLen; i += tokenLen) {
		String token = line.substring (i, i + tokenLen);
		String nextToken = line.substring (i + tokenLen,
						   i + (2 * tokenLen));
		String transition = token + nextToken;
		IntHolder ih = tab.get (transition);
		if (ih == null) {
		    ih = new IntHolder();
		    tab.put (transition, ih);
		}
		ih.incr();
	    }
	}
    }
	
    public void dump (PrintStream out) throws IOException {
	List<String> transitions = new java.util.ArrayList<String> (tab.keySet());
	Collections.sort (transitions);
	for (String transition : transitions) {
	    out.println (transition + "\t" + tab.get (transition).i);
	}
    }

    public static void main (String args[]) throws Exception {	
	String fn = null;
	int tokenLen;
	if (args.length == 1) {
	    tokenLen = Integer.parseInt (args[0]);
	} else {
	    fn = args[0];
	    tokenLen = Integer.parseInt (args[1]);
	}
	NMer nmer = new NMer (tokenLen);
	if (fn != null) {
	    nmer.process (fn);
	} else {
	    nmer.processStdin();
	}
	nmer.dump (System.out);
    }
}
