module Spree::BaseHelper
  
  # helper_method didn't work in Spree::BaseController
  
  def current_country
    Country.current_country
  end
  
  def in_vat_zone?(country = nil)
    Country.current_country.in_vat_zone?(country)
  end
  
end