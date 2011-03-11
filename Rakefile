require 'coffee-script'
require 'rake/packagetask'
require 'rake/clean'

Rake::PackageTask.new("QueryNotifier", "0.1.0") do |p|
  p.need_tar_gz = true
  p.package_files = `git ls-files`.split(/\n/)
  p.package_files << "public/javascripts/*.js"
end

CLEAN.include("public/javascripts/*.js")

namespace :js do
  desc "compile coffee-scripts from ./src to ./public/javascripts"
  task :compile do
    source = "#{File.dirname(__FILE__)}/src/"
    javascripts = "#{File.dirname(__FILE__)}/public/javascripts/"
    
    Dir.foreach(source) do |cf|
      unless cf == '.' || cf == '..' 
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
# vim:set et sw=2 ts=8:
