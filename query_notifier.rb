require 'rubygems'
require 'bundler/setup'

require 'sinatra'

require 'db_init'
require 'models/notification'

DataMapper.auto_migrate!

# Action: Root {{{1
get '/' do
  File.read(File.join('public', 'index.html'))
end

# Action: Create {{{1
post '/notification' do
  note = Notification.new(params)
  note.unread = true
  if (note.save)
    [200, "Notification successfully created."]
  else
    [400, "Unable to process and save notification. #{note.to_s}"]
  end
end

# Action: Index {{{1
get '/notifications' do
  notes = Notification.all(:unread => true)
  json_objs = []
  notes.each do |n|
    json_objs << n
    n.update(:unread => false)
  end

  [200, {'Content-Type' => 'application/json'}, json_objs.to_json]
end

# Action: Flush {{{1
get '/notifications/flush' do
  Notification.clean
  [200, "Old notifications flushed."]
end

# vim:set et sw=2 ts=8 fdm=marker:
