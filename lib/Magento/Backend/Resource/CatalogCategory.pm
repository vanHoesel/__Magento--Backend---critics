package Magento::Backend::Resource::CatalogCategory;

our $VERSION = 0.02_01;

use Moose::Role;

with 'Magento::Backend::Resource';

has category_id => ( # Category ID
    is  => 'ro',
);

1;