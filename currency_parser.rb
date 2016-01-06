#!/home/mariusz/.rbenv/shims/ruby

require 'rubygems'
require 'nokogiri'
require 'restclient'

class CurrencyParser
@@page   
   def initialize(currency)
      @@page=Nokogiri::HTML(RestClient.get("http://kantor.aliorbank.pl/forex"))
      @currency=currency
   end

   def display_sell()
      puts '1 ' + @currency + ' =  ' + @@page.css('td.ere-sale').css('span.__currency-rate').css('span[data-currency=' + @currency +']').text + ' PLN'
   end
   def display_buy()
      puts '1 ' + @currency + ' =  ' + @@page.css('td.ere-purchase').css('span.__currency-rate').css('span[data-currency=' + @currency +']').text + ' PLN'
   end
end

if ARGV.empty?
   puts "You must pass an argument for currency ie. \"GBP\""
   exit
else 
   CURRENCY = ARGV[0]
end

parser=CurrencyParser.new(CURRENCY)
parser.display_sell()
parser.display_buy()
