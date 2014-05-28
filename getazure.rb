require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'fileutils'

FileUtils.mkdir_p 'downloads/'
FileUtils.cd 'downloads/'
xml = Nokogiri::XML(open('http://s.ch9.ms/Shows/Azure-Friday/feed/mp4high'))
item = xml.xpath('//item')

item.each do |s|
  source = s.at('enclosure')['url'].to_s
  name   = source.split('/').last
  next if File.exist? name
  File.open(name, "wb") do |file|
    puts " downloading " + name
    file.write open(source).read
  end
end
