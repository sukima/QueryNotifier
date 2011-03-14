require 'dm-core'
require 'dm-migrations'

db_file = ENV['RACK_ENV']
db_file ||= 'query_notifier'
DataMapper.setup(:default, "sqlite3:db/#{db_file}.db")

# vim:set et sw=2 ts=8 fdm=marker:
