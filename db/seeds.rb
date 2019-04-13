# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "nokogiri"
require 'awesome_print'

def scrape_investing(url, assets, asset_type)
  doc = Nokogiri::HTML(open(url).read)

  puts "Stocks indices"

  assets.each do |asset|
    asset = Asset.new(asset_name: asset["name"])
    puts doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-last").text.to_f
    puts doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-pcp").text.to_f
    asset.save
  end
end

ref_equity = [{ "name" => 'CAC 40', "investing_id" => 167 },
          { "name" => 'Eurostoxx 50', "investing_id" => 175 },
          { "name" => 'S&P500', "investing_id" => 166 },
          { "name" => 'Nasdaq', "investing_id" => 14958 },
          { "name" => 'VIX', "investing_id" => 44336 },
          { "name" => 'Ibovespa', "investing_id" => 17920 },
          { "name" => 'DAX', "investing_id" => 172 },
          { "name" => 'FTSE 100', "investing_id" => 27 },
          { "name" => 'Nikkei 225', "investing_id" => 178 },
          { "name" => 'Hang Seng', "investing_id" => 179 }
        ]

scrape_investing("https://fr.investing.com/indices/major-indices", ref_equity, "Equity")



ref_forex = [{ "name" => 'EUR/USD', "investing_id" => 1 },
          { "name" => 'USD/BRL', "investing_id" => 2103 },
          { "name" => 'USD/JPY', "investing_id" => 3 },
          { "name" => 'GBP/USD', "investing_id" => 2 },
          { "name" => 'USD/CHF', "investing_id" => 4 }
        ]

scrape_investing("https://fr.investing.com/currencies/single-currency-crosses", ref_forex, "Equity")


ref_sovereign_10Y = [{ "name" => 'Germany', "investing_id" => 23693 },
          { "name" => 'USA', "investing_id" => 23705 },
          { "name" => 'Brazil', "investing_id" => 24029 },
          { "name" => 'France', "investing_id" => 23778 },
          { "name" => 'Italy', "investing_id" => 23738 },
          { "name" => 'UK', "investing_id" => 23673 },
          { "name" => 'Spain', "investing_id" => 23806 }
        ]

scrape_investing("https://fr.investing.com/rates-bonds/world-government-bonds", ref_sovereign_10Y, "Equity")


ref_commodities = [{ "name" => 'Gold', "investing_id" => 23693 },
          { "name" => 'Silver', "investing_id" => 23705 },
          { "name" => 'WTI', "investing_id" => 24029 },
          { "name" => 'Brent', "investing_id" => 23778 }
        ]

scrape_investing("https://fr.investing.com/commodities/real-time-futures", ref_commodities, "Equity")



ref_crypto = [{ "name" => 'BTC/USD', "investing_id" => 1073245 },
          { "name" => 'ETH/USD', "investing_id" => 1031703 },
          { "name" => 'XRP/USD', "investing_id" => 1057990 },
          { "name" => 'BCH/USD', "investing_id" => 1058255 },
          { "name" => 'LTC/USD', "investing_id" => 1031704 }
        ]

scrape_investing("https://fr.investing.com/crypto/currency-pairs", ref_commodities, "Equity")



