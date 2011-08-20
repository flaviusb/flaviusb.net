---
title: Implementing a letrec-alike in Ioke
tags:
- programming
- ioke
- code
---

So, some time ago I tried to demonstrate the Parser Combinator approach to parsing to a friend, with a simple json parser in Ioke. This parser would be built in two layers; a generic <code class="nc">Parser</code> object, with some basic combinators, and a <code class="nc">JSONParser</code> object with additional parsers for JSON. The simple parser was easy enough; <code class="nf">lit</code>, <code class="nf">alt</code>, <code class="nf">seq</code>, <code class="nf">star</code>, <code class="nf">many1</code>, <code class="nf">wrapped</code> etc were easy to define. Things became interesting when, for the JSON parser, I had definitions for <code class="nf">list</code> and <code class="nf">dict</code> which were mutually recursive. Theoretically, the <code class="k">with</code> construct should enable this; as it turns out, it seems to only work when the receiver of 

