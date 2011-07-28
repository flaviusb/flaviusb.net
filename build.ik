;base = "/var/www/flaviusb.net/htdocs/"
base = "./"
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
index_data = {
  title:    "inspect(:flaviusb)",
  content:  FileSystem readFully("index.in.html"),
  modified: ""
}
nomod = {
  modified: ""
}
GenX build(base: base,
  (atom_data => "atom.xml")     => "atom.ik",
  (index_data => "index.html")  => "index.ik")
