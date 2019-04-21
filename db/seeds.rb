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
    new_asset = Asset.new(asset_name: asset["name"], flag: asset["flag"])
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


ref_equity = [{ "name" => 'CAC 40', "investing_id" => 167, "flag" => "https://www.countryflags.io/fr/shiny/16.png" },
          { "name" => 'Eurostoxx 50', "investing_id" => 175, "flag" => "https://www.countryflags.io/eu/shiny/16.png" },
          { "name" => 'S&P500', "investing_id" => 166, "flag" => "https://www.countryflags.io/us/shiny/16.png"},
          { "name" => 'Nasdaq', "investing_id" => 14958, "flag" => "https://www.countryflags.io/us/shiny/16.png"},
          { "name" => 'VIX', "investing_id" => 44336, "flag" => "https://www.countryflags.io/us/shiny/16.png"},
          { "name" => 'FTSE 100', "investing_id" => 27 ,"flag" => "https://www.countryflags.io/gb/shiny/16.png"},
          { "name" => 'DAX', "investing_id" => 172, "flag" => "https://www.countryflags.io/de/shiny/16.png"},
          { "name" => 'Ibovespa', "investing_id" => 17920, "flag" => "https://www.countryflags.io/br/shiny/16.png"},
          { "name" => 'Nikkei 225', "investing_id" => 178, "flag" => "https://www.countryflags.io/jp/shiny/16.png"},
          { "name" => 'Hang Seng', "investing_id" => 179, "flag" => "https://www.countryflags.io/cn/shiny/16.png"}
        ]

ref_forex = [{ "name" => 'EUR/USD', "investing_id" => 1, "flag" => "" },
          { "name" => 'USD/JPY', "investing_id" => 3, "flag" => "" },
          { "name" => 'USD/GBP', "investing_id" => 2126, "flag" => "" },
          { "name" => 'USD/CAD', "investing_id" => 7, "flag" => "" },
          { "name" => 'USD/AUD', "investing_id" => 2091, "flag" => "" },
          { "name" => 'USD/CHF', "investing_id" => 4, "flag" => "" },
          { "name" => 'USD/TRY', "investing_id" => 18, "flag" => "" },
          { "name" => 'USD/MXN', "investing_id" => 39, "flag" => "" },
          { "name" => 'USD/BRL', "investing_id" => 2103, "flag" => ""},
          { "name" => 'USD/CNY', "investing_id" => 2111, "flag" => "" },
        ]

ref_sovereign_10Y = [{ "name" => 'Germany', "investing_id" => 23693, "flag" => "https://www.countryflags.io/de/shiny/16.png" },
          { "name" => 'USA', "investing_id" => 23705, "flag" => "https://www.countryflags.io/us/shiny/16.png" },
          { "name" => 'France', "investing_id" => 23778, "flag" => "https://www.countryflags.io/fr/shiny/16.png" },
          { "name" => 'UK', "investing_id" => 23673, "flag" => "https://www.countryflags.io/gb/shiny/16.png" },
          { "name" => 'Italy', "investing_id" => 23738, "flag" => "https://www.countryflags.io/it/shiny/16.png" },
          { "name" => 'Spain', "investing_id" => 23806, "flag" => "https://www.countryflags.io/es/shiny/16.png" },
          { "name" => 'Portugal', "investing_id" => 23792, "flag" => "https://www.countryflags.io/pt/shiny/16.png" },
          { "name" => 'Greece', "investing_id" => 23983, "flag" => "https://www.countryflags.io/gr/shiny/16.png" },
          { "name" => 'Brazil', "investing_id" => 24029, "flag" => "https://www.countryflags.io/br/shiny/16.png" },
          { "name" => 'Turkey', "investing_id" => 24037, "flag" => "https://www.countryflags.io/tr/shiny/16.png" },
        ]

ref_commodities = [{ "name" => 'Gold', "investing_id" => 8830, "flag" => "" },
          { "name" => 'Silver', "investing_id" => 8836, "flag" => "" },
          { "name" => 'Copper', "investing_id" => 8831, "flag" => "" },
          { "name" => 'WTI', "investing_id" => 8849, "flag" => "" },
          { "name" => 'Brent', "investing_id" => 8833 , "flag" => ""}
        ]

ref_crypto = [{ "name" => 'BTC/USD', "investing_id" => 1073245, "flag" => "" },
          { "name" => 'ETH/USD', "investing_id" => 1031703, "flag" => "" },
          { "name" => 'XRP/USD', "investing_id" => 1057990, "flag" => "" },
          { "name" => 'BCH/USD', "investing_id" => 1058255, "flag" => "" },
          { "name" => 'LTC/USD', "investing_id" => 1031704, "flag" => "" }
        ]



Asset.delete_all
AssetType.delete_all

scrape_investing("https://fr.investing.com/indices/major-indices", ref_equity, "Equity")
scrape_investing("https://fr.investing.com/rates-bonds/world-government-bonds", ref_sovereign_10Y, "Sovereign 10Y")
scrape_investing("https://fr.investing.com/currencies/single-currency-crosses", ref_forex, "Forex")
scrape_investing("https://fr.investing.com/commodities/real-time-futures", ref_commodities, "Commodities")
scrape_investing("https://fr.investing.com/crypto/currency-pairs", ref_crypto, "Crypto Currencies")


