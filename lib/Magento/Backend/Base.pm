package Magento::Backend::Base;

use Moose::Role;

# holds a reference to where this object came from
has _backend => (
    is  => 'rw',
#    isa => 'Magento::Backend',
    default => sub { { } },
);

1; # Magneto::Base