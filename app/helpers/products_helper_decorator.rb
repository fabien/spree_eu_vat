module ProductsHelper

  # returns the price of the product to show for display purposes
  def product_price(product_or_variant, options={})
    options.assert_valid_keys(:format_as_currency, :show_vat_text, :show_vat_excluded)
    options.reverse_merge! :format_as_currency => true, :show_vat_text => false, :show_vat_excluded => true

    amount = product_or_variant.price
    
    # prices are considered to be VAT inclusive already, show price excluding VAT if applicable
    if options.delete(:show_vat_excluded) === true && Spree::Config[:show_price_inc_vat] && !Country.current_country.in_vat_zone?
      amount -= Calculator::Vat.tax_diff_on(product_or_variant)
    end
    
    options.delete(:format_as_currency) ? format_price(amount, options) : number_with_precision(amount, :precision => 2)
  end

end
