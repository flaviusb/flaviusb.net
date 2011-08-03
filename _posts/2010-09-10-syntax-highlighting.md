---
title: Thoughts on Syntax Highlighting
tags:
- programming
- musing
---

These thoughts are supposed to be a flog for language design, as without a new language they probably don't make a whole lot of sense.


- Some highlighting should be just to show different quoting and interpolation regimes ie "string", 'string', """string""", /regex/flags,  &lt;bare words&gt;, numbers, bitstrings/bitfields, vstrings? In interpolated sections, have a lighter tint of the appropriate background colour; ie "foo #{bar}"
- Quotation and quasiquotation are just a special case of the above - ie \`(This is a ,(+ 'quasi 'quoted) list in lisp) or ''(A \`('quasi -> 'quoted) message in Ioke) vs "string #{"int" + "erpolation"} in Ioke" 
- Some highlighting should be a range of tints, with possible nesting rules, ie for strings, quoted lists/messages, comments etc? Such that it can be combined with different syntax highlighting.
- Possibly instead, think of it as a view for 'literals'?
- What about stupid literals, like literal xml?
- Quajects (ie showing code generators)
- Symbols? ie :symbol
- How about colouration for 'customary usage' ie &rest in a CL arg list?
- Some kinds of structures should have highlighting *around* them ie anything whitespace dependant, some of the homoiconic stuff I was suggesting earlier...
- Scope ie rainbow brackets for matching brackets (even different kinds of brackets); possible with 'rainbow quotes etc' mode also for quick visual inspections.
- Keywords
- Operators
- Types, typeclasses
- ASTs? Macros? Lecros? Embedded DSLs, or simply embedded other languages? Markdown inside comments or docstrings?

Grammar first, then AST, then syntax highlighting, then grammar.


Yes, I know that does not form a DAG.


