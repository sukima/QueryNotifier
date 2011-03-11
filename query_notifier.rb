require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'dm-core'
require 'dm-migrations'

# Database {{{1
db_file = ENV['RACK_ENV']
db_file ||= 'query_notifier'
DataMapper.setup(:default, "sqlite3:db/#{db_file}.db")

# Models {{{1
class Notification
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :title, String
  property :text, String
end

DataMapper.auto_migrate!

# Actions {{{1
get '/' do
  File.read(File.join('public', 'index.html'))
end
# vim:set et sw=2 ts=8 fdm=marker:
