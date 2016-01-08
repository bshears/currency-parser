#!/home/mariusz/.rbenv/shims/ruby

require 'rubygems'
require 'nokogiri'
require 'restclient'

class CurrencyParser
   def initialize(currency)
      @page=Nokogiri::HTML(RestClient.get("http://kantor.aliorbank.pl/forex"))
      @currency=currency
      @sell_list=@page.css('td.ere-sale')
      @buy_list=@page.css('td.ere-purchase')
   end

   def display_sell()
      puts "SELL\t1 " + @currency + " = " + get_price(@sell_list) + " PLN"
   end

   def get_price(list)
      return list.css('span.__currency-rate').css('span[data-currency=' + @currency + ']').text
   end

   def display_buy()
      puts "BUY\t1 " + @currency + " = " + get_price(@buy_list) + " PLN"
   end
   
end

if ARGV.empty?
   puts "You must pass an argument for currency ie. \"GBP\""
   exit
else 
   CURRENCY = ARGV[0]
end

if ARGV[0].length != 3
   puts "Currency code should contain only 3 characters ie. \"GBP\""
   exit
end

parser=CurrencyParser.new(CURRENCY)
parser.display_sell()
parser.display_buy()
