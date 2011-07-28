entry = dsyntax("Add entry in place",
  [>title, >url, >updated, >id, >content]
  ''(''((entry
          title `title
          link(href: "http://flaviusb.net/#{`url}")
          updated `updated
          id "http://flaviusb.net/#{`id}"
          content(type: "html") `content).)
))
; foo = [{title: "A", url: "A", updated: "just now", id: "A", content: "The flergy blergy wergied the clergy."},
;        {title: "B", url: "B", updated: "just now", id: "B", content: "Nothing to see here citizen. Move along."}]
entries = dsyntax("Map entries data to entries",
  [>theentries]
  basecase = nil
  theentries each(anentry, 
    if(basecase == nil,
      basecase = entry(anentry[:title], anentry[:url], anentry[:updated], anentry[:id], anentry[:content]),
      basecase last -> entry(anentry[:title], anentry[:url], anentry[:updated], anentry[:id], anentry[:content])))
  ''(''(`basecase))
)
''(
`doctype("xml")
feed(xmlns: "http://www.w3.org/2005/Atom")
  title "#{`data[:title]}"
  `(if(data[:tag] != nil,
    ''(link(href: "http://flaviusb.net/tags/#{`data[:tag]}.xml", rel: "self")),
    ''(link(href: "http://flaviusb.net/atom.xml", rel: "self"))))
  link(href: "http://flaviusb.net")
  updated "#{`data[:updated]}"
  id `(if(data[:tag] != nil,
        "http://flaviusb.net/tags/#{`data[:tag]}",
        "http://flaviusb.net/")
  (author
    name "Justin (:flaviusb) Marsh"
    email "justin.marsh@flaviusb.net"
  )
  `entries(`data[:entries])
)
