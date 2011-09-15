base = "http://flaviusb.net/"
style = dsyntax("Add style sheet link in place.",
  [location]
  ''(''link(rel: "stylesheet", type: "text/css", href: `location))
)
taglist = dsyntax("Add in a taglist",
  [>tags]
  basecase = nil
  tags each(tag, 
    if(basecase == nil,
      basecase = ''((a(href: "http://flaviusb.net/tags/#{`tag}") "#{`tag}") " &#160; "),
      basecase last -> ''((a(href: "http://flaviusb.net/tags/#{`tag}") "#{`tag}") " &#160; ")))
  if(basecase != nil, 
    ''(''(`basecase)),
    nil)
)
documentBuilder = javax:xml:parsers:DocumentBuilderFactory newInstance newDocumentBuilder
firstpart = method("Take the content of a post, and return the first p tag.", text,
  document = (documentBuilder parse(org:xml:sax:InputSource new(java:io:StringReader new("<xml>" + text + "</xml>")))) getDocumentElement
  noptransform = javax:xml:transform:TransformerFactory newInstance newTransformer
  noptransform setOutputProperty(javax:xml:transform:OutputKeys field:OMIT_XML_DECLARATION, "yes")
  bufferhandle = java:io:StringWriter new
  out = javax:xml:transform:stream:StreamResult new(bufferhandle)
  src = javax:xml:transform:dom:DOMSource new(document getElementsByTagName("p") item(0))
  noptransform transform(src, out)
  ''("#{`bufferhandle toString}")
)
entry = method("Add a blog index entry",
  date, url, title, tags, dateobj, content,
  ''((section
          (h2
            (a(href: "#{`url}")
            (span(class: "date") "#{`dateobj toStr}")
            (" &#160; #{`title}"))
          " &#160; &#160; ")
          span(class: "fr") `taglist(tags)
          div `firstpart(content)).)
)
entries = dsyntax("Map entries data to entries",
  [>theentries]
  basecase = nil
  theentries each(anentry, 
    anentry println
    if(basecase == nil,
      basecase = entry(anentry[:date], anentry[:url], anentry[:title], anentry[:tags], anentry[:dateobj], anentry[:content]),
      basecase last -> entry(anentry[:date], anentry[:url], anentry[:title], anentry[:tags], anentry[:dateobj], anentry[:content])))
  ''(''(`basecase))
)
guard = dsyntax("guard(a, b) = nothing if a is nil, otherwise b.",
  [>a, b]
  if(a != nil,
    ''(''(`b)),
   ''(""))
)
''(
`doctype("xml")
`doctype("xhtml")
html(xmlns: "http://www.w3.org/1999/xhtml", lang: "en") (head
  (title "#{`data[:title]}")
  meta(charset: "utf-8")
  `style("#{`base}reset.css")
  `style("#{`base}style.css")
  `style("#{`base}syntax.css")
  `style("#{`base}container.css")
  `style("#{`base}mono.css")
  `style("http://fonts.googleapis.com/css?family=Inconsolata")
  link(href: "#{`base}atom.xml", type: "application/atom+xml", rel: "alternate", title: "Blog Atom Feed") 
  link(rel: "shortcut icon", href: "#{`base}favicon.png", type: "image/png"))
  (body
    (h2 "#{`data[:subtitle]}")
    (article
      `entries(data[:entries]))
    (p
      a(href: "http://flaviusb.net") "Home"
      "   |   "
      `guard(data[:tag],
        a(rel: "index", href: "http://flaviusb.net/blog") "Blog"
        "   |   "
        a(rel: "index", href: "http://flaviusb.net/tags") "Tags"
        "   |   ")
      a(href: "http://github.com/flaviusb") "Code")))
