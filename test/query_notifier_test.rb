require '../query_notifier.rb'
require 'test/unit'
require 'rack/test'

class QueryNotifierTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

end
# vim:set et sw=2 ts=8:
