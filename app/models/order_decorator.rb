Order.class_eval do
      
  def create_tax_charge!
    adjustments.tax.each { |e| e.destroy }
    
    price_includes_vat = Spree::Config[:show_price_inc_vat]
    country = ship_address && ship_address.country.is_a?(Country) ? ship_address.country : Country.current_country
    
    matching_rates   = TaxRate.match(Address.new(:country_id => country.id))
    matched_vat_rate = matching_rates.find { |rate| rate.zone.name == 'EU_VAT' }
    vat_rate         = TaxRate.by_zone(Zone.vat_zone.id).find { |rate| rate.zone.name == 'EU_VAT' }

    # price already includes VAT, address is in VAT zone - no adjustment necessary
    matching_rates.delete(matched_vat_rate) if price_includes_vat

    # price includes VAT, but it's not applicable for the current country, calculate the difference
    matching_rates << vat_rate if price_includes_vat && !country.in_vat_zone? && vat_rate
    
    matching_rates.each do |rate|
      rate.create_adjustment( "#{rate.calculator.description} #{rate.amount*100}%", self, self, true)
    end
  end
  
end