require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'fileutils'

FileUtils.mkdir_p 'downloads/'
xml = Nokogiri::XML(open('http://s.ch9.ms/Shows/Azure-Friday/feed/mp4high'))
item = xml.xpath('//item')

item.each do |s|
  source      = s.at('enclosure')['url'].to_s
  name        = source.split('/').last
  local_file  = "downloads/#{name}"
  next if File.exist? local_file
  File.open(local_file, "wb") do |file|
    puts " downloading " + name
    file.write open(source).read
  end
end
