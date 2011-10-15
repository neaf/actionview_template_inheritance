Gem::Specification.new do |s|
  s.name = %q{actionview_template_inheritance}
  s.version = "0.0.1"
  s.date = %q{2011-10-15}
  s.summary = %q{A set of methods implementing django-like template inheritance in ActionView.}
  s.authors = ["Tomasz Werbicki"]
  s.files = [
    "Gemfile",
    "lib/actionview_template_inheritance.rb"
  ]
  s.require_paths = ["lib"]
  s.add_dependency("actionpack", "~> 3.0")
end
