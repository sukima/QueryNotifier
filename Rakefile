require 'rubygems'
require 'bundler/setup'

require 'rake/packagetask'
require 'rake/clean'
require 'rake/testtask'
require 'coffee-script'

Rake::PackageTask.new("QueryNotifier", "0.1.0") do |p|
  js_files = `git ls-files`.split(/\n/)
  p.need_tar_gz = true
  p.package_files.include("public/javascripts/*.js", js_files)
end

CLEAN.include("public/javascripts/*.js")

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

namespace :js do
  desc "compile coffee-scripts from ./src to ./public/javascripts"
  task :compile do
    source = "#{File.dirname(__FILE__)}/src/"
    javascripts = "#{File.dirname(__FILE__)}/public/javascripts/"
    
    Dir.foreach(source) do |cf|
      unless cf == '.' || cf == '..' 
        # debugger
        js = CoffeeScript.compile File.read("#{source}#{cf}") 
        open "#{javascripts}#{cf.gsub('.coffee', '.js')}", 'w' do |f|
          f.puts js
        end 
      end 
    end
  end
end

desc "Create a deployment bundle"
task :dist => ["js:compile", :package]

desc "Run the server"
task :default => "js:compile" do
  ruby "query_notifier.rb"
end
# vim:set et sw=2 ts=8:
