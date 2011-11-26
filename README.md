Spree Eu Vat
============

This extension tries to address the ongoing VAT handling issues in Spree. 

Conceptually, it does the exact opposite of the default VAT implementation:

- prices in Spree, as entered in the admin area, are now supposed to be VAT inclusive
- instead of thinking of _adding_ a percentage to the exclusive price, do nothing
- if a customer is from outside of the EU VAT zone, subtract the actual VAT amount

The original VAT calculator has been augmented to reflect this change in philosophy 
(a new Calculator could have been created instead).

To figure out if prices should be displayed as-is (VAT included) or without VAT,
the current visitor's country is checked against the VAT zone's member countries.

Implement Spree::BaseController#detect\_current\_country to deduce the current 
customer's country using your own strategies (geoip...).

The current visitor's country will be used up until the point where an actual
shipping address has been supplied during checkout. As per EU VAT rules, to
order from abroad with VAT excluded, the _shipping address_ has to be outside 
of the EU VAT Zone.

Additionally, by storing prices as-is (VAT included), the known unattainable 
pricing issues are resolved.

## Known Issues

Currently this extension feels more or less like a hack, but hopefully the
concept can be translated into spree core eventually. Specs are missing, needs
extensive testing!

Copyright (c) 2011 Fabien Franzen, released under the New BSD License
