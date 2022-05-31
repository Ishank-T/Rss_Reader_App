require_relative 'rssManager.rb'
require_relative 'rssData.rb'

# Storing example feeds into an array
DEFAULT_FEEDS = ['https://feeds.simplecast.com/54nAGcIl',
                 'https://news.yahoo.com/rss',
                 'https://rss.art19.com/apology-line']

def Execute 

    puts 'Welcome to the Rss Reader App'
    puts 'Enter a feed URL or type "list" to see the default feeds'
    # taking input and calling the function for parsing feed
    input = gets.chomp
    feed_selection(input)
end

def Execute2
    puts 'Enter another feed URL or enter a number to view a default feed'
    DEFAULT_FEEDS.each_with_index do |feed,index|
        puts "#{index+1} #{feed}"
    end
    puts "Type 'end' to exit."
    input = gets.chomp
    feed_selection(input)
end

# Function to read the given input
def feed_selection(input)
        # Given input is a number
        if input.to_i.to_s==input and input.to_i>=0 and input.to_i<DEFAULT_FEEDS.length
            select_feed_from_input(DEFAULT_FEEDS[input.to_i-1])
            Execute2()
        elsif input=='list'
            feed_list
        elsif input == 'end'
            puts "ThankYou\n\n"
        elsif input.start_with?('http')
            select_feed_from_input(input)
            Execute2()
        else
            puts "Please Enter a valid input\n\n"
            list_input
        end
end        

def feed_list
    puts 'Enter the feed number to view articles'
    # Displays the default feed with index
    DEFAULT_FEEDS.each_with_index do |feed,index|
        puts "#{index+1} #{feed}"
        
    end
    puts 'Type "end" to exit.'
    list_input
end

def list_input
    puts 'Enter a feed URL or enter a number to view a default feed(type "list" to see default feeds).'
    input = gets.chomp
    feed_selection(input)
end

def select_feed_from_input(rssUrl)
    # Creating a new object named RssManager
    rssManager = RssManager.new

    # Load RSS feed from url to RssChannel data model
    rssChannel = rssManager.LoadRssChannelFromUrl(rssUrl)

    # Prints Channel Info
    puts rssChannel.Title
    puts rssChannel.Description
    puts rssChannel.Link
    puts rssChannel.PubDate

    # Print RssItems from an RssChannel
    for index in 0..rssChannel.RssItems.length-1 do
        puts rssChannel.RssItems[index].Title
        puts rssChannel.RssItems[index].Description
        puts rssChannel.RssItems[index].Link
        puts rssChannel.RssItems[index].Guid
        puts rssChannel.RssItems[index].PubDate

    end
end

# Run the file
Execute()