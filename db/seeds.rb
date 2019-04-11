# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "nokogiri"


def scrape_investing(url)
  doc = Nokogiri::HTML(open(url).read)
  # p idx = doc.search(".c-list-trading__item--name")
  # puts "Price"
  # doc.search(".c-instrument--last").each do |price|
  #   p price.text
  # end
  # puts "Variation"
  # p var = doc.search(".c-instrument--variation").class
  asset = Asset.new(asset_name: "CAC 40")
  asset.last_price = doc.search("#pair_167 .pid-167-last").text.to_f
  asset.daily_variation = doc.search("#pair_167 .pid-167-pcp").text.to_f
  asset.save

end

scrape_investing("https://fr.investing.com/indices/major-indices")



