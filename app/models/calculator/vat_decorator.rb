Calculator::Vat.class_eval do

  def self.tax_diff_on(taxable)
    taxable = taxable.product if taxable.respond_to?(:product)
    self.calculate_difference(taxable.price, taxable.effective_tax_rate)
  end
  
  def self.calculate_difference(amount, rate)    
    (amount * (1 - 1 / (1 + rate))).round(2, BigDecimal::ROUND_HALF_UP)
  end
  
  def self.calculate_addition(amount, rate)
    (amount * rate).round(2, BigDecimal::ROUND_HALF_UP)
  end
  
  def compute(order)
    rate = self.calculable
    tax = 0
    
    if rate.tax_category.is_default
      order.adjustments.each do | adjust |
        next if adjust.originator_type == "TaxRate"
        next if adjust.originator_type == "ShippingMethod" and not Spree::Config[:shipment_inc_vat]
        
        tax -= self.class.calculate_difference(adjust.amount, rate.amount)
      end
    end

    order.line_items.each do | line_item|
      if line_item.product.tax_category  # only apply this calculator to products assigned this rates category
        next unless line_item.product.tax_category == rate.tax_category
      else
        next unless rate.tax_category.is_default # and apply to products with no category, if this is the default rate
      end
      
      tax -= self.class.calculate_difference(line_item.price, rate.amount) * line_item.quantity
    end

    tax
  end
  
end
