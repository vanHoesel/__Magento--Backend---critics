package Magento::Backend::Connector;

use Moose::Role;

has _backend => ( # holds a backreference
    is  => 'rw',
#    isa => 'Magento::Backend',
    default => sub { { } },
);

has settings => (
    is         => 'ro',
    isa        => "HashRef",
);

no Moose;

1; # Magneto::Base