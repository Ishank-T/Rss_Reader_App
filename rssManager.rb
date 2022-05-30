require 'open-uri'
require 'nokogiri'
require_relative 'rssData.rb'

class RssManager 
    
    def LoadRssChannelFromUrl(rssUrl)

        xmlDoc = Nokogiri::XML(URI.open(rssUrl))

        rssChannelNode = xmlDoc.root.at_xpath("channel")

        rssChannel =  RssChannel.new
        rssChannel.Title = xmlDoc.root.at_xpath("channel/title").content
        if rssChannelNode.at_xpath("description")
            rssChannel.Description = rssChannelNode.at_xpath("description").content
        end
        if rssChannelNode.at_xpath("link")
            rssChannel.Link = rssChannelNode.at_xpath("link").content
        end
        if rssChannel.at_xpath("pubDate")
            rssChannel.PubDate = rssChannel.at_xpath("pubDate").content
        end
        rssChannel.RssItems = LoadRssItemsFromUrl(rssUrl)

        return rssChannel
    end

    def LoadRssItemsFromUrl(rssUrl)

        xmlDoc = Nokogiri::XML(URI.open(rssUrl))

        rssItemNodes = xmlDoc.root.at_xpath("channel/item")

        rssItems =[]

        for index in 0..rssItemNodes.length-1 do

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
            rssItems.push(rssItem)

        end

        return rssItems
    end

end

