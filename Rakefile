# encoding: utf-8

require 'rake'

require 'yard'
YARD::Rake::YardocTask.new('doc') do |t|
  t.files = ['lib/mensario.rb', 'lib/mensario/exception.rb', 'lib/mensario/api_exception.rb', 'lib/mensario/http_exception.rb']
  t.options = ['-m','markdown', '-r' , 'README.markdown']
end 

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = ["./features"] 
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["--format doc", "--color"]
  spec.pattern = FileList['spec/**/*_spec.rb']
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more     options
  gem.name = 'mensario'
  gem.homepage = 'http://github.com/nosolosoftware/mensario'
  gem.license = 'GPL-3'
  gem.summary = %Q{Wrapper around Mensario API}
  gem.description = %Q{This gem allow us to send, check status and destroy sms using the Mensario service api}
  gem.email = ['jaranda@nosolosoftware.biz', 'jgalisteo@nosolosoftware.biz']
  gem.authors = ['Javier Aranda', 'Juan Antonio Galisteo']
  # dependencies defined in Gemfile

  # Files not included
  ['Gemfile', 'Rakefile', 'features', 'config'].each do |d|
    gem.files.exclude d
  end
end
Jeweler::RubygemsDotOrgTasks.new
