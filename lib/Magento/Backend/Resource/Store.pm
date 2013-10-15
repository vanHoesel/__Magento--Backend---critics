package Magento::Backend::Resource::Store;

use Moose::Role;

with 'Magento::Backend::Resource';

has store_id => ( # Store view ID
    is  => 'ro',
    isa => 'Int',
);

requires 'store_list';
requires 'store_info';
requires 'info';

1;
