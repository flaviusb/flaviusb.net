footerBorder = 6
footerHeight = 80
''(
; First we have code stuff
code {
  background: "#f8f8ff",
  border: "1px solid #dedede",
  padding: "0 0.2em",
  "font-size"   => "1em",
  "font-family" => #["Inconsolata","Menlo", "Monaco", "Andale Mono", "Consolas", "Bitstream Vera Sans Mono", "Liberation Mono", monospace]
}
p code | div code {
  "font-size"   => "0.8em"
}
pre {
  "font-size"   => "1em",
  "font-family" => #["Inconsolata","Menlo", "Monaco", "Andale Mono", "Consolas", "Bitstream Vera Sans Mono", "Liberation Mono", monospace]
}
div pre code {
  border: "0px",
  padding: "0px",
  "font-size"   => "1em"
}

; Then we have actual layout

a:hover, $tags a:hover { ^textDecoration :underline, color: :blue }

h2 a {
  color: "black",
  ^textDecoration :none
}

$rc {
  "border-radius" => "10px",
  border: "1px solid #dedede",
  "min-height" => "75px",
  width: "100%"  
}

html | body {
  height: "100%"
}

$container {
  "min-height" => "100%",
  "margin-bottom" => "-#{`footerHeight + `footerBorder}px",
  position: "relative"
}

$footergap {
  height: "#{`footerHeight + `footerBorder}px",
  clear: "both"
}

$footer {
  height: "#{`footerHeight}px",
  position: "relative",
  color: "#444",
  "background-color" => "#d5e1e9",
  "border-top" => "#{`footerBorder}px solid #444"
}
h1 {
  "font-size" => "200%"
}
h2 {
  "font-size" => "150%"
}

;p | div | code | pre | body | h1 | h2 {
;  "line-height" => "1.1em"
;}

h1 | h2 | p {
  margin: "0.2em 0",
  padding: "0.2em 0"
}
$gap {
  margin: "25px"
}
section {
  "margin-bottom" => "25px"
}

$tags a {
  color: "#aaa",
  "font-size" => "80%"
}

$outsideborder {
  background: "#f8f8ff"
}

"/* Floating & Alignment */\n"
$fl{float: :left}
$fr{float: :right}
$ac{"text-align" => "center"}
$ar{"text-align" => "right"}

"/* Clear floats */\n"
$clear {
	background: :none,
	border: "0",
	clear: :both,
	display: :block,
	float: :none,
	"font-size" => "0",
	"list-style" => :none,
	margin: "0",
	padding: "0",
	overflow: :hidden,
	visibility: :hidden,
	width: "0",
	height: "0",
} "/* http://sonspring.com/journal/clearing-floats */"

)
