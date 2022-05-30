require_relative 'rssManager.rb'
require_relative 'rssData.rb'

class Application
    
    def Execute 

        rssUrl = "https://news.google.com/rss"

        rssManager = RssManager.new

        rssChannel = rssManager.LoadRssChannelFromUrl(rssUrl)

        puts rssManager.Title
        puts rssManager.Description
        puts rssManager.Link
        puts rssManager.PubDate

        for index in 0..rssChannel.RssItems.length-1 do
            puts rssChannel.RssItems[index].Title
            puts rssChannel.RssItems[index].Description[0..25]
            puts rssChannel.RssItems[index].Link
            puts rssChannel.RssItems[index].Guid
            puts rssChannel.RssItems[index].PubDate

        end
    end
end

application = Application.new
application.Execute