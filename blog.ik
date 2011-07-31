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
      basecase = ''((a(href: "http://flaviusb.net/tags/#{`tag}") "#{`tag}") " &nbsp; "),
      basecase last -> ''((a(href: "http://flaviusb.net/tags/#{`tag}") "#{`tag}") " &nbsp; ")))
  if(basecase != nil, 
    ''(''(`basecase)),
    nil)
)
entry = dsyntax("Add a blog index entry",
  [>date, >url, >title, >tags]
  ''(''(li
          (span "#{`date}")
          " &raquo; "
          (a(href: `url) "#{`title}")
          " &nbsp; &nbsp; "
          span `taglist(`tags)))
)
entries = dsyntax("Map entries data to entries",
  [>theentries]
  basecase = nil
  theentries each(anentry, 
    if(basecase == nil,
      basecase = entry(anentry[:date], anentry[:url], anentry[:title], anentry[:tags]),
      basecase last -> entry(anentry[:date], anentry[:url], anentry[:title], anentry[:tags])))
  ''(''(`basecase))
)

''(
`doctype("xml")
`doctype("xhtml")
html(xmlns: "http://www.w3.org/1999/xhtml", lang: "en") (head
  title "cell(":flaviusb") blog entryNames"
  meta(charset: "utf-8")
  `style("#{`base}reset.css")
  `style("#{`base}style.css")
  `style("#{`base}syntax.css")
  `style("#{`base}container.css")
  `style("#{`base}mono.css")
  `style("http://fonts.googleapis.com/css?family=Inconsolata")
  link(rel: "shortcut icon", href: "#{`base}favicon.png", type: "image/png"))
  (body
    h2 "Entries."
    (ul(class: "posts")
      `entries(data[:entries]))
    (p
      a(href: "http://flaviusb.net") "Home"
      "   |   "
      a(href: "http://github.com/flaviusb") "Code")))
