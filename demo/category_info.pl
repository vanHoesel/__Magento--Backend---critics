use strict;
use warnings;

use Magento::Backend;
use Magento::Backend::Resource::CatalogProduct;

my %config = (
#    'Connector::Default' => "MISSING",
    'Connector::XMLRPC' => {
        host_url => "http://networkserver.boekhandel-lighthouse.nl/magento/index.php/api/xmlrpc",
        username => "GitHub_test_products_136",
        password => "GitHub_136!",
    },
    'Connector::DBI' => {
        dbi_handle => "dbi:CSV:f_dir=$ENV{HOME}/magento/",
#       username => "database_user",
#       password => "top-secret",
    },
    'Resource::CatalogProduct' => {
        connector => "XMLRPC",
        cachetime => 7 * 24 * 3600,
    },
);

my $backend = Magento::Backend->new(config => \%config);

print <<DEMO;

####
#### %category_info_NDEF = \$backend->catalogCategory_info(attributes => undef);
#### catalogCatagory_info returns a HASH;
####
DEMO

my %category_info_NDEF = $backend->catalogCategory_info(
    categoryID => 4336,
    attributes => undef,
);

printf "%-30s => %s\n", $_, $category_info_NDEF{$_} || '<undef>' 
    foreach (keys %category_info_NDEF);


print <<DEMO;

####
#### \$category_info_SOME = \$backend->catalogCategory_info(attributes => undef);
#### catalogCatagory_info returns a HASHREF;
####
DEMO

my $category_info_SOME = $backend->catalogCategory_info(
    categoryID => 4336,
    attributes => [ qw(category_id name display_mode children) ],
    storeView => 'winkel_en_uk',
);

printf "%-30s => %s\n", $_, $category_info_SOME->{$_} || '<undef>' 
    foreach (keys %$category_info_SOME);








__END__