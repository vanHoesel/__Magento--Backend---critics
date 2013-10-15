package Magento::Backend::Resource::CatalogProduct;

our $VERSION = 0.02_01;

use Moose::Role;

with 'Magento::Backend::Resource';

has product_id => ( # Product ID
    is  => 'ro',
);

requires 'catalogProduct_list';
requires 'info';
requires 'catalogProduct_info';
requires 'update';
requires 'catalogProduct_update';

1;

__END__

=head1 NAME

Magento::Backend::Resource::CatalogProduct - Moose::Role

=head1 VERSION

0.02 beta

=head1 SYNOPSIS

Initialising

    use Magento::Backend;
    use Magento::Backend::Resource::CatalogProduct;
    
    my $backend = Magento::Backend->new(config => \%config);    

Creating a new product

    my $new_product = $backend->catalogProduct_create(
        productData =>{
            productSKU => "NEW0000",
            productType => "simple",
            setID => 1,
            name => "New Product",
            description => "new product created with Magento::Backend",
            short_description => "Magento::Backend New Product",
            price => 1.95,
            weight => 250,
            status => 1, # enabled
            visibility => 4,
            tax_class_id => 1,
        },
    );

Retrieving a filtered list of products from the C<$backend>

    my @list = $backend->catalogProduct_list(
        filter => {
            price  => {'lt' => 10.00},
            weight => {'gt' => 250.00},
        },
    );

Retrieving detailed info on a specified product from the C<$backend>

    my %info = $backend->catalogProduct_info(
        productSKU => $sku,
        attributes => [qw/name price weight/]),
        storeView  => 'en_uk',
    );

Updating the short description of a specified product from the C<$backend>

    my $status = $backend->catalogProduct_update(
        productSKU  => $sku,
        productData => {
            short_description => "this is an updated product description",
        },
    );

Raise the price with 10% for all products heavier than 500grs. (long wait)

    my $filter = {
        weight => {'gt' => 500},
    };
    foreach ($backend->catalogProduct_list(filter => $filter)) {
        $_->update(productData => {price => $_->get('price') * 1.10});
    };

=head1 DESCRIPTION

This is an abstract CatalogProduct class and defines the interface for it.

=head1 ATTRIBUTES

Although the object itself does not have any 'reasonable' attributes,
the C<< $product->info >> and C<< $backend->catalogProduct_info >> methodes
do return hashes with keys following below. These names are also used in other
method calls..

=over 1

=item product_id 

Product ID

=item sku 

Product SKU

=item set_id 

Product set_id

NOTE: the Magento API documentation refers to I<set>
where as this is clearly a I<set_id>

=item type 

Product type

=item created_at 

Date when the product was created

=item updated_at 

Date when the product was last updated

=item type_id 

Type ID

=item name 

Product name

=item description 

Product description

=item short_description 

Short description for a product

=item weight 

Product weight

=item status 

Status of a product

=item url_key 

Relative URL path that can be entered in place of a target path

=item url_path 

URL path

=item visibility 

Product visibility on the frontend

=item category_ids 

Array of category IDs

=item website_ids 

Array of website IDs

=item has_options 

Defines whether the product has options

=item gift_message_available 

Defines whether the gift message is available for the product

=item price 

Product price

=item special_price 

Product special price

=item special_from_date 

Date starting from which the special price is applied to the product

=item special_to_date 

Date till which the special price is applied to the product

=item tax_class_id 

Tax class ID

=item tier_price 

Array of catalogProductTierPriceEntity

=item meta_title 

Meta title

=item meta_keyword 

Meta keyword

=item meta_description 

Meta description

=item custom_design 

Custom design

=item custom_layout_update 

Custom layout update

=item options_container 

Options container

=item enable_googlecheckout 

Defines whether Google Checkout is applied to the product

=back

NOTE: the attributes I<categories> and I<websites> are removed.
Magento just returns ID's, which have their own attributes in the info.

TODO: provide instance methodes that wil return the apropiate objects.

=head1 METHODES

This module does not provide any methods on itself but describes a common
interface for Magento::Backend::Connectors. Any instance call on C<$backend>
will be cought by AUTOLOAD and dispatched to the proper resource-class for a
connector

=head2 $backend->catalogProduct_create
  (
  productData => \%createdata
  ...
  )

Allows you to create a new product and
returns a new C<Resource::CatalogProduct> object.

=over 4

=item productData => \%_updates

productData takes a hash whose keys are the attribute-names
and the values are the initial values.
 
NOTE: the attributes below are mandetory:

=over

=item productSKU => $sku

Product SKU

=item productType => $type

The type of the product, usually 'simple'.

=item setID => $set_id

The set_id of the C<CatalogProduct::AtrributeSet>

=item name => $product_name

Product Name

=item description => $text

Product description

=item short_description => $text

Product short description

=item price => $float

Product price

=item weight => $float

Product weight

=item visibility => $visibility_code

Product visibility on the frontend

=item status => $enabled

Product status

=back

See the L<Attributes> above for the complete list of default attributes.
Other attributes that are part of the C<setID> can be initialised here as well,
unlike what many authors and developers on PHP have to go through.

=item storeView => $store_id | $code

Setting this parameter will only affect the values to the scope specified.
This can either be ID for the shop or the code as being defined in
L<Magento::Backend::Resource::Store>

=back

=over 4

=item I<SCALAR> context or I<LIST> context

returns a new C<Resource::CatalogProduct> object on succes.

=back

=head2 $backend->catalogProduct_list
  (
  ...
  )

Allows you to retrieve the list of products using filters.

=over 4

=item filter => \%filters

Allows you to filter out specific products from the result list.
This can be used to find a specific product or search for values in names.
See L<about using filters|Magento::Backend::Manual::Filters> for more details.

When not applying any filters... you end up with ALL products,
probbably not what you want

=item storeView => $store_id | $code

optional

Setting this parameter will return values for specific web-shop frontends.
This can either be ID for the shop or the code as being defined in
L<Magento::Backend::Resource::Store>

=back

=over 4

=item I<LIST> context

returns an array of the opaque C<< M::B::R::CatalogProduct::Entity >> class
or a subclass there of.

=item I<SCALAR> context

returns an ArrayRef to the formentioned array.

=back

=head2 $product->info
  (
  attributes => \@requested,
  ...
  )

Allows you to retrieve information about the product.

See below for more detailed information about the parameters
and the returned value(s).

=head2 $backend->catalogProduct_info
  (
  productSKU => $sku,
  attributes => \@requested,
  ...
  )

Allows you to retrieve information about the product specified by
productSKU.

=over 4

=item productSKU => $sku

The SKU for the product inquiry.
If you must, you can use C<< productID => $product_id >> instead.

=item attributes => \@requested

This is the list of attribute names that are being requested.
C<undef> will return all attributtes (default and additional).

NOTE: Unlike the Magento API documentation, this is a required parameter,
leaving out this parameter, obfiously means you are not interested in any.
Makes it more or less a required attribute.

NOTE: If this paramter is not provided, an empty hash will be returned,
This behaviour might cause warnings in future releases.

=item storeView => $store_id | $code

Setting this parameter will return values for specific web-shop frontends.
This can either be ID for the shop or the code as being defined in
L<Magento::Backend::Resource::Store>

=back

=over 4

=item I<LIST> context

returns a hash that holds the information being retrieved.

=item I<SCALAR> context

returns a HashRef to the formentioned hash.

=back

=head2 $product->get
  (
  $attribute_name,
  ...
  )

Gets the value for a given attribute-name for the product.

See below for more detailed information about the parameters
and the returned value(s).

=head2 $backend->catalogProduct_get
  (
  $attribute_name,
  productSKU => $sku,
  ...
  )

Gets the value for a given attribute-name for a product specified by
productSKU.

=over

=item $attribute_name

B<Must> be the first argument, as a string.

The name of the attribute for wich the value is requested.

=item productSKU => $sku

The SKU for the product inquiry.
If you must, you can use C<< productID => $product_id >> instead.

=item storeView => $store_id | $code

Setting this parameter will return values for specific web-shop frontends.
This can either be ID for the shop or the code as being defined in
L<Magento::Backend::Resource::Store>

=back

=over 4

=item I<SCALAR> context

Returns the value for the reuested attribute.

If the value is an array, an ArrayRef will be returned.

=back

=head2 $product->update
  (
  productData => \%updates,
  ...
  )

Allows you to update the product.

See below for more detailed information about the parameters
and the returned value(s).

=head2 $backend->catalogProduct_update
  (
  productSKU => $sku,
  productData => \%updates,
  ...
  )

Allows you to update the product specified by
productSKU.

=over 4

=item productSKU => $sku

The SKU for the product inquiry.
If you must, you can use C<< productID => $product_id >> instead.

=item productData => \%_updates

productData takes a hash whose keys are the attribute-names
and the values are the new to assing values.
 
NOTE: You should specify only those attributes which you want to be updated.

NOTE: If this paramter is not provided, there is nothing to be update.
In future release this might raise an exception.

=item storeView => $store_id | $code

Setting this parameter will only affect the values to the scope specified.
This can either be ID for the shop or the code as being defined in
L<Magento::Backend::Resource::Store>

=back

=over 4

=item I<SCALAR> context or I<LIST> context

returns 1 on succes, or 0 on failure.

=back

=head1 CAVEATS

Different methods in other packages may return lists or array refferences of
products. However the likelyhood is that due to the nature of the Magento API
that these results are not interchangable. If one gets back a list from e.g.
catalogCategory->assignedProducts, it will have different subclass then from
cartProduct->list. The results are from diffents subclasses.

=head1 DISCLAIMER

This software is as is, and does not do any pre-checks or error processing.

B<Use at your own risk!>

=head1 AUTHOR

Theo van Hoesel

=over 4

=item Send-a-Newbie - YAPC::EU::2013 Kiev

=item proudly sponsered by the community

=cut

#=item L<Enlightened Perl Organisation|http://www.send-a-newbie.enlightenedperl.org>

=item L<http://www.send-a-newbie.enlightenedperl.org>

=back

=head1 COPYRIGHT

Copyright 2013 Th.J. van Hoesel

=head1 SEE ALSO

=over 4

=item Magento API - Catalog Product

L<http://www.magentocommerce.com/api/soap/catalog/catalogProduct/catalogProduct.html>

=back

=cut
