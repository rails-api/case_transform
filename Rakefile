# frozen_string_literal: true
require 'bundler/gem_tasks'
require 'rake/clean'
require 'rake/testtask'
require 'bundler/setup'

# rubocop config copied from AMS
begin
  require 'rubocop'
  require 'rubocop/rake_task'
rescue LoadError # rubocop:disable Lint/HandleExceptions
else
  Rake::Task[:rubocop].clear if Rake::Task.task_defined?(:rubocop)
  require 'rbconfig'
  # https://github.com/bundler/bundler/blob/1b3eb2465a/lib/bundler/constants.rb#L2
  windows_platforms = /(msdos|mswin|djgpp|mingw)/
  if RbConfig::CONFIG['host_os'] =~ windows_platforms
    desc 'No-op rubocop on Windows-- unsupported platform'
    task :rubocop do
      puts 'Skipping rubocop on Windows'
    end
  elsif defined?(::Rubinius)
    desc 'No-op rubocop to avoid rbx segfault'
    task :rubocop do
      puts 'Skipping rubocop on rbx due to segfault'
      puts 'https://github.com/rubinius/rubinius/issues/3499'
    end
  else
    Rake::Task[:rubocop].clear if Rake::Task.task_defined?(:rubocop)
    desc 'Execute rubocop'
    RuboCop::RakeTask.new(:rubocop) do |task|
      task.options = ['--rails', '--display-cop-names', '--display-style-guide']
      task.fail_on_error = true
    end
  end
end



directory 'target'
directory 'lib/turbo_blank'

task :cargo_build do
  sh 'cargo build --release'
  sh 'gcc ' \
    '-Wl,-force_load,target/release/libcase_transform.a ' \
    '--shared -Wl,-undefined,dynamic_lookup -o lib/case_transform/native.bundle'
end
CLEAN.include('target')

file 'lib/case_transform/native.bundle' => ['lib/case_transform', :cargo_build] do
  sh 'gcc ' \
    '-Wl,-force_load,target/release/libcase_transform.a ' \
    '--shared -Wl,-undefined,dynamic_lookup -o lib/case_transform/native.bundle'

end
CLOBBER.include('lib/case_transform/native.bundle')

task irb: 'lib/case_transform/native.bundle' do
  exec 'irb -Ilib -rcase_transform'
end

task benchmark: 'lib/case_transform/native.bundle' do
  exec 'ruby -Ilib benchmark.rb'
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end
#
task :test => "lib/case_transform/native.bundle"
task default: [:test, :rubocop]


desc 'CI test task'
task ci: [:default]
