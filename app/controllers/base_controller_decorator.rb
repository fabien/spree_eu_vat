Spree::BaseController.class_eval do

  prepend_before_filter :detect_current_country
  
  def current_country
    Country.current_country
  end
  
  def in_vat_zone?(country = nil)
    Country.current_country.in_vat_zone?(country)
  end
  
  private
  
  def detect_current_country
    Thread.current[:current_country] ||= nil # to override
  end

end