#!/usr/bin/env ruby
require 'rubygems'
require 'tweetstream'
require 'json'

# Read the Twitter api credentials from twitter_credentials.json
credentials = JSON.parse(File.read('credentials.json'))

if credentials["consumer_key"] == "FILL_IN"
  puts 'Please fill in credentials from dev.twitter.com in credentials.json'
  puts 'Read README.md for more info'
  exit -1
end

TweetStream.configure do |config|
  config.consumer_key       = credentials["consumer_key"]
  config.consumer_secret    = credentials["consumer_secret"]
  config.oauth_token        = credentials["oauth_token"]
  config.oauth_token_secret = credentials["oauth_token_secret"]
  config.auth_method        = :oauth
end

log = Logger.new( 'data/geo-data.tsv', shift_age = 'daily')

log.formatter = proc do |severity, datetime, progname, msg|
  "#{msg}\n"
end

TweetStream::Client.new.locations(-180.0,-90.0,180.0,90.0) do |status|
  if(status.geo)
    id = status.id
    lat = format("%.4f", status.geo.coordinates[0])
    lng = format("%.4f", status.geo.coordinates[1])
    created_at = status.created_at.to_i
    lang = status.lang
    country = status.place != nil ? status.place.country_code : "XX"

    log.info "#{created_at}\t#{id}\t#{lang}\t#{country}\t#{lat}\t#{lng}"
  end
end