#!/usr/bin/env ioke

;; Existence before essence
flaviusb = '(Flaviusb with(
  handle: :flaviusb,
  name:   "Justin Marsh",
  about:  "http://flaviusb.net/about",
  writing: {
    :blog    => "http://flaviusb.net/blog",
    :twitter => ["@flaviusb", "http://flaviusb.net/tweets/"],
    :other   => "http://flaviusb.net/other/"
  },
  projects: [
    Code $(name: "Byeloblog", repo: "https://github.com/flaviusb/Byeloblog", description: "A static site generator in Ioke", website: "http://byeloblog.net"),
    Code $(name: "OpenCell", repo: "http://cellml-opencell.hg.sourceforge.net/hgweb/cellml-opencell/cellml-opencell", description: "A CellML Simulation and Editing environment", website: "http://opencell.org"),
    Larp $(name: "Nexus", system: "Storytelling", venue: "Mage: The Awakening", website: "http://nexus.gen.nz"),
  ]
))
;; Types of project
Project = Origin mimic do(
  whitelist = []
  $ = method("Lazy way to initialise a new project of the specified type",
    +:slurp,
    slurp each(kv, (@whitelist include?(kv key)) ifTrue(@cell(kv key) = (kv value))))
)
Code = Project with(
  whitelist: [:name, :repo, :description, :website]
)
Larp = Project with(
  whitelist: [:name, :system, :venue, :website]
)

;; Aspects of me
Programmer  = Origin mimic with(
  languages: {
    comfortable: #{JavaScript, Lisp, Scala, Ioke, C, Ruby, OCaml},
    occasional:  #{Shell, Python, Matlab, cell(:"C++"), Smalltalk, Makefile, Perl, Vimscript}
  }  
)
Raver       = Origin mimic with(
  music: #{ProgHouse, HardHouse, DubStep},
  style: #{TekMaTek}
)
Philosopher = Origin mimic with(
  school: #{FormalLogic, Analytic, BayesianRationalist},
  ethic:  #{NeoNicomachean, Kantian, RuleUtilitarian}
)

;; I am a Philosopher by education, a Programmer by inclination, and a Raver by accident
Flaviusb    = Philosopher with(
  mimic!(Programmer) . mimic!(Raver)
)
;; I am that which I become
flaviusb become!(flaviusb evaluateOn(call Ground))
