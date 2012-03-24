/*
 * This file is part of ktools.
 *
 * ktools is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ktools is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ktools.  If not, see <http://www.gnu.org/licenses/>.
 */

import java.io.*;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class NMer {

    private static class IntHolder {
	int i = 0;		
	void incr() { i++; }
    }

    Map<String,Map<String,IntHolder>> tab =
	new java.util.HashMap<String,Map<String,IntHolder>>();
    int tokenLen;

    public NMer (int tl) {
	if (tl <= 0) {
	    throw new IllegalArgumentException
		("Token length must be positive");
	}
	tokenLen = tl;
    }

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
	    if (line.trim().equals ("")) continue;
	    String subjectID = "none";
	    if (line.indexOf (":") >= 0) {
		String[] lparts = line.split (":", 2);
		subjectID = lparts[0];
		line = lparts[1];
	    }
	    Map<String,IntHolder> lineTab =
		new java.util.HashMap<String,IntHolder>();
	    tab.put (subjectID, lineTab);
	    for (int i = 0; i < line.length() - tokenLen + 1; i++) {
		String token = line.substring (i, i + tokenLen);
		IntHolder ih = lineTab.get (token);
		if (ih == null) {
		    ih = new IntHolder();
		    lineTab.put (token, ih);
		}
		ih.incr();
	    }
	}
    }
	
    public void dump (PrintStream out) throws IOException {
	Set<String> allTransitions = new java.util.HashSet<String>();
	for (Map<String,IntHolder> lineTab : tab.values()) {
	    allTransitions.addAll (lineTab.keySet());
	}
	List<String> transitions =
	    new java.util.ArrayList<String> (allTransitions);
	Collections.sort (transitions);

	out.print ("num");
	for (String transition : transitions) { out.print ("\t" + transition); }
	out.println ("");

	for (Map.Entry<String,Map<String,IntHolder>> e : tab.entrySet()) {
	    out.print (e.getKey());
	    Map<String,IntHolder> tab = e.getValue();
	    for (String transition : transitions) {
		IntHolder ih = tab.get (transition);
		if (ih != null) {
		    out.print ("\t" + tab.get (transition).i);
		} else {
		    out.print ("\t0");
		}
	    }
	    out.println ("");
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
