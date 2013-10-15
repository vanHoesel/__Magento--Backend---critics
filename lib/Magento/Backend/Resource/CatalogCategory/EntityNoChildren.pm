package Magento::Backend::Resource::CatalogCategory::EntityNoChildren;

our $VERSION = 0.02_01;

use Moose::Role;

with 'Magento::Backend::Resource::CatalogCategory';

has parent_id => ( # Parent category ID
    is  => 'ro',
);

has name => ( # Category name
    is  => 'ro',
);

has is_active => ( # Defines if a category is active
    is  => 'ro',
    isa => 'Int',
);

has position => ( # Category position at the level
    is  => 'ro',
    isa => 'Int',
);

has level => ( # Category level
    is  => 'ro',
    isa => 'Int',
);

1;