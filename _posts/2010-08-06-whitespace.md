---
title: Whitespace and XML file manipulation in Scala
tags:
- programming
- scala
---

Sometimes, when one wants to write a script to manipulate xml files, one does not only care about the abstract xml infoset. The existing layout can be important if
people edit the xml by hand, or the size of the diff is important; for example if the manipulated xml files are version controlled, and people want to read the diffs to know what changed in a changeset, as was the case with large scale autmated model changes in the CellML repository. The stock answer here is often 'use a regex'. This really didn't appeal to me; I'd much rather use a programmatic transform, and avoid the problematic edge cases that regexen cannot catch, even if I had to do stuff in a pretty limited way in order to get the small diffs. So, I wrote a wrapper for producing augmented xml objects, and a wrapper around <code class="nc">scala.xml.transform.RewriteRule</code> to allow me to manipulate them. The result is ugly and brittle in a library sense but, importantly, not in a permutations of structure way.

The wrapper can be found [here](http://github.com/flaviusb/minimal-xml-transform). It requires Scala 2.8.0. The library provides a loader for xml which produces a Node with preserved attribute order, and inserted nodes to mark whitespace inside attribute lists, along with a subclass of RewriteRule which can correctly iterate over the augmented Node object.

To use the wrapper, each distinct programmatic edit which needs to be implemented in an independent pass should be implemented as a subclass of <code class="nc">net.flaviusb.xml.RewriteWrapper</code>, overriding the method <code><span class="n">wrappedTransform</span><span class="o">(</span><span class="n">node</span><span class="k">:</span> <span class="kt">Node</span><span class="o">)</span><span class="k">:</span> <span class="kt">Node</span></code>. The object <code class="nc">net.flaviusb.xml.MinimalXMLTransformer</code> has a method <code><span class="n">transformFile</span><span class="o">(</span><span class="n">file</span><span class="k">:</span> <span class="kt">String</span>, <span class="n">rule</span><span class="k">:</span> <span class="kt">RewriteRule</span><span class="o">)</span><span class="k">:</span> <span class="kt">Unit</span></code> which rewrites a file in-place, in one pass. For my use case, after each transformation I wanted to do a commit, for a series of minimal diffs; it would be trivial to add support for having multiple transformations per pass, however.

The whole thing is quite slow, as it is implemented as a series of pessimisations over the top of the Scala standard xml handlers; each extra factor preserved was implemented by undoing a simplifying assumption in the standard libraries.
