Deface::Override.new(
  :virtual_path => "admin/products/_form",
  :name => "master_price_includes_vat",
  :replace => "code[erb-loud]:contains('f.label :price, t(:master_price)')",
  :text => "<%= f.label :price, I18n.t(:price_with_vat_included, :price => I18n.t(:price)) %>",
  :disabled => false)
  
Deface::Override.new(
  :virtual_path => "admin/products/_form",
  :name => "disable_price_including_vat_field",
  :replace => "code[erb-silent]:contains('if Spree::Config[:show_price_inc_vat]')",
  :text => "<% if false %>",
  :disabled => false)
  
Deface::Override.new(
  :virtual_path => "admin/variants/_form",
  :name => "price_includes_vat",
  :replace => "code[erb-loud]:contains('f.label :price')",
  :text => "<%= f.label :price, I18n.t(:price_with_vat_included, :price => I18n.t(:price)) %>",
  :disabled => false)