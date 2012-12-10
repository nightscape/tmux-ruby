Gem::Specification.new do |s|
  s.name = "tmux"
  s.version = "0.0.1"

  s.authors = ["Dominik Honnef", "Abhi Yerra", "Martin Mauch"]
  s.date = "2011-10-02"
  s.description = "Allow Ruby to interact with Tmux"
  s.email = "dominikh@fork-bomb.org"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  #s.add_development_dependency "rcov", ">= 0"
  s.homepage = "http://github.com/dominikh/tmux"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Allow Ruby to interact with Tmux"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "filesize"
  s.add_development_dependency "shoulda", ">= 0"
  s.add_development_dependency "flexmock", ">= 0"

end

