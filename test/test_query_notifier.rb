require 'rubygems'
require 'bundler/setup'

require 'test/unit'
require 'rack/test'

require 'query_notifier.rb'

ENV['RACK_ENV'] = 'test'

class QueryNotifierTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index_html
    get '/'
    assert_match /<html>/, last_response.body
  end
end
# vim:set et sw=2 ts=8:
