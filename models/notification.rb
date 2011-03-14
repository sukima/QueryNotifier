require 'json'
require 'dm-timestamps'

class Notification
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :text, String
  property :client, String
  property :unread, Boolean, :default => true
  property :created_at, DateTime

  def to_s
    ret = "#{id}: "
    ret << "#{title} " if !title.empty?
    ret << "from #{client} " if !client.empty?
    ret << "'#{text}'"
    ret
  end

  def to_json(*a)
    attributes.to_json(*a)
  end

  def self.clean
    old_notes = all(:unread => false)
    old_notes.destroy
  end
end
# vim:set et sw=2 ts=8 fdm=marker:
