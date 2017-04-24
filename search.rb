require 'twitter'
require 'awesome_print'

client = Twitter::REST::Client.new do |config|
	config.consumer_key = ENV['consumer_key']
	config.consumer_secret = ENV['consumer_secret']
	config.access_token = ENV['access_token']
	config.access_token_secret = ENV['access_token_secret']
end

#search query for user in quotes
result = client.user_search('vjambaz')

#loop through search result and displays user info
for user in result
	ap [user.screen_name, user.id]
end