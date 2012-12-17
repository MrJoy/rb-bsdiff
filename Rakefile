require 'rake/clean'
require 'rake/testtask'

CLEAN.include '**/*.o'
CLEAN.include "**/*.#{Config::MAKEFILE_CONFIG['DLEXT']}"
CLOBBER.include '**/Makefile'
CLOBBER.include '**/bsdiff_config.h'
CLOBBER.include '**/mkmf.log'

BSDIFF_SO = "ext/bsdiff.#{Config::MAKEFILE_CONFIG['DLEXT']}"

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
