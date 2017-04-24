#bot built by nairuby
#https://github.com/nairuby/retweet-bot

require "rubygems"
require "twitter"
require "awesome_print"

class RetweetBot
	#Twitter configuration
	$client = Twitter::REST::Client.new do |config|
  		config.consumer_key        = "B146Cgd97uDep0fC9fSc08jUk"
  		config.consumer_secret     = "JizLEAV3hQFcr6SIkdonlSrcAMxH5f273C40Vasf8gToKYQ3XO"
  		config.access_token        = "399282363-ecgtNpg3YAn45n0wAqXblLMxNeUa8Dw99Hxx5ZAg"
  		config.access_token_secret = "z5pGJK1YtRJWypvXho1QcjH755hD3iFSaKIoXa3g156PC"
	end

	def show_trends
		$client.trends
	end

	def followers
		$client.follower_ids
	end

	def nairuby
		#Retweet tweets with this topic
		topic = "Future tweet"

		#Get all my followers
		my_followers = $client.follower_ids
		
		#Iterate over all my followers
		my_followers.each do |follower_id|
			#Check the timeline for my follower
			$client.user_timeline(follower_id, result_type: "recent").each do |tweet|
				#If a tweet includes topic - retweet it
				if tweet.text.include? topic
					$client.retweet(tweet.id)
				end
			end
		end
	end

	def search
		#search query for user in quotes
		result = $client.user_search('vjambaz')
		#loop through search result and displays user info
		for user in result
			return user.screen_name, user.id
		end
	end

	def my_retweets
		# last since_id from "since_id.txt" file
		limited_id = File.open("since_id.txt").read

		# access to Twitter API
		results = $client.retweets_of_me(since_id: 5)

		if results.length > 0
			# update sinec_id file
		  	f = File.open("since_id.txt", "w")
		  	f.puts results[0].id
		  	f.close

		  	results.each do |tweet|
			    rt = tweet.retweet_count
			    fav = tweet.favorite_count
			    text = tweet.text[0..40]
			    
			    if tweet.text.length > 41
			      text += "..."
			    end
			    
			    status_url = "https://twitter.com/" + tweet.user.screen_name + "/status/" + tweet.id.to_s

			    # Fav only
			    if rt == 0
			      status = fav.to_s + "Fav - " + "Response to My Tweet: " + text + " " + status_url
			    # RT only
			    elsif fav == 0
			      status =  rt.to_s + "RT - " + "Response to My Tweet: " + text + " " + status_url
			    # both
			    else
			      status = rt.to_s + "RT, " + fav.to_s + "Fav - " + "Response to My Tweet: " +  text + " " + status_url
		    	end
		    	$client.update(status, in_reply_to_status_id: tweet.id)
		    end
		end
	end
end

#Initilize my retweet bot
my_retweet_bot = RetweetBot.new
ap my_retweet_bot.search