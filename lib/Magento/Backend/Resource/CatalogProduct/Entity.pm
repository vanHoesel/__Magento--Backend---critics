package Magento::Backend::Resource::CatalogProduct::Entity;


our $VERSION = 0.02_01;

use Moose::Role;

with 'Magento::Backend::Resource::CatalogProduct';

has sku => ( # Product SKU
    is  => 'ro',
);

has name => ( # Product name
    is  => 'ro',
);

has set_id => ( # Product attribute set
    is  => 'ro',
    writer => 'set', # this is the attribute name returned by Magento
);

has type => ( # Type of the product
    is  => 'ro',
);

has category_ids => ( # Array of category IDs
    is  => 'ro',
    isa => 'ArrayRef[Int]',
);

has website_ids => ( # Array of website IDs
    is  => 'ro',
    isa => 'ArrayRef[Int]',
);

1;


__END__

=over 4

=item product_id

Product ID

=item sku

Product SKU

=item name

Product name

=item set_id

Product attribute set

NOTE:Magento returns I<set>, but it clearly is a I<set_id>

=item type

Type of the product

=item category_ids

Array of category IDs

=item website_ids

Array of website IDs

=back
