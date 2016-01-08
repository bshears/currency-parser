#!/usr/bin/python

import sys
from bs4 import BeautifulSoup
from six.moves import urllib

class CurrencyParser:
   
   def __init__(self, currency):
      self.currency = currency
      self.page = urllib.request.urlopen('http://kantor.aliorbank.pl/forex')
      self.soup = BeautifulSoup(self.page, "lxml")
      self.sellList = self.soup.body.findAll('td', attrs={'class':'ere-sale'})
      self.buyList = self.soup.body.findAll('td', attrs={'class':'ere-purchase'})

   def getCurrencyFromList(self, searchList):
      for x in searchList:
         curr = x.find('span', attrs={'data-currency':self.currency})
         if curr is not None:
            return curr.text

   def getPrice(self, sourceList):
      value = self.getCurrencyFromList(sourceList)
      if value is None:
         raise "Invalid currency value!"
      return value

   def displaySell(self):
      print "SELL\t1 " + self.currency + " = " + self.getPrice(self.sellList) + " PLN"

   def displayBuy(self):
      print "BUY\t1 " + self.currency + " = " + self.getPrice(self.buyList) + " PLN"


if len(sys.argv) == 2:
   currencyArgument = sys.argv[1]
else:
   print "You must pass an argument for currency ie. \"GBP\"" 
   exit()

if len(currencyArgument) != 3:
   print "Currency code should contain only 3 characters ie. \"GBP\""
   exit()

parser = CurrencyParser(currencyArgument)
parser.displaySell()
parser.displayBuy()
