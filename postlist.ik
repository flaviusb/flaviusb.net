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
entry = method("Add a blog index entry",
  date, url, title, tags,
  ''(li
          (span "#{`date}")
          " » "
          (a(href: "#{`url}") "#{`title}")
          " &#160; &#160; "
          span `taglist(tags))
)
entries = dsyntax("Map entries data to entries",
  [>theentries]
  basecase = nil
  theentries each(anentry, 
    anentry println
    if(basecase == nil,
      basecase = entry(anentry[:date], anentry[:url], anentry[:title], anentry[:tags]),
      basecase last -> entry(anentry[:date], anentry[:url], anentry[:title], anentry[:tags])))
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
    (ul(class: "posts")
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
