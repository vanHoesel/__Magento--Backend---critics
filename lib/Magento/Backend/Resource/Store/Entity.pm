package Magento::Backend::Resource::Store::Entity;

our $VERSION = 0.02_01;

use Moose::Role;

with 'Magento::Backend::Resource::Store';

has code => ( # Store view code
    is => 'ro',
);

has website_id => ( # Website ID
    is  => 'ro',
    isa => 'Int',
);

has group_id => ( # Group ID
    is  => 'ro',
    isa => 'Int',
);

has name => ( # Store name
    is => 'ro',
);

has sort_order => ( # Store view sort order
    is  => 'ro',
    isa => 'Int',
);

has is_active => ( # Defines whether the store is active
    is  => 'ro',
    isa => 'Int',
);

1;