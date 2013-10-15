package Magento::Backend::Resource::CatalogCategory::AssignedProduct;


our $VERSION = 0.02_01;

use Moose::Role;

with 'Magento::Backend::Resource::CatalogProduct';

has sku => ( # Product SKU
    is  => 'ro',
);

has set_id => ( # Product attribute set
    is  => 'ro',
    writer => 'set', # this is the attribute name returned by Magento
);

has type => ( # Type of the product
    is  => 'ro',
);

has position => ( # Position of the assigned product
    is  => 'ro',
    isa => 'Int',
);

1;
