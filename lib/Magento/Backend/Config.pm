package Magento::Config;

use Moose;

has username => (
    is  => 'ro',
);

has password => (
    is  => 'rw',
);

has host_url => (
    is  => 'rw',
);

1;