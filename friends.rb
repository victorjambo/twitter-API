#!/usr/bin/ruby

#-----------------------------------------------------------------------
# twitter-friends
#  - lists all of a given user's friends (ie, followers)
#-----------------------------------------------------------------------

require 'twitter'
require 'awesome_print'

#-----------------------------------------------------------------------
# create twitter API object
#-----------------------------------------------------------------------
client = Twitter::REST::Client.new do |config|
	config.consumer_key = ENV['consumer_key']
	config.consumer_secret = ENV['consumer_secret']
	config.access_token = ENV['access_token']
	config.access_token_secret = ENV['access_token_secret']
end

#-----------------------------------------------------------------------
# this is the user whose friends we will list
#-----------------------------------------------------------------------
username = "vjambaz"

#-----------------------------------------------------------------------
# perform a basic search 
# twitter API docs: https://dev.twitter.com/rest/reference/get/friends/ids
#-----------------------------------------------------------------------
query = client.friend_ids(screen_name = username)

#-----------------------------------------------------------------------
# tell the user how many friends we've found.
# note that the twitter API will NOT immediately give us any more 
# information about friends except their numeric IDs...
#-----------------------------------------------------------------------
ap "found #{query.count} friends"

#-----------------------------------------------------------------------
# now we loop through them to pull out more info, in blocks of 100.
#-----------------------------------------------------------------------