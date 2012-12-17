require 'rake/clean'
require 'rake/testtask'

CLEAN.include '**/*.o'
CLEAN.include "**/*.#{RbConfig::MAKEFILE_CONFIG['DLEXT']}"
CLOBBER.include '**/Makefile'
CLOBBER.include '**/bsdiff_config.h'
CLOBBER.include '**/mkmf.log'

BSDIFF_SO = "ext/bsdiff.#{RbConfig::MAKEFILE_CONFIG['DLEXT']}"

MAKECMD = ENV['MAKE_CMD'] || 'make'
MAKEOPTS = ENV['MAKE_OPTS'] || ''

desc "Test project"
task :default => ['compile', 'test']

file 'ext/Makefile' => 'ext/extconf.rb' do
  Dir.chdir('ext') do
    ruby "extconf.rb #{ENV['EXTCONF_OPTS']}"
  end
end

# Let make handle dependencies between c/o/so - we'll just run it.
file BSDIFF_SO => (['ext/Makefile'] + Dir['ext/*.c'] + Dir['ext/*.h']) do
  m = 0
  Dir.chdir('ext') do
    pid = system("#{MAKECMD} #{MAKEOPTS}")
    m = $?.exitstatus
  end
  fail "Make failed (status #{m})" unless m == 0
end

desc "Compile the shared object"
task :compile => [BSDIFF_SO]

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test.rb']
  t.verbose = false
end

desc "Re-generate gemspec"
task :gemspec do
  ENV['TZ'] = 'UTC'
  require 'date'

  IGNORE_LIST=Set.new(FileList[
    '.gitignore',
    'Rakefile',
    'test.rb',
    'VERSION',
    'src.md',
    'src/**/*',
    'patches/**/*'
  ])

  PROJECT_NAME=%q{rb-bsdiff}
  gemspec = Gem::Specification.new do |s|
    s.name = PROJECT_NAME
    s.version = File.read('VERSION').strip
    s.date = DateTime.now.strftime("%Y-%m-%d")

    s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ["Todd Fisher", "Jon Frisby"]
    s.email = %q{todd.fisher@gmail.com jon@cloudability.com}
    s.description = %q{Ruby bindings to bindary diff tools bsdiff and bspatch}
    s.summary = %q{Ruby bindings to bindary diff tools bsdiff and bspatch}
    s.extensions = ["ext/extconf.rb"]
    s.files = (Set.new(`git ls-files --`.strip.split(/\n/)) - IGNORE_LIST).to_a.sort

    s.has_rdoc = true
    s.homepage = %q{http://github.com/cloudability/rb-bsdiff}
    s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
    s.require_paths = ["lib"]
    s.rubyforge_project = %q{rb-bsdiff}

    if s.respond_to? :specification_version then
      current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
      s.specification_version = 2
    end
  end.to_ruby

  File.open("#{PROJECT_NAME}.gemspec", "w") do |fh|
    gemspec = gemspec.split(/\n/)
    new_gemspec = []
    new_gemspec << gemspec.shift # Character encoding line...
    new_gemspec << "# WARNING: This file is auto-generated via 'rake gemspec'!  DO NOT EDIT BY HAND!"
    new_gemspec += gemspec
    fh.write(new_gemspec.join("\n"))
    fh.write("\n")
  end
end

desc "Generate patches between original and modified sources, before updating original sources."
task :generate_patches do
  FileUtils.rm_f FileList['patches/*.diff']
  FileList['src/*.c'].each do |srcname|
    dstname = srcname.sub(/^src\//, 'ext/')
    patchname = srcname.sub(/^src\//, 'patches/') + ".diff"

    # The '| cat' is because diff returns a status code of 1.  Bleah.
    sh "diff --unified --minimal #{srcname.shellescape} #{dstname.shellescape} > #{patchname.shellescape} | cat"
  end
end

desc "Start a shell in the context of Rake."
task :irb do
  require 'irb'
  ARGV.clear
  IRB.start
end
