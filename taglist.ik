base = "http://flaviusb.net/"
style = dsyntax("Add style sheet link in place.",
  [location]
  ''(''link(rel: "stylesheet", type: "text/css", href: `location))
)
tag = method("Add a tag entry",
  date, url, title, number,
  ''(li
      (a(href: "#{`url}") "#{`title}")
      " &#160; "
      (span a(href: "#{`url}") "#{`number}"))
)
entries = dsyntax("Map entries data to entries",
  [>theentries]
  basecase = nil
  theentries each(anentry, 
    anentry println
    if(basecase == nil,
      basecase = tag(anentry[:date], anentry[:url], anentry[:title], anentry[:number]),
      basecase last -> tag(anentry[:date], anentry[:url], anentry[:title], anentry[:number])))
  ''(''(`basecase))
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
  link(rel: "shortcut icon", href: "#{`base}favicon.png", type: "image/png"))
  (body
    (h2 "#{`data[:subtitle]}")
    (ul(class: "posts")
      `entries(data[:entries]))
    (p
      a(href: "http://flaviusb.net") "Home"
      "   |   "
      a(rel: "index", href: "http://flaviusb.net/blog") "Blog"
      "   |   "
      a(href: "http://github.com/flaviusb") "Code")))
