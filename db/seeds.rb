# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "nokogiri"

def scrape_investing(url, assets, asset_type)
  this_asset_type = AssetType.create(name: asset_type)
  puts "Filling #{this_asset_type.name}"
  doc = Nokogiri::HTML(open(url).read)

  assets.each do |asset|
    new_asset = Asset.new(asset_name: asset["name"])
    case this_asset_type.name
      when "Equity"
        new_asset.last_price = doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-last").text
        new_asset.daily_variation = doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-pcp").text
      when "Sovereign 10Y"
        new_asset.last_price = doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-last").text + "%"
        new_asset.daily_variation = doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-pcp").text
      when "Forex"
        new_asset.last_price = doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-bid").text
        new_asset.daily_variation = doc.search("#pair_#{asset["investing_id"]} .pid-#{asset["investing_id"]}-pcp").text
      when "Commodities"
        new_asset.last_price = doc.search("#sb_last_#{asset["investing_id"]}").text
        new_asset.daily_variation = doc.search("#sb_changepc_#{asset["investing_id"]}").text
      when "Crypto Currencies"
        new_asset.last_price = doc.search(".pid-#{asset["investing_id"]}-last").text
        new_asset.daily_variation = doc.search(".pid-#{asset["investing_id"]}-pcp").text
    end
    new_asset.asset_type_id = this_asset_type.id
    new_asset.save
  end
end


ref_equity = [{ "name" => 'CAC 40', "investing_id" => 167 },
          { "name" => 'Eurostoxx 50', "investing_id" => 175 },
          { "name" => 'S&P500', "investing_id" => 166 },
          { "name" => 'Nasdaq', "investing_id" => 14958 },
          { "name" => 'VIX', "investing_id" => 44336 },
          { "name" => 'FTSE 100', "investing_id" => 27 },
          { "name" => 'DAX', "investing_id" => 172 },
          { "name" => 'Ibovespa', "investing_id" => 17920 },
          { "name" => 'Nikkei 225', "investing_id" => 178 },
          { "name" => 'Hang Seng', "investing_id" => 179 }
        ]

ref_forex = [{ "name" => 'EUR/USD', "investing_id" => 1 },
          { "name" => 'USD/JPY', "investing_id" => 3 },
          { "name" => 'USD/GBP', "investing_id" => 2126 },
          { "name" => 'USD/CAD', "investing_id" => 7 },
          { "name" => 'USD/AUD', "investing_id" => 2091 },
          { "name" => 'USD/CHF', "investing_id" => 4 },
          { "name" => 'USD/TRY', "investing_id" => 18 },
          { "name" => 'USD/MXN', "investing_id" => 39 },
          { "name" => 'USD/BRL', "investing_id" => 2103 },
          { "name" => 'USD/CNY', "investing_id" => 2111 },
        ]

ref_sovereign_10Y = [{ "name" => 'Germany', "investing_id" => 23693 },
          { "name" => 'USA', "investing_id" => 23705 },
          { "name" => 'France', "investing_id" => 23778 },
          { "name" => 'UK', "investing_id" => 23673 },
          { "name" => 'Italy', "investing_id" => 23738 },
          { "name" => 'Spain', "investing_id" => 23806 },
          { "name" => 'Portugal', "investing_id" => 23792 },
          { "name" => 'Greece', "investing_id" => 23983 },
          { "name" => 'Brazil', "investing_id" => 24029 },
          { "name" => 'Turkey', "investing_id" => 24037 },
        ]

ref_commodities = [{ "name" => 'Gold', "investing_id" => 8830 },
          { "name" => 'Silver', "investing_id" => 8836 },
          { "name" => 'Copper', "investing_id" => 8831 },
          { "name" => 'WTI', "investing_id" => 8849 },
          { "name" => 'Brent', "investing_id" => 8833 }
        ]

ref_crypto = [{ "name" => 'BTC/USD', "investing_id" => 1073245 },
          { "name" => 'ETH/USD', "investing_id" => 1031703 },
          { "name" => 'XRP/USD', "investing_id" => 1057990 },
          { "name" => 'BCH/USD', "investing_id" => 1058255 },
          { "name" => 'LTC/USD', "investing_id" => 1031704 }
        ]



Asset.delete_all
AssetType.delete_all

scrape_investing("https://fr.investing.com/indices/major-indices", ref_equity, "Equity")
scrape_investing("https://fr.investing.com/rates-bonds/world-government-bonds", ref_sovereign_10Y, "Sovereign 10Y")
scrape_investing("https://fr.investing.com/currencies/single-currency-crosses", ref_forex, "Forex")
scrape_investing("https://fr.investing.com/commodities/real-time-futures", ref_commodities, "Commodities")
scrape_investing("https://fr.investing.com/crypto/currency-pairs", ref_crypto, "Crypto Currencies")


