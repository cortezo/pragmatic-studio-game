Gem::Specification.new do |s|
	s.name 			= "studio_game"
	s.version 		= "1.0.0"
	s.author 		= "Victor W"
	s.email 		= "vwalldev@gmail.com"
	s.homepage 		= "http://nonenone.none.com"
	s.summary		= "Pragmatic Studio Game"
	s.description	= File.read(File.join(File.dirname(__FILE__), 'README'))

	s.files			= Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
	s.test_files	= Dir["spec/**/*"]
	s.executables	= ['studio_game']

	s.required_ruby_version = '>=1.9'
	s.add_development_dependency 'rspec'
end