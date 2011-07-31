---
layout: post
title: Thoughts on Syntax Highlighting
tags:
- programming
- musing
---

These thoughts are supposed to be a flog for language design, as without a new language they probably don't make a whole lot of sense.


- Some highlighting should be just to show different quoting and interpolation regimes ie "string", 'string', """string""", /regex/,  &lt;bare words&gt;, numbers, bitstrings/bitfields, vstrings?
- Possibly instead, think of it as a view for 'literals'?
- What about stupid literals, like literal xml?
- Symbols? ie :symbol
- Quasiquotation? ie \`(This is a ,(+ 'quasi 'quoted) list)
- Some highlighting should be a 'tint', ie comments? Such that it can be combined with different syntax highlighting.
- Some kinds of structures should have highlighting around them ie anything whitespace dependant, some of the homoiconic stuff I was suggesting earlier...
- Scope ie rainbow brackets for matching brackets (even different kinds of brackets)
- Keywords
- Operators
- Types, typeclasses
- ASTs? Macros? Lecros? Embedded DSLs, or simply embedded other languages? Markdown inside comments or docstrings?

Grammar first, then AST, then syntax highlighting, then grammar.


Yes, I know that does not form a DAG.


