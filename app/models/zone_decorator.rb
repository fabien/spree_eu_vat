Zone.class_eval do

  def self.country_in_zone?(country, zone_name)
    !!countries_for_zone(zone_name).find { |c| c == country }
  end

  def self.countries_for_zone(zone_name)
    Rails.cache.fetch("countries_for_zone_#{zone_name}", :expires_in => 60.minutes) do
      Zone.find_by_name(zone_name).try(:country_list) || []
    end
  end
  
  def self.vat_zone
    Zone.find_by_name('EU_VAT')
  end

end