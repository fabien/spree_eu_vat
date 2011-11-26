Country.class_eval do

  def self.current_country
    Thread.current[:current_country] || Country.find(Spree::Config[:default_country_id])
  end
  
  def in_vat_zone?(country = nil)
    Zone.country_in_zone?(country || Country.current_country, 'EU_VAT')
  end

end