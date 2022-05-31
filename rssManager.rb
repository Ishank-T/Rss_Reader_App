require 'open-uri'
require 'nokogiri'
require_relative 'rssData.rb'

class RssManager 
    
    def LoadRssChannelFromUrl(rssUrl)

        #read rss from url using nokogiri library
        xmlDoc = Nokogiri::XML(URI.open(rssUrl))

        # Set rssChannel Node
        rssChannelNode = xmlDoc.root.at_xpath("channel")

        # Create new RssChannel
        rssChannel =  RssChannel.new
        rssChannel.Title = xmlDoc.root.at_xpath("channel/title").content
        if rssChannelNode.at_xpath("description")
            rssChannel.Description = rssChannelNode.at_xpath("description").content
        end
        if rssChannelNode.at_xpath("link")
            rssChannel.Link = rssChannelNode.at_xpath("link").content
        end
        if rssChannelNode.at_xpath("pubDate")
            rssChannel.PubDate = rssChannelNode.at_xpath("pubDate").content
        end
        rssChannel.RssItems = LoadRssItemsFromUrl(rssUrl)

        return rssChannel
    end

    def LoadRssItemsFromUrl(rssUrl)

        xmlDoc = Nokogiri::XML(URI.open(rssUrl))

        rssItemNodes = xmlDoc.root.xpath("channel/item")

        # Making an arrray to  store rssItems temporarily
        rssItems =[]

        for index in 0..rssItemNodes.length-1 do

            # Create new RssItem
            rssItem=RssItem.new
            rssItem.Title = rssItemNodes[index].at_xpath("title").content
            if rssItemNodes[index].at_xpath("description")
                rssItem.Description = rssItemNodes[index].at_xpath("description").content
            end
            if rssItemNodes[index].at_xpath("link")
                rssItem.Link = rssItemNodes[index].at_xpath("link").content
            end
            if rssItemNodes[index].at_xpath("guid")
                rssItem.Guid = rssItemNodes[index].at_xpath("guid").content
            end
            if rssItemNodes[index].at_xpath("pubDate")
                rssItem.PubDate = rssItemNodes[index].at_xpath("pubDate").content
            end
            # Adding RssItem into an array
            rssItems.push(rssItem)

        end

        return rssItems
    end

end

