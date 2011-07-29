base = "/var/www/flaviusb.net/htdocs/"
;base = "./"
GenX baseURI = "http://flaviusb.net/"
atom_data = {
  entries: [
   {title: "A", url: "A", updated: "just now", id: "A", content: "The flergy blergy wergied the clergy."},
   {title: "B", url: "B", updated: "just now", id: "B", content: "Nothing to see here citizen. Move along."}
  ],
  title: "Main feed",
  updated: "just now",
  modified: ""
}
about_data = {
  title: "Describe :flaviusb",
  modified: "",
  content: GenX fromMD("about.md")
}
other_data = {
  title: "Other works",
  modified: "",
  content: GenX fromMD("other.md")
}
index_in  = FileSystem readFully("index.in.html")
link = fn(href, #[&quot;<a href="#{href[6...-6]}">#{href[6...-6]}</a>&quot;])
strings = #/&quot;https?:\/\/[^&]*&quot;/ allMatches(index_in)
strings each(rep, index_in = index_in replace(rep, link(rep)))
strings = #/&quot;@[a-zA-Z0-9]*&quot;/ allMatches(index_in)
strings each(rep, index_in = index_in replace(rep, #[&quot;<a href="twitter.com/#{rep[7...-6]}">#{rep[6...-6]}</a>&quot;]))
index_data = {
  title:    "inspect(:flaviusb)",
  content:  index_in,
  modified: ""
}
nomod = {
  modified: ""
}
GenX build(base: base,
  (atom_data  => "atom.xml")    => "atom.ik",
  (index_data => "index.html")  => "index.ik",
  (about_data => "about.html")  => "container.ik")

GenX deployRaw(base: base,
  "*.css", "favicon.png")
