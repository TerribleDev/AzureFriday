require 'rubygems'
require 'open-uri'
require 'Nokogiri'
require 'FileUtils'

FileUtils.mkdir_p 'downloads/'
FileUtils.cd 'downloads/'
xml = Nokogiri::XML(open('http://s.ch9.ms/Shows/Azure-Friday/feed/mp4high'))
item = xml.xpath('//item')

item.each do |s|

File.open("#{s.at('enclosure')['url'].to_s.split('/').last}", "wb") do |file|
			puts " downloading " + s.at('enclosure')['url'].to_s.split('/').last
				file.write open("#{s.at('enclosure')['url']}").read
			end
end