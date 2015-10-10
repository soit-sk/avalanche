require 'rubygems'
require 'scraperwiki'
require 'open-uri'
require 'nokogiri'

html = open('http://www.hzs.sk/horska-zachranna-sluzba/statistika/')
doc = Nokogiri::HTML(html)
table = doc.xpath('//table[@id="table"]')
i = 0

table.xpath('.//td').each_slice(9) do |row|
  next if row[7].text.to_s == 'Sneh'

  data = {
    "unique_id" => i,
    "date" => row[0].text.to_s,
    "place" => row[1].text.to_s,
    "orientation" => row[2].text.to_s,
    "landing" => row[3].text.to_s,
    "hardness" => row[4].text.to_s,
    "head" => row[5].text.to_s,
    "postihnuti" => row[6].text.to_s,
    "snow" => row[7].text.to_s,
    "odtrh" => row[8].text.to_s
  }

  ScraperWiki.save(["unique_id"], data)

  i += 1
end
