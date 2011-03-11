require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'

get '/' do
  File.read(File.join('public', 'index.html'))
end
# vim:set et sw=2 ts=8:
