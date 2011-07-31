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
strings each(rep, index_in = index_in replace(rep, #[&quot;<a href="http://twitter.com/#{rep[7...-6]}">#{rep[6...-6]}</a>&quot;]))
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
  (about_data => "about.html")  => "container.ik",
  (other_data => "other.html")  => "container.ik")

; Deploy assets
GenX deployRaw(base: base,
  "*.css", "favicon.png")

; Generate blog posts

blog_data = {
  title:    "inspect(:flaviusb)"
}
simple_ini_parser = method(ini,
  ret = {}
  lines = ini split("\n")
  state = :kv ; states can be :kv, :list
  currkey = nil
  acc = []
  lines each(line,
    if(state == :kv,
      if(#/^([^:]*):\s*(\S.*)$/ =~ line,
        (k, v) = it captures
        ret[k] = v,
        if(#/^([^:]*):\s*$/ =~ line,
          state = :list
          currkey = it captures[0]
          acc = [])
      ),
      if(state == :list,
        if(#/^- (.*)$/ =~ line,
          ;"Adding #{it captures[0]} to #{acc}" println
          acc push!(it captures[0]),
          state = :kv
          ret[currkey] = acc
          currkey = nil
          acc = []
          if(#/^([^:]*):\s*(\S.*)$/ =~ line,
            (k, v) = it captures
            ret[k] = v))
      )
    )
  )
  if(state == :list && acc != [] && currkey != nil,
    ret[currkey] = acc)
  return ret
)
posts = FileSystem [ "_posts/*.md" ]
posts each(post,
  "Generating blog post: #{post}" println
  preslug = #/^_posts\/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)\.md$/ match(post) captures
  slug = (preslug[0...-1] join("/")) + "/#{preslug[-1]}.html"
  "Slug is: #{slug}" println
  full = FileSystem readFully(post)
  (prelude, precontent) = (#/\A---\n(.*?)\n---\n(.*)\z/m =~ full) captures
  "Prelude is:" println
  prelude println
  lude = simple_ini_parser(prelude)
  "Parsed prelude as #{lude}" println
  content = GenX fromMDText(precontent)
  "Generated Markdown content" println
  lude[:content] = content
  "Building blog post: #{post}" println
  GenX build(base: base + "blog/", (lude => slug) => "post.ik"))
