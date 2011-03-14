require 'rubygems'
require 'bundler/setup'

ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'rack/test'

require 'query_notifier.rb'

class QueryNotifierTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def teardown
    Notification.destroy
  end

  def test_index_html_returns_valid_html
    get '/'
    status_ok
    assert_match /<html>/, last_response.body
  end

  def test_create_notification
    note = get_test_attributes
    old_count = Notification.count
    post '/notification', note
    status_ok
    assert_equal (old_count+1), Notification.count
      "should increase the count by 1"
  end

  def test_get_notifications_returns_json
    create_test_notification
    @json = nil
    get '/notifications'
    status_ok
    assert_match 'application/json', last_response.headers['Content-Type']
    assert_nothing_raised do
      @json = JSON.parse(last_response.body)
    end
    assert !@json.nil?, "Parser should not return nil."
    assert (@json.count > 0), "Json should have items in the array."
    assert_match /test_title/, @json[0]['title'], "title should match."
    assert_match /Lorem/, @json[0]['text'], "text should match."
    assert_match /test_client_identifier/, @json[0]['client'], "client should match."
  end

  def test_get_notifications_updates_unread
    create_test_notification
    id = @note.id
    assert @note.unread
    get '/notifications'
    status_ok
    @note = Notification.get(id)
    assert !@note.unread
  end

  def test_flush_should_clean_up_old_records
    old_count = Notification.count
    create_test_notification
    @note.unread = false
    assert @note.save
    get '/notifications/flush'
    status_ok
    assert_equal old_count, Notification.count, "old_count should match new count."
  end

  private
  def create_test_notification
    @note = get_test_notification
    assert @note.save
  end

  def get_test_notification
    Notification.new(get_test_attributes)
  end

  def get_test_attributes
    @sequence_count ||= 0
    @sequence_count += 1
    return {
      :title => "test_title_#{@sequence_count}",
      :text => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      :client => "test_client_identifier"
    }
  end

  def status_ok
    assert_equal 200, last_response.status, "should return 200 status code."
  end

  def status_bad
    assert_equal 400, last_response.status, "should return 400 status code."
  end
end
# vim:set et sw=2 ts=8:
